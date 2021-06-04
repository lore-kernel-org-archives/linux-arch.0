Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C88C47425
	for <linux-arch@archiver.kernel.org>; Fri,  4 Jun 2021 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87658610E7
	for <linux-arch@archiver.kernel.org>; Fri,  4 Jun 2021 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFDQfu (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFDQfs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 12:35:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E999C061766;
        Fri,  4 Jun 2021 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N0LVJfeUK2IdvmsqBLNwzogFfs34S53qc1DZrppgaU4=; b=F8L7uCnO5EUTwc2U3xhWIM18n5
        MqFThaLx/mSiSAIcZhiI8pfFpDI2US2iFzGX4p3YqPCprDpHXO6iNsOLDDx6Q4MV50K28820aUkem
        TwftTZiRZirrmyljj143occwLCChEGCX6g4Ed+PXIU/5526DB9Z8Mj2+Jsbu0rpCPwbNmYvxyTBnz
        SxKLPIp8h22zQ6iHcRnB9amCzfGvNPuv/15cC+pyEoOi1UCdwkMxoOCm7mkstC+R/ppXr3GGlz4if
        GjyG+zpdnJ/8LaJ+CZ9/sJCLHwY5l8tRc+XEvAm5xZov581jPEFcZsW0jF3NgZyV/wwtjYN1LDkVn
        3P96FQig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpClV-003TzH-7M; Fri, 04 Jun 2021 16:33:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7AF9E3001DB;
        Fri,  4 Jun 2021 18:33:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 69893207AA26C; Fri,  4 Jun 2021 18:33:50 +0200 (CEST)
Date:   Fri, 4 Jun 2021 18:33:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <YLpV7qilaHkMc01f@hirez.programming.kicks-ass.net>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604160955.GG18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604160955.GG18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 11:09:55AM -0500, Segher Boessenkool wrote:
> I didn't find a description of the expected precise semantics anywhere
> in this patch.  This however is the most important thing required here!

Fair enough; so a control-dependency is a LOAD->STORE memory ordering
provided by conditional branches.

The conditional branch instruction itself must have a data dependency on
a previous LOAD, while the branch itself guards a STORE. Then because
speculative STOREs result in out-of-thin-air values, the STORE must not
become visible until the branch is decided, which can only be done if
the LOAD is complete.

We make use of this, and would like the compiler to not ruin this code
pattern for us.

So we need the STORE to say inside the selection statement, we need the
LOAD not be optimized away, and we need the conditional branch to be
emitted.

Alternatively, we need the LOAD to be upgraded to a LOAD-ACQUIRE (an
option on platforms where this is sufficiently cheap). Which will also
ensure the STORE happens after.

So we can force the LOAD using READ_ONCE() (a volatile cast).

We can prohibit hoisting by adding a compiler barrier to the expression.
And then we use asm goto() to force emit a conditional branch. Combined
this leaves the compiler very little room to mess things up, but it does
produce sub-optimal code, and doesn't allow the LOAD-ACQUIRE upgrade
Will would like (but he can't always have that anyway due to our other
use of asm()).


We also have a 'CONTROL DEPENDENCIES' section in
Documentation/memory-barriers.txt for further reading.
