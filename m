From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 3/4] ia64 mcount offset calculation
Date: Tue, 17 May 2011 10:04:56 +0200
Message-ID: <20110517100456.6abef0de@mschwide>
References: <20110510081039.241831019@de.ibm.com>
	<20110510081103.902546467@de.ibm.com>
	<1305572301.5456.24.camel@gandalf.stny.rr.com>
	<987664A83D2D224EAE907B061CE93D5301CD197F7B@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:38769 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab1EQIGF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2011 04:06:05 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p4H863GJ000765
	for <linux-arch@vger.kernel.org>; Tue, 17 May 2011 08:06:03 GMT
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4H8636B2281724
	for <linux-arch@vger.kernel.org>; Tue, 17 May 2011 09:06:03 +0100
Received: from d06av10.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4H851AT029013
	for <linux-arch@vger.kernel.org>; Tue, 17 May 2011 02:05:02 -0600
In-Reply-To: <987664A83D2D224EAE907B061CE93D5301CD197F7B@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, 16 May 2011 12:17:15 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> This patch does some fast and loose translation from hex (0x12) in the kernel
> to decimal (18) in the user tools ... which doesn't look like it fits with
> either of these conventions.

All the patch does is to move an address calculation from the kernel "addr-0x12"
to user space by subtracting the constant offset from the addend value for the
relocation: "addend = _w(_w(relp->r_offset) - recval + mcount_adjust)".

The offset for ia64 is -18. I'd be very surprised if the outcome of the move
would yield a different end result. But as I took another look at the patch
I noticed a bug, for EM_IA64 we need to set mcount_adjust_64 and not
mcount_adjust_32 as it is a 64-bit architecture. New patch below.

I tried to do a test compile with/without the patch but with the latest git
kernels TRACING_SUPPORT depends on TRACE_IRQFLAGS_SUPPORT which is missing
for ia64. No luck ..

---
Subject: [PATCH] ia64 mcount offset calculation

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Do the mcount offset adjustment in the recordmcount.pl/recordmcount.[ch]
at compile time and not in ftrace_call_adjust at run time.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/ia64/include/asm/ftrace.h |    7 +++++--
 scripts/recordmcount.c         |    7 ++++++-
 scripts/recordmcount.pl        |    1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/ia64/include/asm/ftrace.h linux-2.6-patched/arch/ia64/include/asm/ftrace.h
--- linux-2.6/arch/ia64/include/asm/ftrace.h	2011-03-15 02:20:32.000000000 +0100
+++ linux-2.6-patched/arch/ia64/include/asm/ftrace.h	2011-05-16 10:16:20.000000000 +0200
@@ -14,8 +14,11 @@ extern void _mcount(unsigned long pfs, u
 
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
diff -urpN linux-2.6/scripts/recordmcount.c linux-2.6-patched/scripts/recordmcount.c
--- linux-2.6/scripts/recordmcount.c	2011-05-16 10:16:20.000000000 +0200
+++ linux-2.6-patched/scripts/recordmcount.c	2011-05-16 10:16:20.000000000 +0200
@@ -307,7 +307,12 @@ do_file(char const *const fname)
 	case EM_ARM:	 reltype = R_ARM_ABS32;
 			 altmcount = "__gnu_mcount_nc";
 			 break;
-	case EM_IA_64:	 reltype = R_IA64_IMM64;   gpfx = '_'; break;
+	case EM_IA_64:
+		reltype = R_IA64_IMM64;
+		/* Adjust relocation to second bundle, insn 2 */
+		mcount_adjust_64 = -18;
+		gpfx = '_';
+		break;
 	case EM_MIPS:	 /* reltype: e_class    */ gpfx = '_'; break;
 	case EM_PPC:	 reltype = R_PPC_ADDR32;   gpfx = '_'; break;
 	case EM_PPC64:	 reltype = R_PPC64_ADDR64; gpfx = '_'; break;
diff -urpN linux-2.6/scripts/recordmcount.pl linux-2.6-patched/scripts/recordmcount.pl
--- linux-2.6/scripts/recordmcount.pl	2011-05-16 10:16:20.000000000 +0200
+++ linux-2.6-patched/scripts/recordmcount.pl	2011-05-16 10:16:20.000000000 +0200
@@ -278,6 +278,7 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "ia64") {
     $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
+    $mcount_adjust = -18;
     $type = "data8";
 
     if ($is_module eq "0") {


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
