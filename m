From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Date: Wed, 20 Feb 2019 10:30:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1902201028400.1589-100000@iolanthe.rowland.org>
References: <20190220134106.GA7523@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220134106.GA7523@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
List-Id: linux-arch.vger.kernel.org

On Wed, 20 Feb 2019, Will Deacon wrote:

> Whilst I completely agree that relying on the ordering provided by "dep ;
> rfi" is subtle and error prone, having it forbid the outcome above appeals
> to a hardware-based mindset of how memory ordering works. In the kernel
> community, I would posit that the majority of developers are writing code
> with the underlying hardware in mind and so allowing behaviours in the
> memory model which are counter to how a real machine operates is likely to
> make things more confusing, rather than simplifying them!
> 
> IIRC, herd has a feature where you can "flag" the result of a litmus test
> to highlight certain internal constraint violations (e.g. warning that a
> data race is present in a concurrent C11 program). How about we preserve
> the existing semantics, but flag any use of "dep; rfi" to indicate that
> the ordering guarantees being relied upon are subtle and error-prone, and
> therefore should only be considered for fast-path code?

Unfortunately, herd can't really tell whether a particular ordering is 
being _used_; it can only tell when the ordering is present.  Therefore 
such a flag would be prone to false positives.

Alan
