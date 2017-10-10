From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tip/core/rcu 12/15] lib/assoc_array: Remove
 smp_read_barrier_depends()
Date: Tue, 10 Oct 2017 10:39:48 +0200
Message-ID: <20171010083948.5s6bmggp3cyqtkrf@hirez.programming.kicks-ass.net>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507594969-8347-12-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, will.deacon@arm.com, Jonathan Corbet <corbet@lwn.net>, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 09, 2017 at 05:22:46PM -0700, Paul E. McKenney wrote:
> Now that smp_read_barrier_depends() is implied by READ_ONCE(), adding
> READ_ONCE() to assoc_array_ptr_to_leaf() and __assoc_array_ptr_to_meta()
> allows the several smp_read_barrier_depends() calls to be removed from
> lib/assoc_array.c.  This commit makes this change.

So arguably this code was broken for not already having READ_ONCE().
