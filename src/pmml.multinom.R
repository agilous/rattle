# PMML: Predictive Modelling Markup Language
#
# Part of the Rattle package for Data Mining
#
# Time-stamp: <2009-08-18 19:45:31 Graham Williams>
#
# Copyright (c) 2009 Togaware Pty Ltd
#
# This files is part of the Rattle suite for Data Mining in R.
#
# Rattle is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# Rattle is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Rattle. If not, see <http://www.gnu.org/licenses/>.

########################################################################
# multinom PMML exporter
#
# 081103 Decide to target Regression (rather than GeneralRegression)
# to reuse as much as possible. This means it will have multiple
# RegressionTables.

# This might just become a variation of the lm code in which case
# there could be a possibility of merging it into that. But there are
# some sublte differences.

pmml.multinom <- function(model,
                          model.name="multinom_Model",
                          app.name="Rattle/PMML",
                          description="Multinomial Logistic Model",
                          copyright=NULL,
                          transforms=NULL,
                          ...)
{
  if (! inherits(model, "multinom")) stop("Not a legitimate multinom object")
  require(XML, quietly=TRUE)
  require(nnet, quietly=TRUE)

  # Collect the required variables information.

  terms <- attributes(model$terms)
  field <- NULL
  field$name <- names(terms$dataClasses)
  orig.names <- field$name
  number.of.fields <- length(field$name)
  field$class <- terms$dataClasses
  orig.class <- field$class

   # 090216 Support transforms if available.
  
  if (supportTransformExport(transforms))
  {
    field <- unifyTransforms(field, transforms)
    transforms <- activateDependTransforms(transforms)
  }
  number.of.fields <- length(field$name)
 
  target <- field$name[1]
  numfac <- 0
  for (i in 1:number.of.fields)
  {
    if (field$class[[field$name[i]]] == "factor")
    {
      numfac <- numfac + 1
      if (field$name[i] == target){
        field$levels[[field$name[i]]] <- model$lev
      }
      else{
        field$levels[[field$name[i]]] <- model$xlevels[[field$name[i]]]
    }
  }
    #Tridi 2/16/12: remove any 'as.factor' from field names
    if (length(grep("^as.factor\\(", field$name[i])))
    {
     field$name[i] <- sub("^as.factor\\((.*)\\)", "\\1", field$name[i])
     names(field$class)[i] <- sub("^as.factor\\((.*)\\)", "\\1", names(field$class)[i])
     names(field$levels)[numfac] <- sub("^as.factor\\((.*)\\)", "\\1", names(field$levels)[numfac])
    }
  }
  target <- field$name[1]
  # PMML

  pmml <- pmmlRootNode("4.0")

  # PMML -> Header

  pmml <- append.XMLNode(pmml, pmmlHeader(description, copyright, app.name))
  
  # PMML -> DataDictionary
  
  pmml <- append.XMLNode(pmml, pmmlDataDictionary(field))

  # PMML -> RegressionModel

  # as.character(model$call[[1]]) == "multinom"
  
  the.model <- xmlNode("RegressionModel",
                       attrs=c(modelName=model.name,
                         functionName="classification",
                         algorithmName=as.character(model$call[[1]]),
                         normalizationMethod="softmax"))

  # PMML -> RegressionModel -> MiningSchema
  
  the.model <- append.XMLNode(the.model, pmmlMiningSchema(field, target))

  #########################################
  #  OUTPUT
  the.model <- append.XMLNode(the.model, pmmlOutput(field,target))


  # PMML -> TreeModel -> LocalTransformations -> DerivedField -> NormContiuous

  if (supportTransformExport(transforms))
    the.model <- append.XMLNode(the.model, pmml.transforms(transforms))

  LTNode <- xmlNode("LocalTransformations")
  
  # PMML -> RegressionModel -> RegressionTable
  
  coeff <- coefficients(model)
  # Handle special binary case
  if(length(model$lev) == 2)
  {
    l <- length(coefficients(model))
    coeff <- array(dim=c(1,l))
    colnames(coeff) <- names(coefficients(model))
    rownames(coeff) <- model$lev[2] 
    for(i in 1:l)
     coeff[1,i] = coefficients(model)[i]
  }
  coeffnames <- colnames(coeff)
  targetnames <- rownames(coeff)

  # Construct LocalTransformations to define a multiplicative term, if used.
  LTAdd <- FALSE
  #ignore the 1st column (intercept)
  for (i in 2:ncol(coeff))
  {
    name <- coeffnames[i]
    if (name == target) next
    if(length(grep(".+:.+",name)) == 1){
      for(j in 1:length(strsplit(name,":")[[1]]))
      {
        spltname <- strsplit(name,":")[[1]][j]
        if(length(grep("^as.factor\\(", spltname))==1)
        {
          LTAdd <- TRUE
          facLesName <- gsub("^as.factor\\(","",spltname)
          dFieldName <- paste(strsplit(facLesName,")")[[1]][1],strsplit(facLesName,")")[[1]][2])
          dvf <- xmlNode("DerivedField",attrs=c(name=dFieldName,optype="continuous",
                         dataType="double"))
          dvNode <- xmlNode("NormDiscrete",attrs=c(field=strsplit(oname,")")[[1]][1],
                            value=strsplit(oname,")")[[1]][2]))
          dvf <- append.XMLNode(dvf,dvfNode)
          LTNode <- append.xmlNode(LTNode,dvf)
        }
        for (k in 2:length(orig.names))
        {
          if((field$class[[field$name[k]]]=="factor") && length(grep(field$name[k],spltname)==1))
          {
            LTAdd <- TRUE
            fldValName <- gsub(field$name[k],"",spltname)
            dvf <- xmlNode("DerivedField",attrs=c(name=spltname,optype="continuous",
                                                          dataType="double"))
            dvNode <- xmlNode("NormDiscrete",attrs=c(field=field$name[k],value=fldValName))
            dvf <- append.XMLNode(dvf,dvNode)
            LTNode <- append.XMLNode(LTNode,dvf)
          } 
       }
      }
    } 
  }
  if(LTAdd)
    the.model <- append.XMLNode(the.model,LTNode)

  for (k in 1:nrow(coeff))
  {
    reg.table <- xmlNode("RegressionTable",
                         attrs=c(intercept=as.numeric(coeff[k, 1]),
                           targetCategory=targetnames[k]))
  #ignore the 1st column (intercept)
  for (j in 2:ncol(coeff))
    {
    name <- coeffnames[j]
      if (name == target) next
    if(length(grep(".+:.+",name)) == 1){
    } else if(length(grep("^as.factor\\(", name))==1) 
      {
    } else 
    {
# all numeric factors
      for (i in 2:length(orig.names))
      {
        if((field$class[[field$name[i]]]=="numeric") && length(grep(field$name[i],name)==1))
        {
          predictor.node <- xmlNode("NumericPredictor",
                                   attrs=c(name=name,exponent="1",
                    coefficient=as.numeric(coeff[k, which(coeffnames==name)])))
        reg.table <- append.XMLNode(reg.table, predictor.node)
      }
    }
    }
  }
#now find all categorical terms
  #ignore the 1st column (intercept)
  for (j in 2:ncol(coeff))
   {
    name <- coeffnames[j]
     if (name == target) next
    if(length(grep(".+:.+",name)) == 1)
      {
    } else if(length(grep("^as.factor\\(", name))==1) 
        {
    } else 
    {
      for (i in 2:length(orig.names))
      {
        if((field$class[[field$name[i]]]=="factor") && length(grep(field$name[i],name)==1))
        {
          predictor.node <- xmlNode("CategoricalPredictor",attrs=c(name=field$name[i],
                                    value=gsub(field$name[i],"",name), 
                                    coefficient=as.numeric(coeff[k,which(coeffnames==name)])))
          reg.table <- append.XMLNode(reg.table, predictor.node)
        }
      }
    }
  }
#now all the numerical terms forced into categorical
  #ignore the 1st column (intercept)
  for (j in 2:ncol(coeff))
  {
    name <- coeffnames[j]
    if (name == target) next
    if(length(grep(".+:.+",name)) == 1){
    } else if(length(grep("^as.factor\\(", name))==1) 
    {
    # sometimes numeric variables forces into categorical variables have the
    # category appended to field names: ie as.factor(field) with possible values
    # 1,2,...  becomes as.factor(field)1  as.factor(field)2 etc
      oname <- gsub("^as.factor\\(","",name)
          predictor.node <- xmlNode("CategoricalPredictor",
                                 attrs=c(name=strsplit(oname,")")[[1]][1],
                                 value=strsplit(oname,")")[[1]][2],
                                 coefficient=as.numeric(coeff[k, which(coeffnames==name)])))

          reg.table <- append.XMLNode(reg.table, predictor.node)
        }
      }
#now the interactive terms
  for (j in 2:ncol(coeff))
  {
    name <- coeffnames[j]
    if (name == target) next
    if(length(grep(".+:.+",name)) == 1)
    {
    # assume ':' in the middle of an expression means interactive variables
      cval <- as.numeric(coeff[k,which(coeffnames==name)])
      predictorNode <- xmlNode("PredictorTerm",attrs=c(coefficient=cval))
      for(i in 1:length(strsplit(name,":")[[1]]))
      {
        spltname <- strsplit(name,":")[[1]][i]

        if(length(grep("^as.factor\\(", spltname))==1)
        {
          facLessName <- gsub("^as.factor\\(","",spltname)
          dField <- paste(strsplit(facLessName,")")[[1]][1],strsplit(facLessName,")")[[1]][2])
          fNode <- xmlNode("FieldRef",attrs=c(field=dField))
          predictorNode <- append.XMLNode(predictorNode,fNode)
    }
        for (l in 2:length(orig.names))
        {
          if((field$class[[field$name[l]]]=="factor") && length(grep(field$name[l],spltname)==1))
          {
            fNode <- xmlNode("FieldRef",attrs=c(field=spltname))
            predictorNode <- append.XMLNode(predictorNode,fNode)
          } else if((field$class[[field$name[l]]]=="numeric") && length(grep(field$name[l],spltname)==1))
          {
            fNode <- xmlNode("FieldRef",attrs=c(field=spltname))
            predictorNode <- append.XMLNode(predictorNode,fNode)
          }
        }
      }
      reg.table <- append.XMLNode(reg.table,predictorNode)
    } 
  }

    the.model <- append.XMLNode(the.model, reg.table)
  }


  # Add a regression table for the base case.
  #lab is null for binary case
  basename <- setdiff(model$lev, targetnames)
  the.model <- append.XMLNode(the.model,
                              xmlNode("RegressionTable",
                                      attrs=c(intercept="0.0",
                                        targetCategory=basename)))

  # Add to the top level structure.
  
  pmml <- append.XMLNode(pmml, the.model)
  
  return(pmml)
}
