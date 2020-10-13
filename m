Return-Path: <SRS0=OX6G=DU=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E6C433E7
	for <linux-arch@archiver.kernel.org>; Tue, 13 Oct 2020 11:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3462020E65
	for <linux-arch@archiver.kernel.org>; Tue, 13 Oct 2020 11:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgJML3P (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 13 Oct 2020 07:29:15 -0400
Received: from verein.lst.de ([213.95.11.211]:53455 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgJML3P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 07:29:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96AB167373; Tue, 13 Oct 2020 13:29:12 +0200 (CEST)
Date:   Tue, 13 Oct 2020 13:29:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Sekhar Nori <nsekhar@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/9] dma-mapping: split <linux/dma-mapping.h>
Message-ID: <20201013112912.GA13438@lst.de>
References: <20200930085548.920261-1-hch@lst.de> <20200930085548.920261-2-hch@lst.de> <20201011143327.GA251807@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011143327.GA251807@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks for the report, I've commited the obvious fix.
