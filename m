From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 20 Jul 2020 11:00:50 +0200
Message-ID: <20200720090050.GK10769@hirez.programming.kicks-ass.net>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
 <20200720020731.GQ5369@dread.disaster.area>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTJBU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 05:01:20 -0400
Content-Disposition: inline
In-Reply-To: <20200720020731.GQ5369@dread.disaster.area>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>

On Mon, Jul 20, 2020 at 12:07:31PM +1000, Dave Chinner wrote:
> The whole serialisation/atomic/ordering APIs have fallen badly off
> the macro cliff, to the point where finding out something as simple
> as the order of parameters passed to cmpxchg and what semantics it
> provides requires macro-spelunking 5 layers deep to find the generic
> implementation function that contains a comment describing what it
> does....
> 
> That's yet another barrier to understanding what all the different
> synchronisation primitives do.

Documentation/atomic_t.txt ?
