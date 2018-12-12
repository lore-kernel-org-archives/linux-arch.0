From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Linux: Implement membarrier function
Date: Wed, 12 Dec 2018 13:04:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1812121302270.1543-100000@iolanthe.rowland.org>
References: <20181212170706.GA17397@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212170706.GA17397@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: David Goldblatt <davidtgoldblatt@gmail.com>, mathieu.desnoyers@efficios.com, Florian Weimer <fweimer@redhat.com>, triegel@redhat.com, libc-alpha@sourceware.org, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 12 Dec 2018, Paul E. McKenney wrote:

> > > > Or am I still missing something here?
> > > 
> > > You tell me...
> > 
> > I think I am on board.  ;-)
> 
> And more to the point, here is a three-process variant showing a cycle
> that is permitted:
> 
> 
>          P0      P1      P2
>          Wa=2    Wb=2    Wc=2
>          mb0s
>                  [mb01]  [mb02]
>          mb0e
>          Rb=0    Rc=0    Ra=0
> 
> As can be seen by reordering it as follows:
> 
>          P0      P1      P2
>                          Ra=0
>          Wa=2
>          mb0s
>                  [mb01]
>                  Rc=0
>                          Wc=2
>                          [mb02]
>          mb0e
>          Rb=0
>                  Wb=2
> 
> Make sense?

You got it!

Alan
