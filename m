Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8268BC433EF
	for <linux-arch@archiver.kernel.org>; Wed,  8 Jun 2022 09:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiFHJ0P (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbiFHJZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 05:25:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3AA5000
        for <linux-arch@vger.kernel.org>; Wed,  8 Jun 2022 01:49:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFB2668BEB; Wed,  8 Jun 2022 10:49:51 +0200 (CEST)
Date:   Wed, 8 Jun 2022 10:49:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, mark.rutland@arm.com,
        hch@lst.de, vgupta@kernel.org, arnd@arndb.de, bcain@quicinc.com,
        geert@linux-m68k.org, monstr@monstr.eu, dinguyen@kernel.org,
        shorne@gmail.com, mpe@ellerman.id.au, dalias@libc.org
Subject: Re: Cache maintenance for non-coherent DMA in
 arch_sync_dma_for_device()
Message-ID: <20220608084951.GB17806@lst.de>
References: <20220606152150.GA31568@willie-the-truck> <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk> <1a8cc7af-87ac-b0e7-7fb9-d11a5eebef55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8cc7af-87ac-b0e7-7fb9-d11a5eebef55@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 06, 2022 at 05:02:50PM +0100, Robin Murphy wrote:
> No, partial DMA writes can sometimes effectively be expected behaviour, see 
> the whole SWIOTLB CVE fiasco for the most recent discussion on that:

Yes, and I still have a TODO list item for interfaces that deal
with the case of a transfer smaller than the mapping sanely, but
I haven't managed to get to it yet.
