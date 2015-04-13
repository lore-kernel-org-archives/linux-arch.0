From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
 for the qspinlock
Date: Mon, 13 Apr 2015 16:47:29 +0200
Message-ID: <20150413144729.GG5029@twins.programming.kicks-ass.net>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
 <1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
 <20150409181327.GY5029@twins.programming.kicks-ass.net>
 <5526F218.2070909@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50411 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbbDMOrn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 10:47:43 -0400
Content-Disposition: inline
In-Reply-To: <5526F218.2070909@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Thu, Apr 09, 2015 at 05:41:44PM -0400, Waiman Long wrote:
> >>+void __init __pv_init_lock_hash(void)
> >>+{
> >>+	int pv_hash_size = 4 * num_possible_cpus();
> >>+
> >>+	if (pv_hash_size<  (1U<<  LFSR_MIN_BITS))
> >>+		pv_hash_size = (1U<<  LFSR_MIN_BITS);
> >>+	/*
> >>+	 * Allocate space from bootmem which should be page-size aligned
> >>+	 * and hence cacheline aligned.
> >>+	 */
> >>+	pv_lock_hash = alloc_large_system_hash("PV qspinlock",
> >>+					       sizeof(struct pv_hash_bucket),
> >>+					       pv_hash_size, 0, HASH_EARLY,
> >>+					&pv_lock_hash_bits, NULL,
> >>+					       pv_hash_size, pv_hash_size);
> >	pv_taps = lfsr_taps(pv_lock_hash_bits);
> >
> 
> I don't understand what you meant here.

Let me explain (even though I propose taking all the LFSR stuff out).

pv_lock_hash_bit is a runtime variable, therefore it cannot compile time
evaluate the forest of if statements required to compute the taps value.

Therefore its best to compute the taps _once_, and this seems like a
good place to do so.

> >>+				goto done;
> >>+			}
> >>+		}
> >>+
> >>+		hash = lfsr(hash, pv_lock_hash_bits, 0);
> >Since pv_lock_hash_bits is a variable, you end up running through that
> >massive if() forest to find the corresponding tap every single time. It
> >cannot compile-time optimize it.
> 
> The minimum bits size is now 8. So unless the system has more than 64 vCPUs,
> it will get the right value in the first if statement.

Still, no reason to not pre-compute the taps value, its simple enough.
