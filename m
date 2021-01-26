Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C3C433E9
	for <linux-arch@archiver.kernel.org>; Tue, 26 Jan 2021 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF9B2083E
	for <linux-arch@archiver.kernel.org>; Tue, 26 Jan 2021 17:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbhAZRU4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388118AbhAZGnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 01:43:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6875DC061573;
        Mon, 25 Jan 2021 22:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=XFJjQnlOmKPrpamUOymOwxeLZG
        nTEr98Y7kNW8QS5NHaW0kkQddRAz7PSPmxL1BCFZYqcJNmVKoJ8teXKWfyx4f40ItG0mruV2CyAGH
        BOWfEHlkBnTxTy2pdd/F79fQFpq92dPzOFmamckYfdzBf7viCXEBvVan0E7NvO4el4jaibngUVac5
        UdbkRLkdIdTutyOG5Dv+VM7xpSDv5u8qqGHfK09SHX7Ir38+s1trQuozDDKgoerCBfxnt08NiWL2o
        KdjcWatSfxwUNXhgtC3+Odn06CKkk1MDqSlnk+oiPoDbqxT0B1eOouyPg+lMvwrlWE/f3P1T+gmZ8
        cPzaRC5w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4I1j-005CI6-0T; Tue, 26 Jan 2021 06:40:59 +0000
Date:   Tue, 26 Jan 2021 06:40:35 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH v11 04/13] mm/ioremap: rename ioremap_*_range to
 vmap_*_range
Message-ID: <20210126064035.GA1236944@infradead.org>
References: <20210126044510.2491820-1-npiggin@gmail.com>
 <20210126044510.2491820-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126044510.2491820-5-npiggin@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
