From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC memory-model 0/6] LKMM updates
Date: Thu, 10 Jan 2019 10:47:26 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1901101046480.1497-100000@iolanthe.rowland.org>
References: <20190109210706.GA27268@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109210706.GA27268@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, willy@infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, 9 Jan 2019, Paul E. McKenney wrote:

> Hello!
> 
> This series contains updates for the Linux-kernel memory model:
> 
> 1-3.	Add SRCU support, courtesy of Alan Stern.
> 
> 4.	Update README for adding of SRCU support.
> 
> 5.	Update memory-barriers.txt on enforcing heavy ordering for
> 	port-I/O accesses, courtesy of Will Deacon.  This one needs
> 	an ack, preferably by someone from Intel.  Matthew Wilcox
> 	posted some feedback from an Intel manual here, which might
> 	be considered to be a close substitute, but...  ;-)
> 
> 	http://lkml.kernel.org/r/20181127192234.GF10377@bombadil.infradead.org
> 
> 6.	Update Documentation/explanation.txt to include SRCU support,
> 	courtesy of Alan Stern.
> 
> 7.	Dynamically check SRCU lock-to-unlock matching, courtesy of
> 	Luc Maranget.  This needs an ack.

Does this one still need an ack?  If so, you may apply mine.

Alan
