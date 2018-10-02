From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH memory-model 0/5] Updates to the formal memory model
Date: Tue, 2 Oct 2018 10:28:37 +0200
Message-ID: <20181002082837.GB69893@gmail.com>
References: <20180926182845.GA24839@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926182845.GA24839@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
List-Id: linux-arch.vger.kernel.org


* Paul E. McKenney <paulmck@linux.ibm.com> wrote:

> Hello, Ingo!
> 
> This series contains updates to the Linux kernel's formal memory model
> in tools/memory-model, along with corresponding changes in documentation
> and Linux-kernel code.  These patches are ready for inclusion into -tip.
> 
> 1.	Document litmus-test naming scheme.
> 
> 2.	Add extra ordering for locks and remove it for ordinary
> 	release/acquire, courtesy of Alan Stern.
> 
> 3.	Fix a README typo, courtesy of SeongJae Park.
> 
> 4.	Expand the list of LKMM limitations.
> 
> 5.	Replace smp_cond_acquire() with smp_cond_load_acquire(),
> 	courtesy of Andrea Parri.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  Documentation/memory-barriers.txt                                          |    3 
>  tools/memory-model/Documentation/explanation.txt                           |  186 +++++++---
>  tools/memory-model/Documentation/recipes.txt                               |    2 
>  tools/memory-model/README                                                  |   39 ++
>  tools/memory-model/linux-kernel.cat                                        |    8 
>  tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus |    7 
>  tools/memory-model/litmus-tests/README                                     |  104 +++++
>  7 files changed, 293 insertions(+), 56 deletions(-)

Applied to tip:locking/core, thanks Paul!

	Ingo
