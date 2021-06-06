Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CBFC4743E
	for <linux-arch@archiver.kernel.org>; Sun,  6 Jun 2021 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCA3613AD
	for <linux-arch@archiver.kernel.org>; Sun,  6 Jun 2021 19:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFFT65 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 6 Jun 2021 15:58:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:47652 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhFFT64 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 15:58:56 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156JqiJX012123;
        Sun, 6 Jun 2021 14:52:44 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156JqgQT012119;
        Sun, 6 Jun 2021 14:52:42 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 14:52:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210606195242.GA18427@gate.crashing.org>
References: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com> <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org> <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 11:48:32AM -0700, Linus Torvalds wrote:
> On Sun, Jun 6, 2021 at 11:43 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > You truly should have written a branch in tthe asm if you truly wanted
> > a branch instruction.
> 
> That's exactly what I don't want to do, and what the original patch by
> PeterZ did.

Yes, I know.  But it is literally the *only* way to *always* get a
conditional branch: by writing one.

> And to work well, it needs "asm goto", which is so recent that a lot
> of compilers don't support it (thank God for clang dragging gcc
> kicking and screaming to implement it at all - I'd asked for it over a
> decade ago).

GCC has had it since 2009.

> So you get bad code generation in a lot of cases, which entirely
> obviates the _point_ of this all - which is that we can avoid an
> expensive operation (a memory barrier) by just doing clever code
> generation.
> 
> So if we can't get the clever code generation, it's all pretty much
> moot, imnsho.

Yes.


Segher
