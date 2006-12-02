Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759460AbWLBK73 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:29 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809426nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:29 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 11/26] Dynamic kernel command-line - m32r
Date: Sat, 2 Dec 2006 12:52:13 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021252.14464.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/m32r/kernel/setup.c linux-2.6.19/arch/m32r/kernel/setup.c
--- linux-2.6.19.org/arch/m32r/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/m32r/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -64,7 +64,7 @@ struct screen_info screen_info = {
 
 extern int root_mountflags;
 
-static char command_line[COMMAND_LINE_SIZE];
+static char __initdata command_line[COMMAND_LINE_SIZE];
 
 static struct resource data_resource = {
 	.name   = "Kernel data",
@@ -95,8 +95,8 @@ static __inline__ void parse_mem_cmdline
 	int usermem = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	memory_start = (unsigned long)CONFIG_MEMORY_START+PAGE_OFFSET;
 	memory_end = memory_start+(unsigned long)CONFIG_MEMORY_SIZE;
