Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1162425AbWLBK7r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809426nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:46 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 26/26] Dynamic kernel command-line - xtensa
Date: Sat, 2 Dec 2006 12:58:02 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021258.03303.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/xtensa/kernel/setup.c linux-2.6.19/arch/xtensa/kernel/setup.c
--- linux-2.6.19.org/arch/xtensa/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/xtensa/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -80,7 +80,7 @@ extern unsigned long loops_per_jiffy;
 
 /* Command line specified as configuration option. */
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_CMDLINE_BOOL
 static char default_command_line[COMMAND_LINE_SIZE] __initdata = CONFIG_CMDLINE;
@@ -255,8 +255,8 @@ void __init setup_arch(char **cmdline_p)
 	extern int mem_reserve(unsigned long, unsigned long, int);
 	extern void bootmem_init(void);
 
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 	*cmdline_p = command_line;
 
 	/* Reserve some memory regions */
