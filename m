From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] ARC: add smp barriers around atomics per
 Documentation/atomic_ops.txt
Date: Fri, 12 Jun 2015 15:04:50 +0200
Message-ID: <20150612130450.GY19282@twins.programming.kicks-ass.net>
References: <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
 <1434111359-6925-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434111359-6925-1-git-send-email-vgupta@synopsys.com>
Sender: stable-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Although I'd love to know why you need those extra barriers in your
spinlocks...
