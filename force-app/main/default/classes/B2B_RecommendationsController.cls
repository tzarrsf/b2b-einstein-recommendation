/**
 * @description recommendations products
 */
public with sharing class B2B_RecommendationsController {
  @AuraEnabled
  /**
   * @description retrieve recommendation products
   * @param input GetRecommendationsInput model
   * @return return string to json
   */
  public static String getRecommendations(GetRecommendationsInput input) {
    String orgDomain = Url.getOrgDomainUrl().toExternalForm();
    String endpoint =
      orgDomain +
      '/services/data/v57.0/commerce/webstores/' +
      input.webstoreId +
      '/ai/recommendations?language=en-US&asGuest=false&recommender=' +
      input.recommender;
    if (String.isNotBlank(input.anchorValues)) {
      endpoint += '&anchorValues=' + input.anchorValues;
    }

    HttpRequest req = new HttpRequest();
    req.setEndpoint(endpoint);
    req.setHeader('Cookie', input.cookie);
    req.setMethod('GET');
    req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId()); //NOPMD

    Http http = new Http();
    HTTPResponse res = http.send(req);
    return res.getBody();
  }

  /**
   * @description getRecommendations model class
   */
  public class GetRecommendationsInput {
    /**
     * @description WebStore Id
     */
    @AuraEnabled
    public String webstoreId { get; set; }

    /**
     * @description Recommender name
     */
    @AuraEnabled
    public String recommender { get; set; }

    /**
     * @description Anchor values
     */
    @AuraEnabled
    public String anchorValues { get; set; }

    /**
     * @description Cookie
     */
    @AuraEnabled
    public String cookie { get; set; }
  }
}
