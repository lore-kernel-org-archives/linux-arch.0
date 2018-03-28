From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Wed, 28 Mar 2018 15:48:13 +0200
Message-ID: <20180328134813.GF4082@hirez.programming.kicks-ass.net>
References: <20180328134232.GA29274@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328134232.GA29274@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 28, 2018 at 06:42:32AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> The prototype patch shown below provides files required to allow herd7 to
> evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> provided by s390.  

There really isn't anything s390 specific here is there? That is, would
this not equally work for x86 and sparc, both of which are similarly TSO
?

Given that, should this not be called TSO instead of s390 ?
