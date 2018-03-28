Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41838 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeC1Rvr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Mar 2018 13:51:47 -0400
Date: Wed, 28 Mar 2018 19:51:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC tools/memory-model] Add s390.{cfg,cat}
Message-ID: <20180328175136.GL4082@hirez.programming.kicks-ass.net>
References: <20180328134232.GA29274@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1803281057280.1375-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180328175136.hwhwizgymUpa1BmcpY3SuiUagNWYVD5NqRiNfktNqMA@z>

On Wed, Mar 28, 2018 at 11:01:25AM -0400, Alan Stern wrote:
> I don't quite see the point of this.  You're not suggesting that we
> have one Linux Kernel Memory Consistency Model for s390 and another
> one for all the other architectures, are you?
> 
> If the idea is merely to provide a herd model for s390 then it should 
> go into the DIY repository, not into the LKMM repository.

I suspect the use-case was validating s390 arch code which might not
have followed all the regular linux rules because they know its TSO. But
yes, I'm tempted to agree that even arch specific code ought to follow
the regular rules, just to avoid completely messing up the reader.
