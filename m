Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35431 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVLVh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 06:21:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id y15so1629937wma.0
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 03:21:35 -0800 (PST)
Date: Fri, 22 Feb 2019 12:21:28 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190222112128.GA7213@andrea>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190222112128.q4iueSP12GV6Lca75_Ohsaxs88bRc5BlMxsKOTeesOk@z>

> What I do object to is a model that's weaker than any possible sane
> hardware.

Not the first time I hear you calling this out.  And inevitably, every
time, other slogans come to my mind:  "C is not an assembly language",
"No features (ordering) without users", ...

For the record, I won't try to push this patch further; I also have no
plans to touch herd7 internals in order to add the ad-hoc flag for the
(dep ; rfi) thing.  (Maybe others will/can step in here.)

In the meantime, the hope (admittedly, probably vain) is that this RFC
could serve as a further warning or as a reference to those developers
who are quivering to use (dep ; rfi): enjoy it, be careful.

  Andrea
