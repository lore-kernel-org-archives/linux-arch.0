From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH RFC memory-model 0/7] Memory-model changes
Date: Fri, 14 Sep 2018 11:29:21 -0700
Message-ID: <20180914182921.GC652@linux.ibm.com>
References: <20180914163649.GA13942@linux.ibm.com>
 <Pine.LNX.4.44L0.1809141315580.1482-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809141315580.1482-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, Will Deacon <will.deacon@arm.com>, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 14, 2018 at 01:19:37PM -0400, Alan Stern wrote:
> On Fri, 14 Sep 2018, Paul E. McKenney wrote:
> 
> > 	bf36a3124d04 doc: Replace smp_cond_acquire() with smp_cond_load_acquire()
> > 
> > 		Small change, needs an ack.  Looks to me like is is
> > 		just aligning the documentation with the code, so
> > 		should not be controversial (famous last words).
> > 
> > 		Please take a look and consider giving feedback
> > 		and/or a review/ack.
> 
> What branch is this commit in?  It doesn't seem to be in the lkmm 
> branch.

It was in the dev branch, and was the child of the lkmm branch.

> In any case, the change is trivial and obviously correct.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thank you, applied!

And now it is in the lkmm branch.  ;-)

							Thanx, Paul
