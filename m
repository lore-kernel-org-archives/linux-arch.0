From: Will Deacon <will.deacon@arm.com>
Subject: LATENCYTOP not building on ia64
Date: Wed, 27 Jan 2016 15:00:31 +0000
Message-ID: <20160127150031.GI2390@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53079 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932555AbcA0PAk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Jan 2016 10:00:40 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: heiko.carstens@de.ibm.com, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@linutronix.de, tony.luck@intel.com

Hi all,

After da48d094ce5d ("Kconfig: remove HAVE_LATENCYTOP_SUPPORT"),
CONFIG_LATENCYTOP can be selected on all architectures. Unfortunately,
viro reported that this breaks the build for ia64:

  arch/ia64/kernel/entry.S: Assembler messages:
  arch/ia64/kernel/entry.S:621: Error: Operand 2 of `adds' should be a 14-bit integer (-8192-8191)
  arch/ia64/kernel/entry.S:728: Error: Operand 2 of `adds' should be a 14-bit integer (-8192-8191)
  arch/ia64/kernel/entry.S:859: Error: Operand 2 of `adds' should be a 14-bit integer (-8192-8191)
  make[1]: *** [arch/ia64/kernel/entry.o] Error 1

This is because the task_struct is over 8K thanks to the latency_record
array, which means that the 14-bit immediate offset expected by the adds
instruction to grab hold of the thread info flags is now out-of-range on
ia64. I had a quick go at fixing it in entry.S, but I ended up with
worse code due to the need to perform the offset calculation as a
separate step (which introduces a hazard).

We could simply revert da48d094ce5d to make the problem disappear, but
I'd be interested to know whether or not this is an ia64-specific problem
and therefore whether LATENCYTOP should be opt-out as opposed to opt-in
for a given architecture.

Prior to da48d094ce5d, arc, arm, metag, microblaze, parisc, powerpc,
s390, sh, sparc, unicore32 and x86 all selected HAVE_LATENCYTOP_SUPPORT
so assumedly they don't run into problems. arm64 also works ok with the
option enabled.

Will

--->8

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ecb9e75614bf..9c66339e3879 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1600,6 +1600,7 @@ config LATENCYTOP
 	depends on DEBUG_KERNEL
 	depends on STACKTRACE_SUPPORT
 	depends on PROC_FS
+	depends on !IA64
 	select FRAME_POINTER if !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND && !ARC
 	select KALLSYMS
 	select KALLSYMS_ALL
