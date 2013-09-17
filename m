From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC PATCH REBASED 0/3] Move ARCH specific fpu_counter out of task_struct
Date: Tue, 17 Sep 2013 11:47:16 +0530
Message-ID: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp1.synopsys.com ([198.182.60.75]:57225 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab3IQGRs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 02:17:48 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org

Hi,

This is a resend of the patches I sent last week which failed to draw any
attention.

This basically came up when ARC SMP 3.11 failed to build due to a ST insn
dealing with task_struct.thread going out of range.

When staring at code I spotted @fpu_counter in task_struct which only SH/x86
happen to use, and can be easily moved out into corresponding ARCH specific
thread_struct. This saves 4 bytes per task_struct instantiated, for all the
other 18 arches.

One of the resistance to the patch(es) could be that task_struct fields were at
some point arranged to reduce the number of line misses. However there is lot
of variance there due to so many #ifdefs, variable size of cpumask (>32 cores..)
etc, so that argument alone might not be sufficient vs. saving 4 bytes per
instance.

Comments please !

Thx,
-Vineet

Vineet Gupta (3):
  sh: Move fpu_counter into ARCH specific thread_struct
  x86: Move fpu_counter into ARCH specific thread_struct
  sched: Remove ARCH specific fpu_counter from task_struct

 arch/sh/include/asm/fpu.h           |  2 +-
 arch/sh/include/asm/processor_32.h  | 10 ++++++++++
 arch/sh/include/asm/processor_64.h  | 10 ++++++++++
 arch/sh/kernel/cpu/fpu.c            |  2 +-
 arch/sh/kernel/process_32.c         |  6 +++---
 arch/x86/include/asm/fpu-internal.h | 10 +++++-----
 arch/x86/include/asm/processor.h    |  9 +++++++++
 arch/x86/kernel/i387.c              |  2 +-
 arch/x86/kernel/process_32.c        |  4 ++--
 arch/x86/kernel/process_64.c        |  2 +-
 arch/x86/kernel/traps.c             |  2 +-
 include/linux/sched.h               |  9 ---------
 12 files changed, 44 insertions(+), 24 deletions(-)

-- 
1.8.1.2
