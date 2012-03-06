From: Krishna Reddy <vdumpa@nvidia.com>
Subject: RE: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
Date: Tue, 6 Mar 2012 15:36:32 -0800
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E3797011437@HQMAIL04.nvidia.com>
References: <1330527862-16234-1-git-send-email-m.szyprowski@samsung.com>
 <1330527862-16234-10-git-send-email-m.szyprowski@samsung.com>
 <20120306232138.GF15201@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120306232138.GF15201@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Shariq Hasnain <shariq.hasnain@linaro.org>, Chunsang Jeong <chunsang.jeong@linaro.org>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-arch.vger.kernel.org

> On Wed, Feb 29, 2012 at 04:04:22PM +0100, Marek Szyprowski wrote:
> > +static int arm_iommu_mmap_attrs(struct device *dev, struct
> vm_area_struct *vma,
> > +		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
> > +		    struct dma_attrs *attrs)
> > +{
> > +	struct arm_vmregion *c;
> > +
> > +	vma->vm_page_prot = __get_dma_pgprot(attrs, vma-
> >vm_page_prot);
> > +	c = arm_vmregion_find(&consistent_head, (unsigned
> long)cpu_addr);
> 
> What protects this against other insertions/removals from the list?

arm_vmregion_find uses a spin_lock internally before accessing consistent_head.
 So, it is protected.


-KR

--nvpublic
