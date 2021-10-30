package com.polsl.factoringcompany.registration.passwordreset;

import com.polsl.factoringcompany.registration.email.EmailSender;
import com.polsl.factoringcompany.registration.token.ConfirmationTokenEntity;
import com.polsl.factoringcompany.registration.token.ConfirmationTokenService;
import com.polsl.factoringcompany.user.UserEntity;
import com.polsl.factoringcompany.user.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@AllArgsConstructor
public class PasswordResetService {

    private final UserService userService;
    private final ConfirmationTokenService confirmationTokenService;
    private final EmailSender emailSender;

    private static final String link = "http://localhost:3000/password/reset/change?token=";

    public String resetPassword(String email) {

        UserEntity userEntity = userService.getUSerByEmail(email);

        String token = UUID.randomUUID().toString();
        ConfirmationTokenEntity confirmationTokenEntity = new ConfirmationTokenEntity(
                token,
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(30),
                userEntity);

        confirmationTokenService.saveConfirmationToken(confirmationTokenEntity);

        String apiUrl = link + token;
        emailSender.send(
                email,
                buildEmail(apiUrl));
        return link + token;

    }

    @Transactional
    public String confirm(PasswordResetRequest passwordResetRequest) {
        ConfirmationTokenEntity confirmationTokenEntity =
                confirmationTokenService.getToken(passwordResetRequest.getToken());


        if (confirmationTokenEntity.getConfirmedAt() != null) {
            throw new IllegalStateException("password already changed");
        }

        LocalDateTime expiredAt = confirmationTokenEntity.getExpiresAt().toLocalDateTime();

        if (expiredAt.isBefore(LocalDateTime.now())) {
            throw new IllegalStateException("token expired");
        }

        confirmationTokenService.setConfirmedAt(passwordResetRequest.getToken());
        userService.updateUsersPassword(Long.valueOf(confirmationTokenEntity.getUserId()), passwordResetRequest.getPassword());
        return "confirmed";
    }


    private String buildEmail(String link) {
        return ("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
                "    <html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n" +
                "    <head>\n" +
                "    <!--[if gte mso 9]>\n" +
                "    <xml>\n" +
                "      <o:OfficeDocumentSettings>\n" +
                "        <o:AllowPNG/>\n" +
                "        <o:PixelsPerInch>96</o:PixelsPerInch>\n" +
                "      </o:OfficeDocumentSettings>\n" +
                "    </xml>\n" +
                "    <![endif]-->\n" +
                "      <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
                "      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
                "      <meta name=\"x-apple-disable-message-reformatting\">\n" +
                "      <!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->\n" +
                "      <title></title>\n" +
                "        <style type=\"text/css\">\n" +
                "            table, td { color: #000000; } a { color: #0000ee; text-decoration: underline; }\n" +
                "            @media only screen and (min-width: 570px) {\n" +
                "      .u-row {\n" +
                "                    width: 550px !important;\n" +
                "                }\n" +
                "      .u-row .u-col {\n" +
                "                    vertical-align: top;\n" +
                "                }\n" +
                "\n" +
                "      .u-row .u-col-100 {\n" +
                "                    width: 550px !important;\n" +
                "                }\n" +
                "\n" +
                "            }\n" +
                "\n" +
                "            @media (max-width: 570px) {\n" +
                "      .u-row-container {\n" +
                "                    max-width: 100% !important;\n" +
                "                    padding-left: 0px !important;\n" +
                "                    padding-right: 0px !important;\n" +
                "                }\n" +
                "      .u-row .u-col {\n" +
                "                    min-width: 320px !important;\n" +
                "                    max-width: 100% !important;\n" +
                "                    display: block !important;\n" +
                "                }\n" +
                "      .u-row {\n" +
                "                    width: calc(100% - 40px) !important;\n" +
                "                }\n" +
                "      .u-col {\n" +
                "                    width: 100% !important;\n" +
                "                }\n" +
                "      .u-col > div {\n" +
                "                    margin: 0 auto;\n" +
                "                }\n" +
                "            }\n" +
                "            body {\n" +
                "                margin: 0;\n" +
                "                padding: 0;\n" +
                "            }\n" +
                "\n" +
                "            table,\n" +
                "                    tr,\n" +
                "                    td {\n" +
                "                vertical-align: top;\n" +
                "                border-collapse: collapse;\n" +
                "            }\n" +
                "\n" +
                "            p {\n" +
                "                margin: 0;\n" +
                "            }\n" +
                "\n" +
                "    .ie-container table,\n" +
                "    .mso-container table {\n" +
                "                table-layout: fixed;\n" +
                "            }\n" +
                "\n" +
                "    * {\n" +
                "                line-height: inherit;\n" +
                "            }\n" +
                "\n" +
                "            a[x-apple-data-detectors='true'] {\n" +
                "                color: inherit !important;\n" +
                "                text-decoration: none !important;\n" +
                "            }\n" +
                "\n" +
                "    </style>\n" +
                "\n" +
                "    <!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Cabin:400,700&display=swap\" rel=\"stylesheet\" type=\"text/css\"><!--<![endif]-->\n" +
                "\n" +
                "    </head>\n" +
                "\n" +
                "    <body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #e7e7e7;color: #000000\">\n" +
                "      <!--[if IE]><div class=\"ie-container\"><![endif]-->\n" +
                "      <!--[if mso]><div class=\"mso-container\"><![endif]-->\n" +
                "      <table style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #e7e7e7;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\n" +
                "      <tbody>\n" +
                "      <tr style=\"vertical-align: top\">\n" +
                "        <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\n" +
                "        <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #e7e7e7;\"><![endif]-->\n" +
                "    <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n" +
                "      <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 550px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">\n" +
                "        <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n" +
                "          <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:550px;\"><tr style=\"background-color: transparent;\"><![endif]-->\n" +
                "    <!--[if (mso)|(IE)]><td align=\"center\" width=\"550\" style=\"width: 550px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\" valign=\"top\"><![endif]-->\n" +
                "    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 550px;display: table-cell;vertical-align: top;\">\n" +
                "      <div style=\"width: 100% !important;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\">\n" +
                "      <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\"><!--<![endif]-->\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "    <div class=\"menu\" style=\"text-align:center\">\n" +
                "    <!--[if (mso)|(IE)]><table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\"><tr><![endif]-->\n" +
                "\n" +
                "    <!--[if (mso)|(IE)]></tr></table><![endif]-->\n" +
                "    </div>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "      <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n" +
                "      </div>\n" +
                "    </div>\n" +
                "    <!--[if (mso)|(IE)]></td><![endif]-->\n" +
                "          <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "\n" +
                "\n" +
                "\n" +
                "    <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n" +
                "      <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 550px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #1b0ce2;\">\n" +
                "        <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n" +
                "          <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:550px;\"><tr style=\"background-color: #1b0ce2;\"><![endif]-->\n" +
                "    <!--[if (mso)|(IE)]><td align=\"center\" width=\"550\" style=\"width: 550px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n" +
                "    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 550px;display: table-cell;vertical-align: top;\">\n" +
                "      <div style=\"width: 100% !important;\">\n" +
                "      <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 10px 15px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <h1 style=\"margin: 0px; color: #ffffff; line-height: 140%; text-align: center; word-wrap: break-word; font-weight: normal; font-family: 'Cabin',sans-serif; font-size: 27px;\">\n" +
                "                    Reset your password\n" +
                "                    </h1>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "\n" +
                "\n" +
                "      <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n" +
                "      </div>\n" +
                "    </div>\n" +
                "    <!--[if (mso)|(IE)]></td><![endif]-->\n" +
                "          <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "\n" +
                "\n" +
                "\n" +
                "    <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n" +
                "      <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 550px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #1b0ce2;\">\n" +
                "        <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n" +
                "          <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:550px;\"><tr style=\"background-color: #1b0ce2;\"><![endif]-->\n" +
                "    <!--[if (mso)|(IE)]><td align=\"center\" width=\"550\" style=\"width: 550px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n" +
                "    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 550px;display: table-cell;vertical-align: top;\">\n" +
                "      <div style=\"width: 100% !important;\">\n" +
                "      <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 15px 25px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <div style=\"color: #ffffff; line-height: 160%; text-align: center; word-wrap: break-word;\">\n" +
                "        <p style=\"font-size: 14px; line-height: 160%;\">Life is like a box of chocolates. You never know what you&rsquo;re gonna get. Life is like riding a bicycle. To keep your balance, you must keep moving. You can fool all of the people some of the time, and some of the people all of the time, but you can't fool all of the people all of the time.</p>\n" +
                "                    </div>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 30px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "    <div align=\"center\">\n" +
                "      <!--[if mso]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-spacing: 0; border-collapse: collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;font-family:'Cabin',sans-serif;\"><tr><td style=\"font-family:'Cabin',sans-serif;\" align=\"center\"><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"\" style=\"height:42px; v-text-anchor:middle; width:298px;\" arcsize=\"9.5%\" stroke=\"f\" fillcolor=\"#3AAEE0\"><w:anchorlock/><center style=\"color:#FFFFFF;font-family:'Cabin',sans-serif;\"><![endif]-->\n" +
                "        <a href=\"$linkToConfirm\" target=\"_blank\" style=\"box-sizing: border-box;display: inline-block;font-family:'Cabin',sans-serif;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #FFFFFF; background-color: #3AAEE0; border-radius: 4px;-webkit-border-radius: 4px; -moz-border-radius: 4px; width:auto; max-width:100%; overflow-wrap: break-word; word-break: break-word; word-wrap:break-word; mso-border-alt: none;\">\n" +
                "          <span style=\"display:block;padding:13px 30px;line-height:120%;\"><span style=\"font-size: 14px; line-height: 16.8px;\">CLICK HERE TO RESET YOUR PASSWORD</span></span>\n" +
                "        </a>\n" +
                "      <!--[if mso]></center></v:roundrect></td></tr></table><![endif]-->\n" +
                "    </div>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "      <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n" +
                "      </div>\n" +
                "    </div>\n" +
                "    <!--[if (mso)|(IE)]></td><![endif]-->\n" +
                "          <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "\n" +
                "\n" +
                "\n" +
                "    <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n" +
                "      <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 550px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">\n" +
                "        <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n" +
                "          <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:550px;\"><tr style=\"background-color: transparent;\"><![endif]-->\n" +
                "    <!--[if (mso)|(IE)]><td align=\"center\" width=\"550\" style=\"width: 550px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n" +
                "    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 550px;display: table-cell;vertical-align: top;\">\n" +
                "      <div style=\"width: 100% !important;\">\n" +
                "      <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 0px solid #BBBBBB;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n" +
                "        <tbody>\n" +
                "          <tr style=\"vertical-align: top\">\n" +
                "            <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n" +
                "              <span>&#160;</span>\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </tbody>\n" +
                "      </table>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "      <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n" +
                "      </div>\n" +
                "    </div>\n" +
                "    <!--[if (mso)|(IE)]></td><![endif]-->\n" +
                "          <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "\n" +
                "\n" +
                "\n" +
                "    <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n" +
                "      <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 550px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">\n" +
                "        <div style=\"border-collapse: collapse;display: table;width: 100%;background-image: url('images/image-1.png');background-repeat: no-repeat;background-position: center top;background-color: transparent;\">\n" +
                "          <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:550px;\"><tr style=\"background-image: url('images/image-1.png');background-repeat: no-repeat;background-position: center top;background-color: transparent;\"><![endif]-->\n" +
                "    <!--[if (mso)|(IE)]><td align=\"center\" width=\"550\" style=\"width: 550px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n" +
                "    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 550px;display: table-cell;vertical-align: top;\">\n" +
                "      <div style=\"width: 100% !important;\">\n" +
                "      <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 0px solid #BBBBBB;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n" +
                "        <tbody>\n" +
                "          <tr style=\"vertical-align: top\">\n" +
                "            <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n" +
                "              <span>&#160;</span>\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </tbody>\n" +
                "      </table>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "      <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n" +
                "      </div>\n" +
                "    </div>\n" +
                "    <!--[if (mso)|(IE)]></td><![endif]-->\n" +
                "          <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "\n" +
                "\n" +
                "\n" +
                "    <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n" +
                "      <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 550px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\">\n" +
                "        <div style=\"border-collapse: collapse;display: table;width: 100%;background-color: transparent;\">\n" +
                "          <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:550px;\"><tr style=\"background-color: #ffffff;\"><![endif]-->\n" +
                "    <!--[if (mso)|(IE)]><td align=\"center\" width=\"550\" style=\"width: 550px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\n" +
                "    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 550px;display: table-cell;vertical-align: top;\">\n" +
                "      <div style=\"width: 100% !important;\">\n" +
                "      <!--[if (!mso)&(!IE)]><!--><div style=\"padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <div style=\"color: #1b0ce2; line-height: 140%; text-align: center; word-wrap: break-word;\">\n" +
                "        <p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 18px; line-height: 25.2px;\">w w w . factoringcompany . c o m</span></p>\n" +
                "      </div>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 15px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #ced4d9;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n" +
                "        <tbody>\n" +
                "          <tr style=\"vertical-align: top\">\n" +
                "            <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n" +
                "              <span>&#160;</span>\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </tbody>\n" +
                "      </table>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "    <table style=\"font-family:'Cabin',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n" +
                "      <tbody>\n" +
                "        <tr>\n" +
                "          <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 10px 10px;font-family:'Cabin',sans-serif;\" align=\"left\">\n" +
                "      <div style=\"color: #888888; line-height: 180%; text-align: center; word-wrap: break-word;\">\n" +
                "        <p style=\"font-size: 14px; line-height: 180%;\">If you have questions regarding your data, please visit our Privacy Policy</p>\n" +
                "    <p style=\"font-size: 14px; line-height: 180%;\">Want to change how you receive these emails? You can update your preferences or unsubscribe from this list.</p>\n" +
                "    <p style=\"font-size: 14px; line-height: 180%;\"><span style=\"font-size: 12px; line-height: 21.6px;\">&copy; 2021 Factorng Company. All Rights Reserved.</span></p>\n" +
                "      </div>\n" +
                "\n" +
                "          </td>\n" +
                "        </tr>\n" +
                "      </tbody>\n" +
                "    </table>\n" +
                "\n" +
                "      <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\n" +
                "      </div>\n" +
                "    </div>\n" +
                "    <!--[if (mso)|(IE)]></td><![endif]-->\n" +
                "          <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\n" +
                "        </div>\n" +
                "      </div>\n" +
                "    </div>\n" +
                "\n" +
                "        <!--[if (mso)|(IE)]></td></tr></table><![endif]-->\n" +
                "        </td>\n" +
                "      </tr>\n" +
                "      </tbody>\n" +
                "      </table>\n" +
                "      <!--[if mso]></div><![endif]-->\n" +
                "      <!--[if IE]></div><![endif]-->\n" +
                "    </body>\n" +
                "    </html>\n").replace("$linkToConfirm", link);

    }
}
