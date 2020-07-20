From: peterz@infradead.org
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 20 Jul 2020 18:48:50 +0200
Message-ID: <20200720164850.GF119549@hirez.programming.kicks-ass.net>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
 <20200720153911.GX12769@casper.infradead.org>
 <20200720160433.GQ9247@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200720160433.GQ9247@paulmck-ThinkPad-P72>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 20, 2020 at 09:04:34AM -0700, Paul E. McKenney wrote:
> 2.	If we were to say "unlock" instead of "release", consistency
> 	would demand that we also say "lock" instead of "acquire".
> 	But "lock" is subtlely different than "acquire", and there is
> 	a history of people requesting further divergence.

This, acquire/release are RCpc, while (with the exception of Power)
LOCK/UNLOCK are RCsc.

( Or did we settle on RCtso for our release/acquire order? I have vague
memories of a long-ish thread, but seem to have forgotten the outcome,
if any. )

Lots of subtlety and head-aches right about there. Anyway, it would be
awesome if we can get Power into the RCsc locking camp :-)
