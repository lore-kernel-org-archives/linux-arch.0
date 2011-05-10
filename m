Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164]:51728 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875Ab1EJILC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2011 04:11:02 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4A8AuYS013444
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 08:10:56 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4A8AuvZ2273310
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 09:10:56 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4A8Asj3019785
	for <linux-arch@vger.kernel.org>; Tue, 10 May 2011 02:10:56 -0600
Message-ID: <20110510081103.049030384@de.ibm.com>
Date: Tue, 10 May 2011 10:10:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/4] recordmcount mcount address adjustment
References: <20110510081039.241831019@de.ibm.com>
Content-Disposition: inline; filename=300-mcount-adjust.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Russell King <linux@arm.linux.org.uk>, Rabin Vincent <rabin@rab.in>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20110510081040.6WI5pLqhfDjlZLBLWzwOpSXoOqGwec0rG5WTeln8_Yc@z>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Introduce mcount_adjust{,_32,_64} to the C implementation of
recordmcount analog to $mcount_adjust in the perl script.
The adjustment is added to the address of the relocations
against the mcount symbol. If this adjustment is done by
recordmcount at compile time the ftrace_call_adjust function
can be turned into a nop.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---


 scripts/recordmcount.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
Index: test-2.6/scripts/recordmcount.h
===================================================================
--- test-2.6.orig/scripts/recordmcount.h	2011-01-07 09:17:19.000000000 +0100
+++ test-2.6/scripts/recordmcount.h	2011-05-03 09:38:56.781445980 +0200
@@ -22,6 +22,7 @@
 #undef is_fake_mcount
 #undef fn_is_fake_mcount
 #undef MIPS_is_fake_mcount
+#undef mcount_adjust
 #undef sift_rel_mcount
 #undef find_secsym_ndx
 #undef __has_rel_mcount
@@ -57,6 +58,7 @@
 # define is_fake_mcount		is_fake_mcount64
 # define fn_is_fake_mcount	fn_is_fake_mcount64
 # define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
+# define mcount_adjust		mcount_adjust_64
 # define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
@@ -85,6 +87,7 @@
 # define is_fake_mcount		is_fake_mcount32
 # define fn_is_fake_mcount	fn_is_fake_mcount32
 # define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
+# define mcount_adjust		mcount_adjust_32
 # define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
@@ -123,6 +126,8 @@
 }
 static void (*Elf_r_info)(Elf_Rel *const rp, unsigned sym, unsigned type) = fn_ELF_R_INFO;
 
+static int mcount_adjust = 0;
+
 /*
  * MIPS mcount long call has 2 _mcount symbols, only the position of the 1st
  * _mcount symbol is needed for dynamic function tracer, with it, to disable
@@ -285,8 +290,8 @@
 		}
 
 		if (mcountsym == Elf_r_sym(relp) && !is_fake_mcount(relp)) {
-			uint_t const addend = _w(_w(relp->r_offset) - recval);
-
+			uint_t const addend =
+				_w(_w(relp->r_offset) - recval + mcount_adjust);
 			mrelp->r_offset = _w(offbase
 				+ ((void *)mlocp - (void *)mloc0));
 			Elf_r_info(mrelp, recsym, reltype);

