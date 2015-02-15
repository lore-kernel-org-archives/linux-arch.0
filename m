From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 00/15] Revert h8300 archtecture
Date: Sun, 15 Feb 2015 11:59:19 +0100
Message-ID: <1423997959.9418.69.camel@x220>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:57909 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750809AbbBOK7W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 15 Feb 2015 05:59:22 -0500
In-Reply-To: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, 2015-02-15 at 16:49 +0900, Yoshinori Sato wrote:
> Yoshinori Sato (15):
>   h8300: Assembly headers.
>   h8300: UAPI headers
>   h8300: Exception and Interrupt handling
>   h8300: kernel booting
>   h8300: Process and signal
>   h8300 CPU depend helpers
>   h8300: miscellaneous functions
>   h8300: Memory management
>   h8300: library functions
>   h8300: Build scripts
>   h8300: clock driver
>   h8300: clocksource
>   h8300: configs
>   serial: Add h8300
>   Add ELF machine

git am warns about various whitespace issues:

Applying: h8300: Assembly headers.
[...]/.git/rebase-apply/patch:831: new blank line at EOF.
+
[...]/.git/rebase-apply/patch:1674: new blank line at EOF.
+
warning: 2 lines add whitespace errors.
Applying: h8300: UAPI headers
Applying: h8300: Exception and Interrupt handling
[...]/.git/rebase-apply/patch:223: trailing whitespace.
/* r1l is saved ccr */	
warning: 1 line adds whitespace errors.
Applying: h8300: kernel booting
[...]/.git/rebase-apply/patch:54: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: h8300: Process and signal
[...]/.git/rebase-apply/patch:314: trailing whitespace.
	
warning: 1 line adds whitespace errors.
Applying: h8300 CPU depend helpers
[...]/.git/rebase-apply/patch:32: new blank line at EOF.
+
[...]/.git/rebase-apply/patch:827: new blank line at EOF.
+
warning: 2 lines add whitespace errors.
Applying: h8300: miscellaneous functions
Applying: h8300: Memory management
[...]/.git/rebase-apply/patch:88: new blank line at EOF.
+
[...]/.git/rebase-apply/patch:247: new blank line at EOF.
+
[...]/.git/rebase-apply/patch:374: new blank line at EOF.
+
warning: 3 lines add whitespace errors.
Applying: h8300: library functions
[...]/.git/rebase-apply/patch:279: trailing whitespace.
			
[...]/.git/rebase-apply/patch:1170: trailing whitespace.
	
[...]/.git/rebase-apply/patch:1188: space before tab in indent.
 	; er0 = er0 / er1
[...]/.git/rebase-apply/patch:1189: space before tab in indent.
 	; er3 = er0 % er1
[...]/.git/rebase-apply/patch:1190: space before tab in indent.
 	; trashes er1 er2
warning: squelched 3 whitespace errors
warning: 8 lines add whitespace errors.
Applying: h8300: Build scripts
[...]/.git/rebase-apply/patch:197: space before tab in indent.
 	  <http://www.renesas.eu/products/tools/introductory_evaluation_tools/evaluation_development_os_kits/edosk2674r/edosk2674r_software_tools_root.jsp>
warning: 1 line adds whitespace errors.
Applying: h8300: clock driver
[...]/.git/rebase-apply/patch:161: trailing whitespace.
	
[...]/.git/rebase-apply/patch:216: trailing whitespace.
	
[...]/.git/rebase-apply/patch:236: trailing whitespace.
	
warning: 3 lines add whitespace errors.
Applying: h8300: clocksource
[...]/.git/rebase-apply/patch:22: trailing whitespace.
	
warning: 1 line adds whitespace errors.
Applying: h8300: configs
Applying: serial: Add h8300
Applying: Add ELF machine

(I did fix patch 12/15 ("h8300: clocksource") manually, to make it apply
on top of next-20150213, but I don't think I introduced the warning in
that patch.)


Paul Bolle
