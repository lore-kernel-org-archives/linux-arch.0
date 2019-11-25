Return-Path: <chzigotzky@xenosoft.de>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de> <20191125093159.GA23118@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <1521ec47-f358-0304-da23-313e6bebb66d@xenosoft.de>
Date: Mon, 25 Nov 2019 17:38:33 +0100
MIME-Version: 1.0
In-Reply-To: <20191125093159.GA23118@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
To: Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org, darren@stevens-zone.net, mad skateman <madskateman@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191125163833.I_KAX9E8TH7zk9j7MHzWJlu-I_HMnCDp4vm048cFGsg@z>

On 25 November 2019 at 10:32 am, Mike Rapoport wrote:
> On Mon, Nov 25, 2019 at 08:39:23AM +0100, Christoph Hellwig wrote:
>> On Sat, Nov 23, 2019 at 12:42:27PM +0100, Christian Zigotzky wrote:
>>> Hello Christoph,
>>>
>>> Please find attached the dmesg of your Git kernel.
>> Thanks.  It looks like on your platform the swiotlb buffer isn't
>> actually addressable based on the bus dma mask limit, which is rather
>> interesting.  swiotlb_init uses memblock_alloc_low to allocate the
>> buffer, and I'll need some help from Mike and the powerpc maintainers
>> to figure out how that select where to allocate the buffer from, and
>> how we can move it to a lower address.  My gut feeling would be to try
>> to do what arm64 does and define a new ARCH_LOW_ADDRESS_LIMIT, preferably
>> without needing too much arch specific magic.
> Presuming the problem is relevant for all CoreNet boards something like
> this could work:
>   
> diff --git a/arch/powerpc/include/asm/dma.h b/arch/powerpc/include/asm/dma.h
> index 1b4f0254868f..7c6cfeeaff52 100644
> --- a/arch/powerpc/include/asm/dma.h
> +++ b/arch/powerpc/include/asm/dma.h
> @@ -347,5 +347,11 @@ extern int isa_dma_bridge_buggy;
>   #define isa_dma_bridge_buggy	(0)
>   #endif
>   
> +#ifdef CONFIG_CORENET_GENERIC
> +extern phys_addr_t ppc_dma_phys_limit;
> +#define ARCH_LOW_ADDRESS_LIMIT	(ppc_dma_phys_limit - 1)
> +#endif
> +
> +
>   #endif /* __KERNEL__ */
>   #endif	/* _ASM_POWERPC_DMA_H */
> diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
> index fe0606439b5a..346b436b6d3f 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -126,3 +126,7 @@ void __init mpc85xx_qe_par_io_init(void)
>   	}
>   }
>   #endif
> +
> +#ifdef CONFIG_CORENET_GENERIC
> +phys_addr_t ppc_dma_phys_limit = 0xffffffffUL;
> +#endif
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index 7ee2c6628f64..673bcbdc7c75 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -64,7 +64,7 @@ void __init corenet_gen_setup_arch(void)
>   	mpc85xx_smp_init();
>   
>   	swiotlb_detect_4g();
> -
> +	ppc_dma_phys_limit = 0x0fffffffUL;
>   	pr_info("%s board\n", ppc_md.name);
>   
>   	mpc85xx_qe_init();
>
>> As a quick hack can you try this patch on top of the tree from Friday?
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f491690d54c6..e3f95c362922 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -344,7 +344,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>>   #define MEMBLOCK_LOW_LIMIT 0
>>   
>>   #ifndef ARCH_LOW_ADDRESS_LIMIT
>> -#define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
>> +#define ARCH_LOW_ADDRESS_LIMIT  0x0fffffffUL
>>   #endif
>>   
>>   phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
Hello Mike,

Many thanks for your patch! I will test it tomorrow.

Cheers,
Christian
