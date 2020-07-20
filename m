From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 20 Jul 2020 16:39:11 +0100
Message-ID: <20200720153911.GX12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200720145211.GC1228057@rowland.harvard.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 20, 2020 at 10:52:11AM -0400, Alan Stern wrote:
> On Mon, Jul 20, 2020 at 11:33:20AM +1000, Dave Chinner wrote:
> > On Sat, Jul 18, 2020 at 10:08:11AM -0400, Alan Stern wrote:
> > > > This is one of the reasons that the LKMM documetnation is so damn
> > > > difficult to read and understand: just understanding the vocabulary
> > > > it uses requires a huge learning curve, and it's not defined
> > > > anywhere. Understanding the syntax of examples requires a huge
> > > > learning curve, because it's not defined anywhere. 
> > > 
> > > Have you seen tools/memory-model/Documentation/explanation.txt?
> > 
> > <raises eyebrow>
> > 
> > Well, yes. Several times. I look at it almost daily, but that
> > doesn't mean it's approachable, easy to read or even -that I
> > understand what large parts of it say-. IOWs, that's one of the 
> > problematic documents that I've been saying have a huge learning
> > curve.
> 
> Can you be more specific?  For example, exactly where does it start to 
> become unapproachable or difficult to read?
> 
> Don't forget that this document was meant to help mitigate the LKMM's 
> learning curve.  If it isn't successful, I want to improve it.

I can't speak for Dave, but the introduction to that documentation makes
it clear to me that it's not the document I want to read.

: This document describes the ideas underlying the LKMM.  It is meant
: for people who want to understand how the model was designed.  It does
: not go into the details of the code in the .bell and .cat files;
: rather, it explains in English what the code expresses symbolically.

I don't want to know how the model was designed.  I want to write a
device driver, or filesystem, or whatever.

Honestly, even the term "release semantics" trips me up _every_ time.
It's a barrier to understanding because I have to translate it into "Oh,
he means it's like an unlock".  Why can't you just say "unlock semantics"?
