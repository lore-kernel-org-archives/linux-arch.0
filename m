From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
Date: Mon, 25 Nov 2019 11:32:00 +0200
Message-ID: <20191125093159.GA23118@linux.ibm.com>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
 <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
 <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com>
 <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de>
 <20191121180226.GA3852@lst.de>
 <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de>
 <20191125073923.GA30168@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191125073923.GA30168-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org, rtd2-kGM0oXzJM5p02iOg2JU2CQ@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, mad skateman <madskateman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>, "contact-+1neenJGU+oAvxtiuMwx3w@public.gmane.org" <contact-+1neenJGU+oAvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, nsaenzjulienne-l3A5Bk7waGM@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 25, 2019 at 08:39:23AM +0100, Christoph Hellwig wrote:
> On Sat, Nov 23, 2019 at 12:42:27PM +0100, Christian Zigotzky wrote:
> > Hello Christoph,
> >
> > Please find attached the dmesg of your Git kernel.
> 
> Thanks.  It looks like on your platform the swiotlb buffer isn't
> actually addressable based on the bus dma mask limit, which is rather
> interesting.  swiotlb_init uses memblock_alloc_low to allocate the
> buffer, and I'll need some help from Mike and the powerpc maintainers
> to figure out how that select where to allocate the buffer from, and
> how we can move it to a lower address.  My gut feeling would be to try
> to do what arm64 does and define a new ARCH_LOW_ADDRESS_LIMIT, preferably
> without needing too much arch specific magic.

Presuming the problem is relevant for all CoreNet boards something like
this could work:
 
diff --git a/arch/powerpc/include/asm/dma.h b/arch/powerpc/include/asm/dma.h
index 1b4f0254868f..7c6cfeeaff52 100644
--- a/arch/powerpc/include/asm/dma.h
+++ b/arch/powerpc/include/asm/dma.h
@@ -347,5 +347,11 @@ extern int isa_dma_bridge_buggy;
 #define isa_dma_bridge_buggy	(0)
 #endif
 
+#ifdef CONFIG_CORENET_GENERIC
+extern phys_addr_t ppc_dma_phys_limit;
+#define ARCH_LOW_ADDRESS_LIMIT	(ppc_dma_phys_limit - 1)
+#endif
+
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_DMA_H */
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index fe0606439b5a..346b436b6d3f 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -126,3 +126,7 @@ void __init mpc85xx_qe_par_io_init(void)
 	}
 }
 #endif
+
+#ifdef CONFIG_CORENET_GENERIC
+phys_addr_t ppc_dma_phys_limit = 0xffffffffUL;
+#endif
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 7ee2c6628f64..673bcbdc7c75 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -64,7 +64,7 @@ void __init corenet_gen_setup_arch(void)
 	mpc85xx_smp_init();
 
 	swiotlb_detect_4g();
-
+	ppc_dma_phys_limit = 0x0fffffffUL;
 	pr_info("%s board\n", ppc_md.name);
 
 	mpc85xx_qe_init();

> As a quick hack can you try this patch on top of the tree from Friday?
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f491690d54c6..e3f95c362922 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -344,7 +344,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  #define MEMBLOCK_LOW_LIMIT 0
>  
>  #ifndef ARCH_LOW_ADDRESS_LIMIT
> -#define ARCH_LOW_ADDRESS_LIMIT  0xffffffffUL
> +#define ARCH_LOW_ADDRESS_LIMIT  0x0fffffffUL
>  #endif
>  
>  phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,

-- 
Sincerely yours,
Mike.
