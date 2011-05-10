From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/4] ia64 mcount offset calculation
Date: Tue, 10 May 2011 10:10:42 +0200
Message-ID: <20110510081103.902546467@de.ibm.com>
References: <20110510081039.241831019@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164]:51721 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab1EJILC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 04:11:02 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4A8AvpS013446
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 08:10:57 GMT
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4A8AuGs2334966
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 09:10:56 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4A8AtfI003113
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 02:10:56 -0600
Content-Disposition: inline; filename=302-mcount-adjust-ia64.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, H.
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Do the mcount offset adjustment in the recordmcount.pl/recordmcount.[ch]
at compile time and not in ftrace_call_adjust at run time.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---


 arch/ia64/include/asm/ftrace.h |    7 +++++--
 scripts/recordmcount.c         |    7 ++++++-
 scripts/recordmcount.pl        |    1 +
 3 files changed, 12 insertions(+), 3 deletions(-)
Index: test-2.6/arch/ia64/include/asm/ftrace.h
===================================================================
--- test-2.6.orig/arch/ia64/include/asm/ftrace.h	2010-01-11 10:58:31.000000000 +0100
+++ test-2.6/arch/ia64/include/asm/ftrace.h	2011-05-03 09:39:04.929486388 +0200
@@ -14,8 +14,11 @@
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
-	/* second bundle, insn 2 */
-	return addr - 0x12;
+	/*
+	 * addr is the address of the mcount call instruction.
+	 * recordmcount does the necessary offset calculation.
+	 */
+	return addr;
 }
 
 struct dyn_arch_ftrace {
Index: test-2.6/scripts/recordmcount.c
===================================================================
--- test-2.6.orig/scripts/recordmcount.c	2011-05-03 09:39:02.145472579 +0200
+++ test-2.6/scripts/recordmcount.c	2011-05-03 09:39:04.929486388 +0200
@@ -307,7 +307,12 @@
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
 			 break;
-	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
+	case EM_IA_64:
+		reltype = R_IA64_IMM64;
+		/* Adjust relocation to second bundle, insn 2 */
+		mcount_adjust_32 = -18;
+		gpfx = '_';
+		break;
 	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
 	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
 	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
Index: test-2.6/scripts/recordmcount.pl
===================================================================
--- test-2.6.orig/scripts/recordmcount.pl	2011-05-03 09:39:02.145472579 +0200
+++ test-2.6/scripts/recordmcount.pl	2011-05-03 09:39:04.929486388 +0200
@@ -278,6 +278,7 @@
 
 } elsif ($arch eq "ia64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
+    $mcount_adjust = -18;
     $type = "data8";
 
     if ($is_module eq "0") {
