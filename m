Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58221 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeAPHwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jan 2018 02:52:50 -0500
Date: Mon, 15 Jan 2018 23:52:43 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: consolidate direct dma mapping V4
Message-ID: <20180116075243.GA12693@infradead.org>
References: <20180112084232.2857-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-snps-arc@lists.infradead.org, linux-m68k@lists.linux-m68k.org, patches@groups.riscv.org, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180116075243.FLQSmuxs6q3-XBObH8qMXtXlEYICIlpdi1ADBW1BnZo@z>

I've pulled this into the dma-mapping for-next branch so that we get
a few days exposure before then end of the merge window.  If there is
anything important (e.g. the powerpc naming issue) please send
incremental patches.
