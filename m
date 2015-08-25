From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL rcu/next] Additional RCU commit for 4.3
Date: Tue, 25 Aug 2015 09:46:31 +0200
Message-ID: <20150825074631.GA25158@gmail.com>
References: <20150825000311.GA32412@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150825000311.GA32412@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, benh@kernel.crashing.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org


* Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:

> Hello, Ingo,
> 
> This additional series contains a single change:
> 
> 1.	Privatize smp_mb__after_unlock_lock().  This commit moves the
> 	definition of smp_mb__after_unlock_lock() to kernel/rcu/tree.h,
> 	in recognition of the fact that RCU is the only thing using
> 	this, that nothing else is likely to use it, and that it is
> 	likely to go away completely.
> 
> This change has been subjected to 0day Test Robot and -next testing,
> and is available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to 12d560f4ea87030667438a169912380be00cea4b:
> 
>   rcu,locking: Privatize smp_mb__after_unlock_lock() (2015-08-04 08:49:21 -0700)
> 
> ----------------------------------------------------------------
> Paul E. McKenney (1):
>       rcu,locking: Privatize smp_mb__after_unlock_lock()
> 
>  Documentation/memory-barriers.txt   | 71 +++----------------------------------
>  arch/powerpc/include/asm/spinlock.h |  2 --
>  include/linux/spinlock.h            | 10 ------
>  kernel/rcu/tree.h                   | 12 +++++++
>  4 files changed, 16 insertions(+), 79 deletions(-)

Pulled, thanks a lot Paul!

	Ingo
