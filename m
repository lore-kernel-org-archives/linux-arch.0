From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Wed, 28 Mar 2018 09:33:44 -0700
Message-ID: <20180328163344.GT3675@linux.vnet.ibm.com>
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> On Wed, 28 Mar 2018, Paul E. McKenney wrote:
> 
> > Hello!
> > 
> > The prototype patch shown below provides files required to allow herd7 to
> > evaluate C-language litmus tests for the multicopy-atomic TSO ordering
> > provided by s390.  This patch should be viewed with great suspicion.
> > It does what I expect it to do on SB (with and without barriers),
> > IRIW without barriers, and Alan's SB with read-of-write added, but my
> > expectations are quite likely faulty, and my test cases are very few
> > in number.
> > 
> > Either way, this is the easy part.  The hard part (which I am happy
> > to leave to others) is making litmus7 and klitmus7 able to do tests
> > on actual hardware, as well as enabling herd to handle litmus tests
> > containing BAL.  ;-)
> > 
> > Note that CPU architectures already supported by herd might well need
> > only a .cfg file that refers to herd's pre-existing support.
> > 
> > Thoughts?
> 
> I don't quite see the point of this.  You're not suggesting that we
> have one Linux Kernel Memory Consistency Model for s390 and another
> one for all the other architectures, are you?

Certainly not for common code!

> If the idea is merely to provide a herd model for s390 then it should 
> go into the DIY repository, not into the LKMM repository.

Makes sense.

In the meantime, does the cat file look to you like it correctly
models the combination of TSO and multicopy atomicity?  Do the
fences really work, or did I just get lucky with my choice of
litmus tests?

							Thanx, Paul
