Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:63718 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161830AbWLBK7W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:22 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809425nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:21 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 05/26] Dynamic kernel command-line - avr32
Date: Sat, 2 Dec 2006 12:49:54 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021249.55192.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

---

diff -urNp linux-2.6.19.org/arch/avr32/kernel/setup.c linux-2.6.19/arch/avr32/kernel/setup.c
--- linux-2.6.19.org/arch/avr32/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/avr32/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -44,7 +44,7 @@ struct avr32_cpuinfo boot_cpu_data = {
 };
 EXPORT_SYMBOL(boot_cpu_data);
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 /*
  * Should be more than enough, but if you have a _really_ complex
@@ -202,7 +202,7 @@ __tagtable(ATAG_MEM, parse_tag_mem);
 
 static int __init parse_tag_cmdline(struct tag *tag)
 {
-	strlcpy(saved_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
 	return 0;
 }
 __tagtable(ATAG_CMDLINE, parse_tag_cmdline);
@@ -318,7 +318,7 @@ void __init setup_arch (char **cmdline_p
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
 
-	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	parse_early_param();
 
