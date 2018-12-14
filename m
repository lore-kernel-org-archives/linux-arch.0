From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/34] powerpc/cell: move dma direct window setup out
 of dma_configure
Date: Fri, 14 Dec 2018 17:42:33 +0100
Message-ID: <20181214164233.GA27074@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181114082314.8965-13-hch@lst.de> <871s6r3sno.fsf@concordia.ellerman.id.au> <20181212143604.GA5137@lst.de> <87mup8uti0.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87mup8uti0.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Dec 15, 2018 at 12:29:11AM +1100, Michael Ellerman wrote:
> I think the problem is that we don't want to set iommu_bypass_supported
> unless cell_iommu_fixed_mapping_init() succeeds.
> 
> Yep. This makes it work for me on cell on top of your v5.

Thanks, this looks good.  I've folded it with the slight change of moving
the iommu_bypass_supported setup into cell_iommu_fixed_mapping_init.
