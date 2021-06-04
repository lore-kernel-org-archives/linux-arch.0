Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F8C4743D
	for <linux-arch@archiver.kernel.org>; Fri,  4 Jun 2021 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82F061405
	for <linux-arch@archiver.kernel.org>; Fri,  4 Jun 2021 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFDRaO (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 4 Jun 2021 13:30:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:36337 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDRaO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 13:30:14 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154HO8PX031595;
        Fri, 4 Jun 2021 12:24:08 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154HO7YR031590;
        Fri, 4 Jun 2021 12:24:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 12:24:07 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210604172407.GJ18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com> <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net> <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 10:10:29AM -0700, Linus Torvalds wrote:
> The compiler *cannot* just say "oh, I'll do that 'volatile asm
> barrier' whether the condition is true or not". That would be a
> fundamental compiler bug.

Yes.

> Of course, we might want to make sure that the compiler doesn't go
> "oh, empty asm, I can ignore it",

It isn't allowed to do that.  GCC has this arguable misfeature where it
doesn't show empty asm in the assembler output, but that has no bearing
on anything but how human-readable the output is.


Segher
