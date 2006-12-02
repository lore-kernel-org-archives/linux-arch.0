Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759455AbWLBK7T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:19 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809426nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:18 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 02/26] Dynamic kernel command-line - alpha
Date: Sat, 2 Dec 2006 12:48:54 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021248.55310.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/alpha/kernel/setup.c linux-2.6.19/arch/alpha/kernel/setup.c
--- linux-2.6.19.org/arch/alpha/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/alpha/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -122,7 +122,7 @@ static void get_sysnames(unsigned long, 
 			 char **, char **);
 static void determine_cpu_caches (unsigned int);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * The format of "screen_info" is strange, and due to early
@@ -547,7 +547,7 @@ setup_arch(char **cmdline_p)
 	} else {
 		strlcpy(command_line, COMMAND_LINE, sizeof command_line);
 	}
-	strcpy(saved_command_line, command_line);
+	strcpy(boot_command_line, command_line);
 	*cmdline_p = command_line;
 
 	/* 
@@ -589,7 +589,7 @@ setup_arch(char **cmdline_p)
 	}
 
 	/* Replace the command line, now that we've killed it with strsep.  */
-	strcpy(command_line, saved_command_line);
+	strcpy(command_line, boot_command_line);
 
 	/* If we want SRM console printk echoing early, do it now. */
 	if (alpha_using_srm && srmcons_output) {
