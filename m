Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760EC4320A
	for <linux-arch@archiver.kernel.org>; Sat,  7 Aug 2021 00:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F365E611C3
	for <linux-arch@archiver.kernel.org>; Sat,  7 Aug 2021 00:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhHGAvs (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 6 Aug 2021 20:51:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38047 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229707AbhHGAvs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Aug 2021 20:51:48 -0400
Received: (qmail 476927 invoked by uid 1000); 6 Aug 2021 20:51:30 -0400
Date:   Fri, 6 Aug 2021 20:51:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jade Alglave <j.alglave@ucl.ac.uk>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210807005130.GA476712@rowland.harvard.edu>
References: <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
 <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 06:20:22PM +0100, Jade Alglave wrote:
> I hope this material can help inform this conversation and I would love
> to hear your thoughts.

Thoughts on section 4...

The definition of Pick Basic dependency is phrased incorrectly.  The 
"all of the following apply" in the first paragraph refers only to first 
bullet point, which in turn refers to the following two bullet points.  
The "all of the following apply" phrase should be removed and the first 
bullet point should be merged into the main text.

The definition of Pick dependency is redundant, because each Pick 
Address and Pick Data dependency is itself already a Pick Basic 
dependency.  The same is true of the cat formalization.

In the cat code, the definition of Reg looks wrong.  It is:

	let Reg=~M | ~BR

Since (I presume) no event falls into both the M and BR classes, this 
definition includes all events.  It probably should be:

	let Reg=~(M | BR)

or

	let Reg=~M & ~BR

It's now clear that my original understanding of the underlying basis of 
Intrinsic control dependencies was wrong.  They aren't separated out 
because CPUs can speculate through conditional branches; rather they are 
separated out because they are the things which give rise to Pick 
dependencies.  It would have been nice if the text had explained this at 
the start instead of leaving it up to me to figure out for myself.

Alan
