From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] arch: switch the default on ARCH_HAS_SG_CHAIN
Date: Mon, 19 Nov 2018 14:58:52 +0100
Message-ID: <20181119135852.GA16428@lst.de>
References: <20181109090008.24150-3-hch@lst.de> <mhng-9c1955e1-d7cf-4ee4-8bf8-6bef720c9b98@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <mhng-9c1955e1-d7cf-4ee4-8bf8-6bef720c9b98@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 16, 2018 at 08:52:14AM -0800, Palmer Dabbelt wrote:
> As far as I can tell, it looks like m68k, mips, and powerpc mention an 
> IOMMU in their ports, don't set ARCH_HAS_SG_CHAIN, and with this patch set 
> won't set ARCH_NO_SG_CHAIN.

m68k has no iommu, and not operations that operate on a scatterlist.

mips has a trivial iommu driver (jazzdma), but I wrote the current
instance of it, nad it is fine.

powerpc has various iommu, but actually enables ARCH_HAS_SG_CHAIN
unconditionally.

> The issue is that I'm not sure how to 
> determine what constitutes a horrible legacy IOMMU, at least with respect 
> to not being able to use scatterlist chaining.

It basically means someone is iterating using manual pointer arithmetics
over a multi-element scatterlist instead of using the sg_next and
for_each_sg helpers.
