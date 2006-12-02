Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:55527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759464AbWLBK7b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809406nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:30 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 12/26] Dynamic kernel command-line - m68k
Date: Sat, 2 Dec 2006 12:52:36 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021252.37087.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/m68k/kernel/setup.c linux-2.6.19/arch/m68k/kernel/setup.c
--- linux-2.6.19.org/arch/m68k/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/m68k/kernel/setup.c	2006-12-02 11:31:32.000000000 +0200
@@ -256,7 +256,7 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.brk = (unsigned long) &_end;
 
 	*cmdline_p = m68k_command_line;
-	memcpy(saved_command_line, *cmdline_p, CL_SIZE);
+	memcpy(boot_command_line, *cmdline_p, CL_SIZE);
 
 	/* Parse the command line for arch-specific options.
 	 * For the m68k, this is currently only "debug=xxx" to enable printing
