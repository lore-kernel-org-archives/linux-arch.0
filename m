Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF58C433B4
	for <linux-arch@archiver.kernel.org>; Thu, 15 Apr 2021 08:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AECF611CD
	for <linux-arch@archiver.kernel.org>; Thu, 15 Apr 2021 08:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhDOIxB (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhDOIxB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 04:53:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF35FC061574;
        Thu, 15 Apr 2021 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CBfBwbeMsKIjwkyJR8CxYymWxWHjQjc6bfUFfaI+Gs=; b=QBDzWwCqnCVNNJJRT76eqhcTut
        LJyRWhwc+cIYbhVTOqkQGWi8yzOpqbWFL7LnP+ig0xblXqVeDfiwKS8mxZHxfCuCHgDI26Q1SKUip
        SpSPh9jEZO/jl+4AmGezYhmakcrF3eLNvr5+WXdlE2auoWnTq/p57pHByXajtxuzVaZiBdXoc+5eK
        zRe4DFDcdkusDn/wXnN71n1RP6tOTnGAo5k7qDpmG5BGvh2BfCj138t/ZFnna4utbjxiGi3bp5Igs
        KginFPVdzlX0JCklTMbn4AJWL/L5N8Ff4d4IkUIJgcVFhU4lwsqIGi1A8kUFMzY1nh7RF8kAQLD0f
        9T315q8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lWxjk-00FPvr-8a; Thu, 15 Apr 2021 08:52:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6ED28300033;
        Thu, 15 Apr 2021 10:52:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 566E32022422C; Thu, 15 Apr 2021 10:52:31 +0200 (CEST)
Date:   Thu, 15 Apr 2021 10:52:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     Anup.Patel@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
Message-ID: <YHf+z0AotZmjvaJ/@hirez.programming.kicks-ass.net>
References: <1618472362-85193-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618472362-85193-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 15, 2021 at 07:39:22AM +0000, guoren@kernel.org wrote:
>  - Add atomic_andnot_* operation

> @@ -76,6 +59,12 @@ ATOMIC_OPS(sub, add, -i)
>  ATOMIC_OPS(and, and,  i)
>  ATOMIC_OPS( or,  or,  i)
>  ATOMIC_OPS(xor, xor,  i)
> +ATOMIC_OPS(andnot, and,  -i)

~i, surely.
