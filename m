Return-Path: <SRS0=bmjM=EC=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E18C5DF9E
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E9620878
	for <linux-arch@archiver.kernel.org>; Tue, 27 Oct 2020 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nb5TdCtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820549AbgJ0Rfo (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 27 Oct 2020 13:35:44 -0400
Received: from casper.infradead.org ([90.155.50.34]:50424 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1820358AbgJ0RfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 13:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MPDUF57u1hELpOfEiLImNiVBP9JixgQ92DNJ5FJn8hY=; b=Nb5TdCtO246DlHFdgC4KJqhLkS
        KYJRAE4xREeZYue9Zh4/uo1LR4kKoEmZpguVfoKSrpKQlrLpMaXt1jaabwnt2BoEXTZ5Wramsxbpz
        WG6gpLX6fb+pLO/Nawk2gLlRFMklT6U4kOByALv98L/xT+cdtOgHKEkAFkcwy7xsqa4xx13Fq/I5I
        A/DqoaU3GJ+n5qrGEnYFP2aixQ2hVbMTj0oINxQMyBSOkTmnv95M37QtercLyF4Skcrjn06+/HCLL
        R0XLbIBwauTLc0TQghfBuXIkwz+Z4+JbFLykNL4+9f41r5U+Kes/9nATsxXikUItACLV280nuQfSE
        gIAnf/Qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXSri-0005UV-9I; Tue, 27 Oct 2020 17:34:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43832307BD0;
        Tue, 27 Oct 2020 18:34:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14B59203CF3A8; Tue, 27 Oct 2020 18:34:31 +0100 (CET)
Date:   Tue, 27 Oct 2020 18:34:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qspinlock: use signed temporaries for cmpxchg
Message-ID: <20201027173431.GE2611@hirez.programming.kicks-ass.net>
References: <20201026165807.3724647-1-arnd@kernel.org>
 <022365e9-f7fe-5589-7867-d2ad2d33cfa3@redhat.com>
 <20201027074726.GX2611@hirez.programming.kicks-ass.net>
 <CAK8P3a2vUK5scbtcRTE98ZvwxMF3xMBT61JODV__RHMj+D0G2A@mail.gmail.com>
 <20201027103236.GZ2611@hirez.programming.kicks-ass.net>
 <CAK8P3a3GqsXcdA59V7XGd_yFr_68yCaftdc-wMM6bHG8NEE1+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3GqsXcdA59V7XGd_yFr_68yCaftdc-wMM6bHG8NEE1+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 05:22:48PM +0100, Arnd Bergmann wrote:
> I have already sent patches to move -Wnested-externs and
> -Wcast-align from W=2 to W=3, and I guess -Wpointer-sign
> could be handled the same way to make the W=2 level useful
> again.

Works for me ;-), thanks!
