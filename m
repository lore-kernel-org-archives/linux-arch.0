Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46366 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbfHZHHR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Aug 2019 03:07:17 -0400
Date: Mon, 26 Aug 2019 09:07:14 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 11/11] mm: refresh ZONE_DMA and ZONE_DMA32 comments
 in 'enum zone_type'
Message-ID: <20190826070714.GC11331@lst.de>
References: <20190820145821.27214-1-nsaenzjulienne@suse.de> <20190820145821.27214-12-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820145821.27214-12-nsaenzjulienne@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: catalin.marinas@arm.com, hch@lst.de, wahrenst@gmx.net, marc.zyngier@arm.com, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, phill@raspberryi.org, f.fainelli@gmail.com, will@kernel.org, linux-kernel@vger.kernel.org, eric@anholt.net, mbrugger@suse.com, linux-rpi-kernel@lists.infradead.org, akpm@linux-foundation.org, frowand.list@gmail.com, m.szyprowski@samsung.com
Message-ID: <20190826070714.wvBE4-xt4XMmn1u6jn1qrsiwHAnR8mis3anA-javQmg@z>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
