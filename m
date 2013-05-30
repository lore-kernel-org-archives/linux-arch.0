From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: parisc: kernel: using strlcpy() instead of strcpy()
Date: Thu, 30 May 2013 09:18:43 +0800
Message-ID: <51A6A8F3.2030200@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, udknight@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>, Parisc List <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


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
