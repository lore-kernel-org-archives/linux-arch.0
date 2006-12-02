Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759473AbWLBK7g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:36 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809426nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:35 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 17/26] Dynamic kernel command-line - ppc
Date: Sat, 2 Dec 2006 12:54:43 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021254.44149.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/ppc/kernel/setup.c linux-2.6.19/arch/ppc/kernel/setup.c
--- linux-2.6.19.org/arch/ppc/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ppc/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -543,7 +543,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) klimit;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, cmd_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
 	*cmdline_p = cmd_line;
 
 	parse_early_param();
diff -urNp linux-2.6.19.org/arch/ppc/platforms/lopec.c linux-2.6.19/arch/ppc/platforms/lopec.c
--- linux-2.6.19.org/arch/ppc/platforms/lopec.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ppc/platforms/lopec.c	2006-12-02 11:31:33.000000000 +0200
@@ -344,7 +344,7 @@ lopec_setup_arch(void)
 		 if (bootargs != NULL) {
 			 strcpy(cmd_line, bootargs);
 			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
+			 strcpy(boot_command_line, cmd_line);
 		}
 	}
 #endif
diff -urNp linux-2.6.19.org/arch/ppc/platforms/pplus.c linux-2.6.19/arch/ppc/platforms/pplus.c
--- linux-2.6.19.org/arch/ppc/platforms/pplus.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ppc/platforms/pplus.c	2006-12-02 11:31:33.000000000 +0200
@@ -592,7 +592,7 @@ static void __init pplus_setup_arch(void
 		if (bootargs != NULL) {
 			strcpy(cmd_line, bootargs);
 			/* again.. */
-			strcpy(saved_command_line, cmd_line);
+			strcpy(boot_command_line, cmd_line);
 		}
 	}
 #endif
diff -urNp linux-2.6.19.org/arch/ppc/platforms/prep_setup.c linux-2.6.19/arch/ppc/platforms/prep_setup.c
--- linux-2.6.19.org/arch/ppc/platforms/prep_setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/ppc/platforms/prep_setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -634,7 +634,7 @@ static void __init prep_init_sound(void)
 	/*
 	 * Find a way to push these informations to the cs4232 driver
 	 * Give it out with printk, when not in cmd_line?
-	 * Append it to  cmd_line and saved_command_line?
+	 * Append it to  cmd_line and boot_command_line?
 	 * Format is cs4232=io,irq,dma,dma2
 	 */
 }
@@ -897,7 +897,7 @@ prep_setup_arch(void)
 		 if (bootargs != NULL) {
 			 strcpy(cmd_line, bootargs);
 			 /* again.. */
-			 strcpy(saved_command_line, cmd_line);
+			 strcpy(boot_command_line, cmd_line);
 		}
 	}
