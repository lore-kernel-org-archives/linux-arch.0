From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
Date: Fri, 14 Sep 2018 13:19:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1809141315580.1482-100000@iolanthe.rowland.org>
References: <20180914163649.GA13942@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914163649.GA13942@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, Will Deacon <will.deacon@arm.com>, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, 14 Sep 2018, Paul E. McKenney wrote:

> 	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
> 
> 		Small change, needs an ack.  Looks to me like is is
> 		just aligning the documentation with the code, so
> 		should not be controversial (famous last words).
> 
> 		Please take a look and consider giving feedback
> 		and/or a review/ack.

What branch is this commit in?  It doesn't seem to be in the lkmm 
branch.

In any case, the change is trivial and obviously correct.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan
