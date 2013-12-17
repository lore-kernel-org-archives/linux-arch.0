From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] doc: Rename LOCK/UNLOCK to ACQUIRE/RELEASE
Date: Tue, 17 Dec 2013 05:59:14 -0800
Message-ID: <20131217135914.GE5919@linux.vnet.ibm.com>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.726393081@infradead.org>
 <20131216201157.GI4200@linux.vnet.ibm.com>
 <20131217101323.GH21999@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:51343 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3LQN70 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2013 08:59:26 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 17 Dec 2013 06:59:26 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D6D121FF0027
	for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2013 06:58:58 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBHDxLla2163182
	for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2013 14:59:21 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id rBHE2P3E017263
	for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2013 07:02:27 -0700
Content-Disposition: inline
In-Reply-To: <20131217101323.GH21999@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kerne.org, geert@linux-m68k.org, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, mathieu.desnoyers@polymtl.ca, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

On Tue, Dec 17, 2013 at 11:13:23AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 16, 2013 at 12:11:57PM -0800, Paul E. McKenney wrote:
> > Should we rename smp_mb__before_spinlock() to be smp_mb__before_acquire()?
> 
> > > +ACQUIRE can be followed by an smp_mb__after_unlock_lock() invocation.  This
> > 
> > And should we rename this to be smp_mb__after_release_acquire()?
> > 
> > (I kind of hope not, as it is a bit more typing.)
> 
> you could name it: smp_mb__after_rel_acq(), which is shorter again :-)
> 
> But on both cases, I would propose to wait until we have a use-case
> where we need these barriers on !spinlocks.

Indeed, the number of uses will be small enough for quite some time to
allow renaming (or not) at our leisure.

							Thanx, Paul
