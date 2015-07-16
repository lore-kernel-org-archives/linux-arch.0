From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Thu, 16 Jul 2015 08:11:42 -0700
Message-ID: <20150716151142.GR3717@linux.vnet.ibm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <1436826689.3948.233.camel@kernel.crashing.org>
 <1436929578.10956.3.camel@ellerman.id.au>
 <20150715104420.GD1005@arm.com>
 <1437012028.28475.2.camel@ellerman.id.au>
 <1437023004.28088.27.camel@kernel.crashing.org>
 <1437023695.28088.29.camel@kernel.crashing.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:60472 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbGPPLy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2015 11:11:54 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 16 Jul 2015 09:11:54 -0600
Content-Disposition: inline
In-Reply-To: <1437023695.28088.29.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

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

Well, the architecture isn't expecting that crazies like myself would
want to have an unlock-lock provide ordering to some CPU not holding
the lock.  :-/

							Thanx, Paul
