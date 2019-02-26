From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Tue, 26 Feb 2019 14:49:06 +0100
Message-ID: <20190226134906.GG32494@hirez.programming.kicks-ass.net>
References: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190226113813.GA14753@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> > When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> > still broken.
> 
> As requested on IRC:

What I asked was if you could get your GCC developer friends to have a
look at this :-)
