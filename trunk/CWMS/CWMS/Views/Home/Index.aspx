<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ************************************************************************************************** -->
<!-- **   1-07. CONTACT FORM                                                                         ** -->
<!-- ************************************************************************************************** --> 
               
        <!-- CONTENT CELL -->                
        <a id="anchor-contact-1"></a>
        <div class="corner-content-1col-top"></div>                        
        <div class="content-1col-nobox">
          <h1 class="contact">1-07. Contact form</h1>
          <div class="contactform">
            <form method="post" action="index.html">
              <fieldset><legend>&nbsp;CONTACT DETAILS&nbsp;</legend>
                <p><label for="contact_title_1" class="left">Title:</label>
                   <select name="contact_title" id="contact_title_1" class="combo">
                     <option value="choose"> Select... </option>
                     <option value="mrs"> Mrs. </option>
                     <option value="mr"> Mr. </option>
                     <option value="dr"> Dr. </option></select></p>
                <p><label for="contact_firstname_1" class="left">First name:</label>
                   <input type="text" name="contact_firstname" id="contact_firstname_1" class="field" value="" tabindex="1" /></p>
                <p><label for="contact_familyname_1" class="left">Family name:</label>
                   <input type="text" name="contact_familyname" id="contact_familyname_1" class="field" value="" tabindex="1" /></p>
                <p><label for="contact_street_1" class="left">Street:</label>
                   <input type="text" name="contact_street" id="contact_street_1" class="field" value="" tabindex="1" /></p>
                <p><label for="contact_postalcode_1" class="left">Postal code:</label>
                   <input type="text" name="contact_postalcode" id="contact_postalcode_1" class="field" value="" tabindex="1" /></p>
                <p><label for="contact_city_1" class="left">City:</label>
                   <input type="text" name="contact_city" id="contact_city_1" class="field" value="" tabindex="1" /></p>
                <p><label for="contact_country_1" class="left">Country:</label>
                   <select name="contact_country" id="contact_country_1" class="combo">
                     <option value="choose"> Select... </option>
                     <option value="Sweden"> Sweden </option>
                     <option value="United States"> United States </option>
                     <option value="China"> China </option></select></p>
                <p><label for="contact_phone_1" class="left">Phone:</label>
                   <input type="text" name="contact_phone" id="contact_phone_1" class="field" value="" tabindex="2" /></p>
                <p><label for="contact_email_1" class="left">Email:</label>
                   <input type="text" name="contact_email" id="contact_email_1" class="field" value="" tabindex="2" /></p>
                <p><label for="contact_url_1" class="left">Website:</label>
                   <input type="text" name="contact_url" id="contact_url_1" class="field" value="" tabindex="3" /></p>
              </fieldset>
              <fieldset><legend>&nbsp;MESSAGE DETAILS&nbsp;</legend>
                <p><label for="contact_subject_1" class="left">Subject:</label>
                   <input type="text" name="contact_subject" id="contact_subject_1" class="field" value="" tabindex="4" /></p>
                <p><label for="contact_urgency_1" class="left">Please reply:</label>
                   <select name="contact_urgency" id="contact_urgency_1" class="combo">
                     <option value="choose"> Select... </option>
                     <option value="today"> Latest today </option>
                     <option value="tomorrow"> Latest tomorrow </option>
                     <option value="threedays"> Latest in 3 days </option>
                     <option value="week"> Latest in a week </option>
                     <option value="month"> Latest in a month </option></select></p>
                <p><label for="contact_message_1" class="left">Message:</label>
                   <textarea name="contact_message" id="contact_message_1" cols="45" rows="10" tabindex="5"></textarea></p>
                <p><input type="submit" name="submit" id="submit_1" class="button" value="Send message" tabindex="6" /></p>
              </fieldset>
            </form>
          </div>              
        </div> 
        <div class="corner-content-1col-bottom"></div>
</asp:Content>
