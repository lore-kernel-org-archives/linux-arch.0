Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E74C47095
	for <linux-arch@archiver.kernel.org>; Mon,  7 Jun 2021 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB3A6109F
	for <linux-arch@archiver.kernel.org>; Mon,  7 Jun 2021 14:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGOTF (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:19:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:34547 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFGOTE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 10:19:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157ECiL5002016;
        Mon, 7 Jun 2021 09:12:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157ECgwD002012;
        Mon, 7 Jun 2021 09:12:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 09:12:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210607141242.GD18427@gate.crashing.org>
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org> <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com> <20210606195242.GA18427@gate.crashing.org> <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com> <20210606202616.GC18427@gate.crashing.org> <20210606233729.GN4397@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606233729.GN4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 04:37:29PM -0700, Paul E. McKenney wrote:
> > > The barrier() thing can work - all we need to do is to simply make it
> > > impossible for gcc to validly create anything but a conditional
> > > branch.
> > 
> > And the only foolproof way of doing that is by writing a branch.

[ ... ]

> > I am saying that if you depend on that some C code you write will result
> > in some particular machine code, without actually *forcing* the compiler
> > to output that exact machine code, then you will be disappointed.  Maybe
> > not today, and maybe it will take years, if you are lucky.
> > 
> > (s/forcing/instructing/ of course, compilers have feelings too!)
> 
> OK, I will bite...
> 
> What would you suggest as a way of instructing the compiler to emit the
> conditional branch that we are looking for?

You write it in the assembler code.

Yes, it sucks.  But it is the only way to get a branch if you really
want one.  Now, you do not really need one here anyway, so there may be
some other way to satisfy the actual requirements.


Segher
