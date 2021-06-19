#' @title Data on the social consequences of COVID-19 conspiracy beliefs
#' 
#' @description Data from Study 1 in \insertCite{srol2021social}{BBcor} examining effects 
#' of prejudice and descrimination on COVID-19 conspiracy beliefs
#' 
#' @format A data frame with 501 rows and 24 variables
#'
#' * \code{id}: participant id
#' * \code{gender}: participants' indicated gender (1 = "male", 2 = "female")
#' * \code{age}: participants' indicated age
#' * \code{education}: participants' indicated highest attained education level(1 = "elementary education", 2 = "high school without diploma", 3 = "high school with diploma", 4 = "undergraduate college degree", 5 = "graduate college degree", 6 = "doctoral degree")
#' * \code{combined_covid_conspiracy}: average rating on 12 items of both generic and China-specific COVID-19 conspiracy beliefs
#' * \code{china_covid_conspiracy}:  average rating on 4 items of China-specific COVID-19 conspiracy beliefs
#' * \code{generic_covid_conspiracy}: average rating on 8 items of generic COVID-19 conspiracy beliefs
#' * \code{generic_covid_conspiracy_wo_hoax}: average rating on 7 items of generic COVID-19 conspiracy beliefs (without the hoax theory item)
#' * \code{combined_covid_conspiracy_wo_hoax}:  average rating on 11 items of both generic and China-specific COVID-19 conspiracy beliefs (without the hoax theory item)
#' * \code{neg_feelings_italy}:score on a feeling thermometer (higher score = more negative feelings) toward Italian people/ 0-100
#' * \code{neg_feelings_china}:score on a feeling thermometer (higher score = more negative feelings) toward Chinese people/ 0-100
#' * \code{neg_feelings_roma}: score on a feeling thermometer (higher score = more negative feelings) toward Roma people/ 0-100
#' * \code{social_distance_italy}: average rating on three items of social distance toward Italian people
#' * \code{social_distance_china}: average rating on three items of social distance toward Chinese people
#' * \code{social_distance_roma}: average rating on three items of social distance toward Roma people
#' * \code{discrimination_italy}: rating on one discrimination item for Italian people
#' * \code{discrimination_china}: rating on one discrimination item for Chinese people
#' * \code{discrimination_roma}: rating on one discrimination item for Roma people
#' * \code{italy_composite}: composite average of 5 z-scores (feeling thermometer, 3 social distance items, and discrimination) for Italian people
#' * \code{china_composite}: composite average of 5 z-scores (feeling thermometer, 3 social distance items, and discrimination) for Chinese people
#' * \code{roma_composite}: composite average of 5 z-scores (feeling thermometer, 3 social distance items, and discrimination) for Roma people
#' * \code{information_exposure}: average rating on the 3 items of exposure to information about COVID-19 pandemic
#' * \code{anxiety}: average rating on the 4 items related to feelings of anxiety]
#' * \code{lack_of_control}: average rating on the 4 items related to the feeling of lack of control
#' 
#' @md
#' 
#' @details Further details can be found at \href{https://osf.io/jkab7/}{https://osf.io/jkab7/}
#' @usage data("srol2021")
#' @references 
#' \insertAllCited{}
"srol2021"