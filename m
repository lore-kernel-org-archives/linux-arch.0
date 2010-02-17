From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 0/5] seqlock: cleanup, raw_seqlock implementation,
	xtime_lock conversion
Date: Wed, 17 Feb 2010 18:47:31 -0000
Message-ID: <20100217183740.486724334@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, John Stultz <johnstul@us.ibm.com>
List-Id: linux-arch.vger.kernel.org

The following series contains the following changes:

    - fix the last users of the oldstyle seqlock initializer 

    - implement raw_seqlock (for seqlocks which need a raw_spinlock in
      preempt-rt

    - convert xtime_lock to raw_seqlock and fix up all users

    - convert x86 vsyscall gtod seqlock to raw_seqlock

The patches have been used in the preempt-rt tree for quite a while
and are a defacto NOP change for mainline, but merging them takes off
the burden from preempt-rt.

Please review and comment.

Thanks,

	tglx
