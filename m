Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:57575 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759487AbWLBK7o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:44 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809426nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:43 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 23/26] Dynamic kernel command-line - um
Date: Sat, 2 Dec 2006 12:56:38 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021256.39595.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


1. Rename saved_command_line into boot_command_line.
2. Set command_line as __initdata.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/um/include/user_util.h linux-2.6.19/arch/um/include/user_util.h
--- linux-2.6.19.org/arch/um/include/user_util.h	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/um/include/user_util.h	2006-12-02 11:31:33.000000000 +0200
@@ -38,7 +38,7 @@ extern unsigned long long highmem;
 
 extern char host_info[];
 
-extern char saved_command_line[];
+extern char __initdata boot_command_line[];
 
 extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
 extern unsigned long _unprotected_end;
diff -urNp linux-2.6.19.org/arch/um/kernel/um_arch.c linux-2.6.19/arch/um/kernel/um_arch.c
--- linux-2.6.19.org/arch/um/kernel/um_arch.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/um/kernel/um_arch.c	2006-12-02 11:31:33.000000000 +0200
@@ -482,7 +482,7 @@ void __init setup_arch(char **cmdline_p)
 	atomic_notifier_chain_register(&panic_notifier_list,
 			&panic_exit_notifier);
 	paging_init();
-        strlcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
  	*cmdline_p = command_line;
 	setup_hostinfo();
 }
