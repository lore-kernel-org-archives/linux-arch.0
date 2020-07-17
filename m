From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Fri, 17 Jul 2020 13:51:38 -0400
Message-ID: <20200717175138.GB1156312@rowland.harvard.edu>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:33613 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727121AbgGQRvj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 13:51:39 -0400
Content-Disposition: inline
In-Reply-To: <20200717174750.GQ12769@casper.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
...
> > +		/* on success, pairs with smp_load_acquire() above and below */
> > +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> 
> Why do we have cmpxchg_release() anyway?  Under what circumstances is
> cmpxchg() useful _without_ having release semantics?

To answer just the last question: cmpxchg() is useful for lock 
acquisition, in which case it needs to have acquire semantics rather 
than release semantics.

Alan Stern
