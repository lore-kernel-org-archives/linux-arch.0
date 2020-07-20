From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 20 Jul 2020 12:12:36 -0400
Message-ID: <20200720161236.GF1228057@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
 <20200720153911.GX12769@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200720153911.GX12769@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 20, 2020 at 04:39:11PM +0100, Matthew Wilcox wrote:
> Honestly, even the term "release semantics" trips me up _every_ time.
> It's a barrier to understanding because I have to translate it into "Oh,
> he means it's like an unlock".  Why can't you just say "unlock semantics"?

It's not as bad as all that; people do talk about acquiring and 
releasing locks, and presumably you don't have any trouble understanding 
those terms.  In fact this usage is quite common -- and I believe it's 
where the names "acquire semantics" and "release semantics" came from 
originally.

Alan Stern
