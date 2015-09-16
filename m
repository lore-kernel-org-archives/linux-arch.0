From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] barriers: introduce smp_mb__release_acquire and update
 documentation
Date: Wed, 16 Sep 2015 12:43:14 +0200
Message-ID: <20150916104314.GA3604@twins.programming.kicks-ass.net>
References: <1442333610-16228-1-git-send-email-will.deacon@arm.com>
 <20150915174724.GP4029@linux.vnet.ibm.com>
 <20150916091452.GC3816@twins.programming.kicks-ass.net>
 <20150916102908.GA28771@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150916102908.GA28771@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 16, 2015 at 11:29:08AM +0100, Will Deacon wrote:
> > Indeed, that is a hole in the definition, that I think we should close.

> I'm struggling to understand the hole, but here's my intuition. If an
> ACQUIRE on CPUx reads from a RELEASE by CPUy, then I'd expect CPUx to
> observe all memory accessed performed by CPUy prior to the RELEASE
> before it observes the RELEASE itself, regardless of this new barrier.
> I think this matches what we currently have in memory-barriers.txt (i.e.
> acquire/release are neither transitive or multi-copy atomic).

Ah agreed. I seem to have gotten my brain in a tangle.

Basically where a program order release+acquire relies on an address
dependency, a cross cpu release+acquire relies on causality. If we
observe the release, we must also observe everything prior to it etc.
