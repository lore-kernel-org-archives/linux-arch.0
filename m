From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Sat, 18 Jul 2015 08:14:14 +1000
Message-ID: <1437171254.28088.87.camel@kernel.crashing.org>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <1436826689.3948.233.camel@kernel.crashing.org>
	 <1436929578.10956.3.camel@ellerman.id.au> <20150715104420.GD1005@arm.com>
	 <1437012028.28475.2.camel@ellerman.id.au>
	 <1437023004.28088.27.camel@kernel.crashing.org>
	 <1437023695.28088.29.camel@kernel.crashing.org>
	 <20150716151142.GR3717@linux.vnet.ibm.com>
	 <1437087265.28088.53.camel@kernel.crashing.org>
	 <20150717093221.GB18994@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53658 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156AbbGQWPB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 17 Jul 2015 18:15:01 -0400
In-Reply-To: <20150717093221.GB18994@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Fri, 2015-07-17 at 10:32 +0100, Will Deacon wrote:
>  static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  {
> -       SYNC_IO;
> -       __asm__ __volatile__("# arch_spin_unlock\n\t"
> -                               PPC_RELEASE_BARRIER: : :"memory");
> +       smp_mb();
>         lock->slock = 0;
>  }

That probably needs to be mb() in case somebody has the expectation that
it does a barrier vs. DMA on UP.

Cheers,
Ben.
