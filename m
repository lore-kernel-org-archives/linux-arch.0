Return-Path: <SRS0=fuLN=BW=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C7DC433E0
	for <linux-arch@archiver.kernel.org>; Wed, 12 Aug 2020 10:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3220838
	for <linux-arch@archiver.kernel.org>; Wed, 12 Aug 2020 10:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KA3A4rKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHLKhR (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLKhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2020 06:37:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDCC06174A;
        Wed, 12 Aug 2020 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a6/dAk8hzb0WYY+kQF71Fgx1O3nwOedWBapk4f0aaOE=; b=KA3A4rKfqtBkAolbpGhZQn0gae
        rIqsIfEejxM64L+YMTBJUSvg9fEFIfvHxwctOuhc9kOyfSdozptYsA0jAOiKaRSfUdNi72MKP9/pK
        nkS/znp2LKbSteLjA3WozUbWSHli0WpEytH2VWZvz/eAOBqRX+XYtpWzwnEOCloZYCLFOC3afCNHm
        rkq0HuJB3Rc7Zw8PRD3F29LxE2f6cEgqiZbZbThXq4+UEfKq9D08M/+swMXJRha+LvkLztxW2QGL2
        ViWxhZVhOuYLHsAyeFHBmHL/uIcJ0MWeVdzlotQr4696vPqatWO8tc8k9EQnzrdgHJJkzsiPQxZg3
        zd6QAwzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5o6c-0008Cw-Cp; Wed, 12 Aug 2020 10:36:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 911FF300DAE;
        Wed, 12 Aug 2020 12:35:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 787BB2B412CB6; Wed, 12 Aug 2020 12:35:30 +0200 (CEST)
Date:   Wed, 12 Aug 2020 12:35:30 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200812103530.GL2674@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200807111126.GI2674@hirez.programming.kicks-ass.net>
 <1597220073.mbvcty6ghk.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597220073.mbvcty6ghk.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 12, 2020 at 06:18:28PM +1000, Nicholas Piggin wrote:
> Excerpts from peterz@infradead.org's message of August 7, 2020 9:11 pm:
> > 
> > What's wrong with something like this?
> > 
> > AFAICT there's no reason to actually try and add IRQ tracing here, it's
> > just a hand full of instructions at the most.
> 
> Because we may want to use that in other places as well, so it would
> be nice to have tracing.
> 
> Hmm... also, I thought NMI context was free to call local_irq_save/restore
> anyway so the bug would still be there in those cases?

NMI code has in_nmi() true, in which case the IRQ tracing is disabled
(except for x86 which has CONFIG_TRACE_IRQFLAGS_NMI).
