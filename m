Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:56806 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1759482AbWLBK7l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 05:59:41 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3809405nfa
        for <linux-arch@vger.kernel.org>; Sat, 02 Dec 2006 02:59:40 -0800 (PST)
From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: [PATCH 21/26] Dynamic kernel command-line - sparc
Date: Sat, 2 Dec 2006 12:55:59 +0200
References: <200612021247.43291.alon.barlev@gmail.com>
In-Reply-To: <200612021247.43291.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021255.59942.alon.barlev@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.19.org/arch/sparc/kernel/setup.c linux-2.6.19/arch/sparc/kernel/setup.c
--- linux-2.6.19.org/arch/sparc/kernel/setup.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sparc/kernel/setup.c	2006-12-02 11:31:33.000000000 +0200
@@ -246,7 +246,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Initialize PROM console and command line. */
 	*cmdline_p = prom_getbootargs();
-	strcpy(saved_command_line, *cmdline_p);
+	strcpy(boot_command_line, *cmdline_p);
 
 	/* Set sparc_cpu_model */
 	sparc_cpu_model = sun_unknown;
diff -urNp linux-2.6.19.org/arch/sparc/kernel/sparc_ksyms.c linux-2.6.19/arch/sparc/kernel/sparc_ksyms.c
--- linux-2.6.19.org/arch/sparc/kernel/sparc_ksyms.c	2006-11-29 23:57:37.000000000 +0200
+++ linux-2.6.19/arch/sparc/kernel/sparc_ksyms.c	2006-12-02 11:31:33.000000000 +0200
@@ -237,7 +237,7 @@ EXPORT_SYMBOL(prom_getproplen);
 EXPORT_SYMBOL(prom_getproperty);
 EXPORT_SYMBOL(prom_node_has_property);
 EXPORT_SYMBOL(prom_setprop);
-EXPORT_SYMBOL(saved_command_line);
+EXPORT_SYMBOL(boot_command_line);
 EXPORT_SYMBOL(prom_apply_obio_ranges);
 EXPORT_SYMBOL(prom_feval);
 EXPORT_SYMBOL(prom_getbool);
