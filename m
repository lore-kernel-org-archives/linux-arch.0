From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Sat, 8 Sep 2018 11:58:48 +0200
Message-ID: <20180908095848.GA6272@andrea>
References: <20990a3f-1507-c98b-f14e-2f5241319d8c@nvidia.com>
 <Pine.LNX.4.44L0.1809071256340.1547-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809071256340.1547-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Lustig <dlustig@nvidia.com>, Will Deacon <will.deacon@arm.com>, Andrea Parri <parri.andrea@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Kernel development list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com, Palmer Dabbelt <palmer@sifive.com>
List-Id: linux-arch.vger.kernel.org

> Will feels strongly (and Linus agrees) that the LKMM should not require
> ordinary acquire and release to be any stronger than RCpc.
> 
> The issue that Andrea raised has to do with qspinlock, qrwlock, and
> mcs_spinlock, which are implemented using smp_cond_load_acquire()  
> instead of RMW-acquire.  This provides only the ordering properties of
> smp_load_acquire(), namely RCpc, which means that qspinlocks etc. might
> not be RCtso.
> 
> Since we do want locks to be RCtso, the question is how to resolve this 
> discrepancy.

[...]

> To tell the truth, I'm not aware of any code in the kernel that
> actually _needs_ RCtso ordering for locks, but Peter and Will are quite
> firm that it should be required.  Linus would actually like locks to be
> RCsc, but he recognizes that this would incur a noticeable performance
> penalty on Power so he'll settle for RCtso.

It does look like Will, Peter, Linus and me could help you put together
a satisfactory patch description! ;-)  I'm not sure I agree with all
you're claiming/concluding above..., but again: why don't you try to
collect what, in your opinion, are the relevant arguments/comments from
previous reviews of the patch (which, unfortunately, goes back to July)
and then send an updated version?  (I do have the impression that these
discussions would have been much more "easy to follow" if you only did
that time ago/with higher frequency...)

  Andrea
