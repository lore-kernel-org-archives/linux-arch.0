Return-Path: <SRS0=b863=CF=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133FFC433DF
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89A9207DF
	for <linux-arch@archiver.kernel.org>; Thu, 27 Aug 2020 16:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z7SqmyJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0QiQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0QiP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 12:38:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F7FC061264;
        Thu, 27 Aug 2020 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mDFQ2s0k9HxGt4psywikvnGRm5yDAwltz2heB0RkVKI=; b=Z7SqmyJpqfjBsisDmF/TVZ0Ht1
        PjQ1Xp2mYa3WVDqVDdbWYK9Q/RuPJcdtHCS51QFY9DDNFjW5PeDsfcK/VNWLTBJaRW00YegfpXDzO
        ZiKkXdCZLM5IGJvs1z6HGrHNSfU4Ao6otK9UMbeukrfLcisI4hwSStaTYPHk/sJgXpHu7WHuNFnzw
        Lsk2Ln0mT6wZxRYIpm4E1UyHEvHxRym96GMP9JpYJeaefjBoCxPFI+HJPcZWTb+Lw5TCjlZpk86Hw
        rwa+X4aZpSAHHNUAMNU59Qs2CBfZmPG26JWVPaSL4dIgS9tO1mdjM7NApAgKnlMpEVUgufbuHhkSz
        hS1N3Psw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKuS-0002nE-BW; Thu, 27 Aug 2020 16:37:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FF8B3006D0;
        Thu, 27 Aug 2020 18:37:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 435622C42E940; Thu, 27 Aug 2020 18:37:55 +0200 (CEST)
Date:   Thu, 27 Aug 2020 18:37:55 +0200
From:   peterz@infradead.org
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org
Cc:     Eddy_Wu@trendmicro.com, x86@kernel.org, davem@davemloft.net,
        rostedt@goodmis.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, linux-arch@vger.kernel.org,
        cameron@moodycamel.com, oleg@redhat.com, will@kernel.org,
        paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] freelist: Lock less freelist
Message-ID: <20200827163755.GK1362448@hirez.programming.kicks-ass.net>
References: <20200827161237.889877377@infradead.org>
 <20200827161754.535381269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827161754.535381269@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 27, 2020 at 06:12:43PM +0200, Peter Zijlstra wrote:
> +struct freelist_node {
> +	atomic_t		refs;
> +	struct freelist_node	*next;
> +};

Bah, the next patch relies on this structure to be ordered the other
way around.

Clearly writing code and listening to talks isn't ideal :-)
