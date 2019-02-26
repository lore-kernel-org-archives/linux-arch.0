Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZJWB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 04:22:01 -0500
Date: Tue, 26 Feb 2019 10:21:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226092143.GR32477@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225175517.GK4072@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226092143.Kc1t6rtXhapM0kvJ-rvvIia_DhKm55mtugg-V8_dmxA@z>

On Mon, Feb 25, 2019 at 09:55:17AM -0800, Paul E. McKenney wrote:
> Again, if you know of any code in the Linux kernel that would have
> problems with aggressive optimizations based on pointer provenance,
> please let me know!

I've no clue what pointer provenance is to begin with.
