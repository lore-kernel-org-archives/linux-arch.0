From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: LKMM patches for next merge window
Date: Thu, 25 Jun 2020 01:24:02 +0200
Message-ID: <20200624232402.GA465543@andrea>
References: <20200624185400.GA13594@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbgFXXYL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:24:11 -0400
Content-Disposition: inline
In-Reply-To: <20200624185400.GA13594@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>

On Wed, Jun 24, 2020 at 11:54:00AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Here is the list of LKMM patches I am considering for the next merge
> window and the status of each.  Any I am missing or any that need to
> wait or be modified?
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> 3ce5d69 docs: fix references for DMA*.txt files
> 	Could someone please provide an ack?

Fixing the N-th commit "move docs without updating in-tree references".
;-/

Most importantly there appears to be some on-going discussion about it,
cf.

  https://lkml.kernel.org/r/20200623072240.GA974@lst.de

(could you please sort this out?)

  Andrea


> 
> ac1a749 tools/memory-model: Add recent references
> be1ce3e tools/memory-model: Fix "conflict" definition
> 24dca63 Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
> 47ec95b Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
> bb2c938 MAINTAINERS: Update maintainers for new Documentation/litmus-tests
> 05bee9a tools/memory-model: Add an exception for limitations on _unless() family
> dc76257 Documentation/litmus-tests: Introduce atomic directory
> d059e50 Documentation/litmus-tests/atomic: Add a test for atomic_set()
> 7eecf76 Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()
> 116f054 tools/memory-model: Fix reference to litmus test in recipes.txt
> ffd32d4 Documentation/litmus-tests: Merge atomic's README into top-level one
> a08ae99 Documentation/litmus-tests: Cite an RCU litmus test
> 843285eb tools/memory-model/README: Expand dependency of klitmus7
> 0296c57 tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
> 47e4f0a Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test
> 	All ready to go.
