From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] ARC: add smp barriers around atomics per
 Documentation/atomic_ops.txt
Date: Fri, 12 Jun 2015 13:16:27 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A55A0@IN01WEMBXB.internal.synopsys.com>
References: <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
 <1434111359-6925-1-git-send-email-vgupta@synopsys.com>
 <20150612130450.GY19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Friday 12 June 2015 06:35 PM, Peter Zijlstra wrote:

On Fri, Jun 12, 2015 at 05:45:59PM +0530, Vineet Gupta wrote:


>  - arch_spin_lock/unlock were lacking the ACQUIRE/RELEASE barriers
>    Since ARCv2 only provides load/load, store/store and all/all, we need
>    the full barrier
>
>  - LLOCK/SCOND based atomics, bitops, cmpxchg, which return modified
>    values were lacking the explicit smp barriers.
>
>  - Non LLOCK/SCOND varaints don't need the explicit barriers since that
>    is implicity provided by the spin locks used to implement the
>    critical section (the spin lock barriers in turn are also fixed in
>    this commit as explained above


And iirc you're relying on asm-generic/barrier.h to issue
smp_mb__{before,after}_atomic() as smp_mb(), right?

Yep !



Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org><mailto:peterz@infradead.org>

Thx !


Although I'd love to know why you need those extra barriers in your
spinlocks...


I'll keep you posted as I'd like to get rid of them too. But there's bunch of stuff going on ATM so can't really jump into investigating that. Will need some wrestling with perf... which makes me think that I'd posted a bunch of perf patches for ARC/ARCv2 as well - can u please take alook at them sometime soon !

Thx,
-Vineet
