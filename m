Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57649 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbeLFO6A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Dec 2018 09:58:00 -0500
Date: Thu, 6 Dec 2018 15:57:58 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove the ->mapping_error method from dma_map_ops V3
Message-ID: <20181206145758.GA25666@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
Message-ID: <20181206145758.6lWh2zCy3WbXq41VhKVwgxBqPvkXL3XEimEVPXUPTtM@z>

I've pulled this into the dma-mapping for-next tree, with the suggestion
from Robin that improves bisectability, and two unused variables found
by the build bot.
