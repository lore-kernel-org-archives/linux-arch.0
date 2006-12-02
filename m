Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:44483 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1759480AbWLBK7k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:40 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2622816uga
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:39 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 20/26] Dynamic kernel command-line - sh64
Date: Sat, 2 Dec 2006 12:55:41 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.42342.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>

---

diff -urNp linux-2.6.19.org/arch/sh64/kernel/setup.c linux-2.6.19/arch/sh64/kernel/setup.c
--- linux-2.6.19.org/arch/sh64/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sh64/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -83,7 +83,7 @@ extern int sh64_tlb_init(void);
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-static char command_line[COMMAND_LINE_SIZE] = { 0, };
+static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
 unsigned long long memory_start = CONFIG_MEMORY_START;
 unsigned long long memory_end = CONFIG_MEMORY_START + (CONFIG_MEMORY_SIZE_IN_MB * 1024 * 1024);
 
@@ -95,8 +95,8 @@ static inline void parse_mem_cmdline (ch
 	int len = 0;
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+	memcpy(boot_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = '\0';
 
 	for (;;) {
 	  /*
