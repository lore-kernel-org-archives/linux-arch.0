From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Thu, 20 Apr 2017 21:05:30 +0200
Message-ID: <20170420190530.GA6873@worktop>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
 <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
 <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:58222 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946804AbdDTTRG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2017 15:17:06 -0400
Content-Disposition: inline
In-Reply-To: <20170420182318.4ddtfiobxz6hgbo4@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>

On Thu, Apr 20, 2017 at 09:23:18PM +0300, Yury Norov wrote:
> Is there some test to reproduce the locking failure for the case.

Possibly sysvsem stress before commit:

  27d7be1801a4 ("ipc/sem.c: avoid using spin_unlock_wait()")

Although a similar scheme is also used in nf_conntrack, see commit:

  b316ff783d17 ("locking/spinlock, netfilter: Fix nf_conntrack_lock() barriers")

> I
> ask because I run loctorture for many hours on my qemu (emulating
> cortex-a57), and I see no failures in the test reports. And Jan did it
> on ThunderX, and Adam on QDF2400 without any problems. So even if I
> rework those functions, how could I check them for correctness?

Running them doesn't prove them correct. Memory ordering bugs have been
in the kernel for many years without 'ever' triggering. This is stuff
you have to think about.

> Anyway, regarding the queued_spin_unlock_wait(), is my understanding
> correct that you assume adding smp_mb() before entering the for(;;)
> cycle, and using ldaxr/strxr instead of atomic_read()?

You'll have to ask Will, I always forget the arm64 details.
