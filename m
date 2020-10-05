Return-Path: <SRS0=Z/aR=DM=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106F2C46466
	for <linux-arch@archiver.kernel.org>; Mon,  5 Oct 2020 17:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA64207BC
	for <linux-arch@archiver.kernel.org>; Mon,  5 Oct 2020 17:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgJERFt (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 5 Oct 2020 13:05:49 -0400
Received: from verein.lst.de ([213.95.11.211]:59817 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgJERFs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 5 Oct 2020 13:05:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 64AA267373; Mon,  5 Oct 2020 19:05:46 +0200 (CEST)
Date:   Mon, 5 Oct 2020 19:05:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-arch@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: clean up the DMA mapping headers
Message-ID: <20201005170546.GA18543@lst.de>
References: <20200930085548.920261-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930085548.920261-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I've pulled this into the dma-mapping for-next tree now.
