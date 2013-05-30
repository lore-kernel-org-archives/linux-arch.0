Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:58492 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab3E3BTf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 21:19:35 -0400
Message-ID: <51A6A8F3.2030200@asianux.com>
Date: Thu, 30 May 2013 09:18:43 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [PATCH] arch: parisc: kernel: using strlcpy() instead of strcpy()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, udknight@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>, Parisc List <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130530011843.U0X6LhDhCvfFAo7CUJtyS0TE6iSaaaYCpicXHoMqLzI@z>


'boot_args' is an input args, and 'boot_command_line' has a fix length.

So need use strlcpy() instead of strcpy() to avoid memory overflow.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/parisc/kernel/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 60c1ae6..7349a3f 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -69,7 +69,8 @@ void __init setup_cmdline(char **cmdline_p)
 		/* called from hpux boot loader */
 		boot_command_line[0] = '\0';
 	} else {
-		strcpy(boot_command_line, (char *)__va(boot_args[1]));
+		strlcpy(boot_command_line, (char *)__va(boot_args[1]),
+			COMMAND_LINE_SIZE);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 		if (boot_args[2] != 0) /* did palo pass us a ramdisk? */
-- 
1.7.7.6
