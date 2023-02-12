Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31609C636D3
	for <linux-arch@archiver.kernel.org>; Sun, 12 Feb 2023 23:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBLX7f (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 12 Feb 2023 18:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLX7e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 18:59:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDDDC654
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0LoPt0nhvvdTsFpNoT8Wq47nyEhSkAz3WMtQu6kQtW0=; b=gvt73Cu0QvUxzxnFaXYgG7QhBk
        wa6erbb7dXSlqVs2qMVu/umJ+OnL0ZdywbaYNMaW0/Vy4OgIQ688SxGcs+qYf0zLnvJ4CChJO5LXA
        K0hw021mrwzRoIFa94/pZgBfpi2LBBhjVZ/AB/57DKJGtLjf4UfwwkZ4dWNNDQysMEaK/EGmD9hLm
        sbrgBM7YzVCNUJ1to7GX+7bNtMz51udYxCM6wordio3G2Nff4O+xml1Yiy4FpzOeMhIw1+CGz2fzC
        rnSZ0/O3IQCOuBstlxaPiywTVNreqIMI5ezcVbBMc0GsvBpyzNaMj2UTU9dKU30JJ9GgrsuWXzYlp
        tNIeHkFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRMFe-005HPA-Ta; Sun, 12 Feb 2023 23:59:22 +0000
Date:   Sun, 12 Feb 2023 23:59:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/7] mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
Message-ID: <Y+l9WlZ4Bzfy4O6Z@casper.infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230211033948.891959-5-willy@infradead.org>
 <Y+kK9qXSKXv+PrqA@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+kK9qXSKXv+PrqA@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 12, 2023 at 05:51:18PM +0200, Mike Rapoport wrote:
> On Sat, Feb 11, 2023 at 03:39:45AM +0000, Matthew Wilcox (Oracle) wrote:
> > Current best practice is to reuse the name of the function as a define
> > to indicate that the function is implemented by the architecture.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  include/linux/cacheflush.h | 4 ++--
> >  mm/util.c                  | 2 +-
> 
> I'd expect a change in arch/ that removes
> ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO and adds #define flush_dcache_folio
> 
> What am I missing?

That not a single architecture got round to implementing
flush_dcache_folio() yet ;-)

$ git grep ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO arch
(nothing)
