From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 15:09:16 +0100
Message-ID: <20150713140915.GD2632@arm.com>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <20150713131143.GY19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713131143.GY19282@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 13, 2015 at 02:11:43PM +0100, Peter Zijlstra wrote:
> On Mon, Jul 13, 2015 at 01:15:04PM +0100, Will Deacon wrote:
> > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > into a full memory barrier.
> > 
> > However:
> 
> >   - The barrier only applies to UNLOCK + LOCK, not general
> >     RELEASE + ACQUIRE operations
> 
> No it does too; note that on ppc both acquire and release use lwsync and
> two lwsyncs do not make a sync.

Really? IIUC, that means smp_mb__after_unlock_lock needs to be a full
barrier on all architectures implementing smp_store_release as smp_mb() +
STORE, otherwise the following isn't ordered:

  RELEASE X
  smp_mb__after_unlock_lock()
  ACQUIRE Y

On 32-bit ARM (at least), the ACQUIRE can be observed before the RELEASE.

Will
