Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:63718 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759466AbWLBK7b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809425nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:31 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 13/26] Dynamic kernel command-line - m68knommu
Date: Sat, 2 Dec 2006 12:53:03 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021253.04285.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/m68knommu/kernel/setup.c linux-2.6.19/arch/m68knommu/kernel/setup.c
--- linux-2.6.19.org/arch/m68knommu/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/m68knommu/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -47,7 +47,7 @@ unsigned long memory_end;
 EXPORT_SYMBOL(memory_start);
 EXPORT_SYMBOL(memory_end);
 
-char command_line[COMMAND_LINE_SIZE];
+char __initdata command_line[COMMAND_LINE_SIZE];
 
 /* setup some dummy routines */
 static void dummy_waitbut(void)
@@ -234,8 +234,8 @@ void setup_arch(char **cmdline_p)
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
-	memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-	saved_command_line[COMMAND_LINE_SIZE-1] = 0;
+	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
+	boot_command_line[COMMAND_LINE_SIZE-1] = 0;
 
 #ifdef DEBUG
 	if (strlen(*cmdline_p))
