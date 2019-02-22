From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Fri, 22 Feb 2019 14:00:14 +0100
Message-ID: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190222112128.GA7213@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 12:21:28PM +0100, Andrea Parri wrote:
> > What I do object to is a model that's weaker than any possible sane
> > hardware.
> 
> Not the first time I hear you calling this out.  And inevitably, every
> time, other slogans come to my mind:  "C is not an assembly language",

But it bloody well should be ;-)
