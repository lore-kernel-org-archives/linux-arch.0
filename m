From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Date: Wed, 28 Mar 2018 18:33:16 -0700
Message-ID: <20180329013316.GU3675@linux.vnet.ibm.com>
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
 <20180328175136.GL4082@hirez.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328175136.GL4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 28, 2018 at 07:51:36PM +0200, Peter Zijlstra wrote:
> On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> > I don't quite see the point of this.  You're not suggesting that we
> > have one Linux Kernel Memory Consistency Model for s390 and another
> > one for all the other architectures, are you?
> > 
> > If the idea is merely to provide a herd model for s390 then it should 
> > go into the DIY repository, not into the LKMM repository.
> 
> I suspect the use-case was validating s390 arch code which might not
> have followed all the regular linux rules because they know its TSO. But
> yes, I'm tempted to agree that even arch specific code ought to follow
> the regular rules, just to avoid completely messing up the reader.

Another use case is testing an s390 .cat file without having to teach
herd about s390 assembly.  ;-)

							Thanx, Paul
