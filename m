From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering
 provided by smp_mb__{before,after}_atomic()")
Date: Fri, 3 May 2019 17:19:15 +0200
Message-ID: <20190503151915.GD2606@hirez.programming.kicks-ass.net>
References: <20190503145326.GA21541@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190503145326.GA21541@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> Hello, Alan,
> 
> Just following up on the -rcu commit below.  I believe that it needs
> some adjustment given Peter Zijlstra's addition of "memory" to the x86
> non-value-returning atomics, but thought I should double-check.

Right; I should get back to that thread...
