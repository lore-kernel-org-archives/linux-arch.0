Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:40813 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeLHRDl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 8 Dec 2018 12:03:41 -0500
Date: Sat, 8 Dec 2018 18:03:34 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181208170334.GB15020@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20181208170334.Iu8JMuDBglbaGylCI9IopPws2D0sX6eT5N3qqS97TYI@z>

Just as a warning:  this series now has some conflicts with the dma
mapping tree due to the ->mapping_error removal, and there might be
some bigger ones if the direct calls for the direct mapping code series
goes ahead.  None of them affect the early part of the series that do
not touch the actual dma_map_ops instances, though.
