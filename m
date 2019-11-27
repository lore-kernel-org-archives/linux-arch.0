From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
Date: Wed, 27 Nov 2019 16:14:43 +0100
Message-ID: <6a4289cf-d2b5-2357-f1ad-eeab44ab3b1e@xenosoft.de>
References: <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
 <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
 <20191126164026.GA8026@lst.de> <20191127065624.GB16913@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191127065624.GB16913@linux.ibm.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org, darren@stevens-zone.net, mad skateman <madskateman@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-Id: linux-arch.vger.kernel.org

On 27 November 2019 at 07:56 am, Mike Rapoport wrote:
>
> Maybe we'll simply force bottom up allocation before calling
> swiotlb_init()? Anyway, it's the last memblock allocation.
>
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 62f74b1b33bd..771e6cf7e2b9 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -286,14 +286,15 @@ void __init mem_init(void)
>   	/*
>   	 * book3s is limited to 16 page sizes due to encoding this in
>   	 * a 4-bit field for slices.
>   	 */
>   	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
>   
>   #ifdef CONFIG_SWIOTLB
> +	memblock_set_bottom_up(true);
>   	swiotlb_init(0);
>   #endif
>   
>   	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
>   	set_max_mapnr(max_pfn);
>   	memblock_free_all();
>   
>   
Hello Mike,

I tested the latest Git kernel with your new patch today. My PCI TV card 
works without any problems.

Thanks,
Christian
