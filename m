From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 1 Sep 2015 12:57:16 +1000
Message-ID: <20150901025716.GA28069@fergus.ozlabs.ibm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <1436826689.3948.233.camel@kernel.crashing.org>
 <1436929578.10956.3.camel@ellerman.id.au>
 <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:35178 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbbIAC5j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 31 Aug 2015 22:57:39 -0400
Content-Disposition: inline
In-Reply-To: <1437023695.28088.29.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>

On Thu, Jul 16, 2015 at 03:14:55PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2015-07-16 at 15:03 +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2015-07-16 at 12:00 +1000, Michael Ellerman wrote:
> > > That would fix the problem with smp_mb__after_unlock_lock(), but not
> > > the original worry we had about loads happening before the SC in lock.
> > 
> > However I think isync fixes *that* :-) The problem with isync is as you
> > said, it's not a -memory- barrier per-se, it's an execution barrier /
> > context synchronizing instruction. The combination stwcx. + bne + isync
> > however prevents the execution of anything past the isync until the
> > stwcx has completed and the bne has been "decided", which prevents loads
> > from leaking into the LL/SC loop. It will also prevent a store in the
> > lock from being issued before the stwcx. has completed. It does *not*
> > prevent as far as I can tell another unrelated store before the lock
> > from leaking into the lock, including the one used to unlock a different
> > lock.
> 
> Except that the architecture says:
> 
> <<
> Because a Store Conditional instruction may com-
> plete before its store has been performed, a condi-
> tional Branch instruction that depends on the CR0
> value set by a Store Conditional instruction does
> not order the Store Conditional's store with respect
> to storage accesses caused by instructions that
> follow the Branch
> >>
> 
> So isync in lock in architecturally incorrect, despite being what the
> architecture recommends using, yay !

That paragraph doesn't say anything about isync.  Doing stcx., bne,
isync to acquire a lock will ensure that the instructions inside the
locked region can't execute until the lock is globally known to be
acquired.  It is true that another CPU that doesn't take the lock
could see the effect of some load or store inside the locked region
and then see the lock variable itself being clear; but any CPU that
tried to acquire the lock would have its stcx. fail (at least until
the first CPU releases the lock).

So isync in the lock sequence is architecturally correct.

Paul.
