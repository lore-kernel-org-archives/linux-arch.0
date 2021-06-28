Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D167C2B9F4
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 06:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A4961466
	for <linux-arch@archiver.kernel.org>; Mon, 28 Jun 2021 06:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhF1GNv (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 28 Jun 2021 02:13:51 -0400
Received: from verein.lst.de ([213.95.11.211]:35171 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhF1GNv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 02:13:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B459367373; Mon, 28 Jun 2021 08:11:23 +0200 (CEST)
Date:   Mon, 28 Jun 2021 08:11:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 9/9] dma-debug: Use memory_intersects() directly
Message-ID: <20210628061123.GA23316@lst.de>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com> <20210626073439.150586-10-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626073439.150586-10-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

You've sent me a patch 9 out of 9 without the previous 8 patches.  There
is no way I can sensibly review this series.
