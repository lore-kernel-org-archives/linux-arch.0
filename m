From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 15:21:10 +0100
Message-ID: <20150713142109.GE2632@arm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
 <20150713140915.GD2632@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58051 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbbGMOVN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 10:21:13 -0400
Content-Disposition: inline
In-Reply-To: <20150713140915.GD2632@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, Jul 13, 2015 at 03:09:15PM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2015 at 02:11:43PM +0100, Peter Zijlstra wrote:
> > On Mon, Jul 13, 2015 at 01:15:04PM +0100, Will Deacon wrote:
> > > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > > into a full memory barrier.
> > > 
> > > However:
> > 
> > >   - The barrier only applies to UNLOCK + LOCK, not general
> > >     RELEASE + ACQUIRE operations
> > 
> > No it does too; note that on ppc both acquire and release use lwsync and
> > two lwsyncs do not make a sync.
> 
> Really? IIUC, that means smp_mb__after_unlock_lock needs to be a full
> barrier on all architectures implementing smp_store_release as smp_mb() +
> STORE, otherwise the following isn't ordered:
> 
>   RELEASE X
>   smp_mb__after_unlock_lock()
>   ACQUIRE Y
> 
> On 32-bit ARM (at least), the ACQUIRE can be observed before the RELEASE.

I knew we'd had this conversation before ;)

  http://lkml.kernel.org/r/20150120093443.GA11596@twins.programming.kicks-ass.net

Will
