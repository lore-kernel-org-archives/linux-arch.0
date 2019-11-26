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
Message-ID: <b668bc25-9268-d25e-f9a0-176bb4ce1d07@xenosoft.de>
Date: Tue, 26 Nov 2019 12:57:02 +0100
MIME-Version: 1.0
In-Reply-To: <20191125093159.GA23118@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
To: Mike Rapoport <rppt@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org, darren@stevens-zone.net, mad skateman <madskateman@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191126115702.Ma7Xnjlh3vuuLPqNAbiQKQmkztEG7Y_rWIVrUeaXXGc@z>

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
Hello Mike,

My PCI TV card works also with your patch! Before I had to add "#include 
<asm/dma.h>" to the file "arch/powerpc/platforms/85xx/corenet_generic.c" 
because of the following error:

------

   CC      arch/powerpc/platforms/85xx/corenet_generic.o
   CC      ipc/util.o
   CC      ipc/msgutil.o
arch/powerpc/platforms/85xx/corenet_generic.c: In function 
‘corenet_gen_setup_arch’:
arch/powerpc/platforms/85xx/corenet_generic.c:77:2: error: 
‘ppc_dma_phys_limit’ undeclared (first use in this function); did you 
mean ‘cpu_to_phys_id’?
   ppc_dma_phys_limit = 0x0fffffffUL;
   ^~~~~~~~~~~~~~~~~~
   cpu_to_phys_id
arch/powerpc/platforms/85xx/corenet_generic.c:77:2: note: each 
undeclared identifier is reported only once for each function it appears in
scripts/Makefile.build:265: recipe for target 
'arch/powerpc/platforms/85xx/corenet_generic.o' failed
make[3]: *** [arch/powerpc/platforms/85xx/corenet_generic.o] Error 1
scripts/Makefile.build:509: recipe for target 
'arch/powerpc/platforms/85xx' failed
make[2]: *** [arch/powerpc/platforms/85xx] Error 2
scripts/Makefile.build:509: recipe for target 'arch/powerpc/platforms' 
failed
make[1]: *** [arch/powerpc/platforms] Error 2
Makefile:1652: recipe for target 'arch/powerpc' failed
make: *** [arch/powerpc] Error 2

------

After that I was able to compile the latest Git kernel with your patch.

Thanks,
Christian
