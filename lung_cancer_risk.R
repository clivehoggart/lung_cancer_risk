surv <- function (a, b, t){
    return(exp(-(t/b)^a))
}

preds1yr <- function(coefficients, no.strata, strat, x, t0, t1){
  ptr = length(coefficients) - 2 * no.strata + 1
#  print(no.strata)
  scale = exp(coefficients[ptr + 2 * strat])
  shape = exp(coefficients[ptr + 1 + 2 * strat])
  eta = exp(x %*% as.matrix(coefficients[1]))
  surv0 = surv(shape, scale, t0)^eta
  surv1 = surv(shape, scale, t1)^eta
  preds = 1 - surv1/surv0
  return(preds)
}

pred.lung <- function(age.start, age.stop=NA, smoke.intensity, age, future){
  cancer.coef <- list()
  death.coef <- list()
  death.coef[[1]] <-
    structure(c(0.0497334248502077, 3.55648072436567, 1.06720489869378,
                3.6539751362696, 1.15371702125457, 3.7538512176694, 1.39759679410716,
                3.85215419230326, 1.61753628446848, 3.8941853221273, 1.76494361564664,
                3.97038438443542, 1.7064828144805, 4.02813796901623, 1.68507399508813,
                3.9911605513775, 1.77220202699027),
              .Names = c("I(smoke.intensity1[ptr.para.train] - m1.si)",
                "log(scale):1", "log(shape):1", "log(scale):2", "log(shape):2",
                "log(scale):3", "log(shape):3", "log(scale):4", "log(shape):4",
                "log(scale):5", "log(shape):5", "log(scale):6", "log(shape):6",
                "log(scale):7", "log(shape):7", "log(scale):8", "log(shape):8"
                ))
  cancer.coef[[1]] <-
    structure(c(0.105300795832441, 3.71089919130649, 0.852161833601267,
                3.98527881094169, 0.918647437432171, 4.1955855271372, 1.1320447151923,
                4.32346200947243, 1.35190627380925, 4.38108611907825, 1.50180146276114,
                4.58158339459744, 1.36101222806519, 4.50795134641537, 1.4611319541903,
                4.49095233611757, 1.54513390357127),
              .Names = c("I(smoke.intensity1[ptr.para.train] - m1.si)",
                "log(scale):1", "log(shape):1", "log(scale):2", "log(shape):2",
                "log(scale):3", "log(shape):3", "log(scale):4", "log(shape):4",
                "log(scale):5", "log(shape):5", "log(scale):6", "log(shape):6",
                "log(scale):7", "log(shape):7", "log(scale):8", "log(shape):8"
                ))

  death.coef[[2]] <-
    structure(c(0.0146138105962148, 3.75370491900608, 1.21021742069539,
                3.74998885234275, 1.51083543378702, 3.79984452695044, 1.66896936060549,
                4.00838721077074, 1.62087700550062, 3.97460279229997, 1.74205578484038,
                3.95395098492439, 1.83468938242662, 3.92761116315544, 2.12881536998591,
                3.98242371455035, 2.15016768858572, 4.12280921985669, 1.76921697262048,
                4.058406607892, 1.86524554344458, 4.01980232472935, 2.14782402136811,
                3.99888251712498, 2.35990075878192, 4.04132143575613, 2.49021015463508
                ),
              .Names = c("I(smoke.intensity1[ptr.para.train] - m1.si)",
                "log(scale):1", "log(shape):1", "log(scale):2", "log(shape):2",
                "log(scale):3", "log(shape):3", "log(scale):4", "log(shape):4",
                "log(scale):5", "log(shape):5", "log(scale):6", "log(shape):6",
                "log(scale):7", "log(shape):7", "log(scale):8", "log(shape):8",
                "log(scale):9", "log(shape):9", "log(scale):10", "log(shape):10",
                "log(scale):11", "log(shape):11", "log(scale):12", "log(shape):12",
                "log(scale):13", "log(shape):13"))
  cancer.coef[[2]] <-
    structure(c(0.0421816490792434, 4.98747928438502, 0.749552709904855,
                4.72262764242336, 0.819125848799031, 4.32129835293171, 1.03204084125304,
                5.17911057852726, 1.16537092077197, 4.78607649056875, 1.35255159625575,
                4.6513388789715, 1.46038912513724, 4.65449208579059, 1.3184977974638,
                4.36584035129453, 1.66218438651171, 5.56285237040325, 1.08825381314342,
                4.68020036295561, 1.70540170664898, 4.49078675078577, 1.87859825466287,
                4.2409257969678, 2.33568646039517, 4.17698414921231, 2.57368565697632
                ),
              .Names = c("I(smoke.intensity1[ptr.para.train] - m1.si)",
                "log(scale):1", "log(shape):1", "log(scale):2", "log(shape):2",
                "log(scale):3", "log(shape):3", "log(scale):4", "log(shape):4",
                "log(scale):5", "log(shape):5", "log(scale):6", "log(shape):6",
                "log(scale):7", "log(shape):7", "log(scale):8", "log(shape):8",
                "log(scale):9", "log(shape):9", "log(scale):10", "log(shape):10",
                "log(scale):11", "log(shape):11", "log(scale):12", "log(shape):12",
                "log(scale):13", "log(shape):13"))

  current <- is.na(age.stop)
  if( current[1] ){
    smoke.intensity <- ifelse(smoke.intensity<15, smoke.intensity, 15) - 11.27674
    ptr <- 1
    no.strata <- 8
    strat = ifelse( age.start > 18, 1, 0 )
    strat = ifelse( age.start > 20, 2, strat )
    strat = ifelse( age.start > 22, 3, strat )
    strat = ifelse( age.start > 24, 4, strat )
    strat = ifelse( age.start > 26, 5, strat )
    strat = ifelse( age.start > 28, 6, strat )
    strat = ifelse( age.start > 30, 7, strat )
  }
  if( !current[1] ){
    smoke.intensity <- ifelse(smoke.intensity<15, smoke.intensity, 15) - 10.27171
    ptr <- 2
    no.strata <- 13
    duration <- age.stop - age.start

    strat <- ifelse( age.start <= 22 & duration <= 20, 0, NA )
    strat <- ifelse( age.start <= 22 & duration > 20, 1, strat )
    strat <- ifelse( age.start <= 22 & duration > 30, 2, strat )

    strat <- ifelse( 22 < age.start & age.start <= 26 & duration <= 20, 3, strat )
    strat <- ifelse( 22 < age.start & age.start <= 26 & duration > 20, 4, strat )
    strat <- ifelse( 22 < age.start & age.start <= 26 & duration > 36, 5, strat )
    strat <- ifelse( 22 < age.start & age.start <= 26 & duration > 30, 6, strat )
    strat <- ifelse( 22 < age.start & age.start <= 26 & duration > 42, 7, strat )

    strat <- ifelse( 26 < age.start & duration <= 20, 8, strat )
    strat <- ifelse( 26 < age.start & duration > 20, 9, strat )
    strat <- ifelse( 26 < age.start & duration > 36, 10, strat )
    strat <- ifelse( 26 < age.start & duration > 30, 11, strat )
    strat <- ifelse( 26 < age.start & duration > 42, 12, strat )
  }

  q.yr <- rep(1,length(age.start))
  preds.cum <- rep(0,length(age.start))
  t0 <- age-35
#  print(c(strat,ptr))
  for( k in 0:(future-1) ){
#    print( c(no.strata, strat, smoke.intensity, t0+k, t0+k+1))
    preds.yr.cancer = preds1yr( cancer.coef[[ptr]], no.strata, strat, smoke.intensity, t0+k, t0+k+1 )
    preds.yr.death = preds1yr( death.coef[[ptr]], no.strata, strat, smoke.intensity, t0+k, t0+k+1 )
#    print(c(preds.yr.cancer,preds.yr.death))
    preds.yr <- preds.yr.cancer*(1-preds.yr.death)
    preds.cum <- preds.cum + preds.yr*q.yr
    q.yr <- q.yr*(1-preds.yr.death)*(1-preds.yr.cancer)
  }
  return(preds.cum)
}
