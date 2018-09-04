Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42389 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbeIEBe2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Sep 2018 21:34:28 -0400
Date: Tue, 4 Sep 2018 23:11:07 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/4] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Message-ID: <20180904211107.GA8202@lst.de>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com> <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6d35d6-ee1e-abde-5e5c-a4c489d1abb7@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Message-ID: <20180904211107.7gHJ-UoEvD3Tm1CvHq0Ma1eBHtbWoPQ-WmxsXGPy0Bc@z>

On Tue, Sep 04, 2018 at 01:14:49PM -0700, Vineet Gupta wrote:
> Apologies for the delay in getting to this - series applied and pushed to for-curr

This is going to create really annoying merge conflicts with
work pending for the dma-mapping tree.  That's why I requested earlier
to merge it either via the dma-mapping tree or some shared branch.
