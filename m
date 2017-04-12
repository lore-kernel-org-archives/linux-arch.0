From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: "Consolidate get_dma_ops" breaks Xen on ARM
Date: Wed, 12 Apr 2017 09:33:59 +0100
Message-ID: <20170412083359.GA19019@e104818-lin.cambridge.arm.com>
References: <alpine.DEB.2.10.1704101713080.2759@sstabellini-ThinkPad-X260>
 <CY1PR0401MB1536C1FF3C069BC88D1DB14581000@CY1PR0401MB1536.namprd04.prod.outlook.com>
 <a758dfc6-2b00-e279-303c-ba1e27380e35@arm.com>
 <20170411133649.GB27857@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.10.1704111411350.2759@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1704111411350.2759@sstabellini-ThinkPad-X260>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Julien Grall <julien.grall@arm.com>, Bart Van Assche <Bart.VanAssche@sandisk.com>, "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com" <jgross@suse.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 11, 2017 at 04:39:09PM -0700, Stefano Stabellini wrote:
> On Tue, 11 Apr 2017, Catalin Marinas wrote:
> > On Tue, Apr 11, 2017 at 01:43:28PM +0100, Julien Grall wrote:
> > > On 11/04/17 02:14, Bart Van Assche wrote:
> > > > On 04/10/17 17:31, Stefano Stabellini wrote:
> > > >> I think the reason is that, as you can see, if (dev && dev->dma_ops),
> > > >> dev->dma_ops is returned, while before this changes, xen_dma_ops was
> > > >> returned on Xen on ARM.
> > > >>
> > > >> Unfortunately DMA cannot work properly without using the appropriate
> > > >> xen_dma_ops. See drivers/xen/swiotlb-xen.c and arch/arm/xen/mm.c for
> > > >> more details. (The problem is easy to spot, but I wasn't CC'ed on the
> > > >> patch.)
> > > >>
> > > >> I don't know how to solve this problem without introducing some sort of
> > > >> if (xen()) in include/linux/dma-mapping.h.
> > > > 
> > > > Sorry but I don't have access to an ARM development system. Does your 
> > > > comment apply to dev == NULL only, dev != NULL only or perhaps to both? 
> > > > If your comment applies to dev != NULL only, can you check whether 
> > > > adding something like set_dma_ops(dev, get_arch_dma_ops(NULL)) to the 
> > > > appropriate ARM arch_setup_dma_ops() function is sufficient?
> > > 
> > > If I understand correctly, set_dma_ops will replace dev->dma_ops with
> > > Xen DMA ops.
[...]
> > Yet another way would be for dom0 to always set dev->dma_ops to
> > xen_dma_ops and preserve the real dma_ops somewhere under dev->archdata.
> > You could intercept the arch_setup_dma_ops() function for this or use
> > bus_register_notifier() (though I think the former is easier). The Xen
> > code making use of the real dma_ops would have to dig them out from
> > dev->archdata.
> 
> This is a good suggestion, Catalin. Thank you. See below. Is that what
> you have in mind? Julien could you test it, please? If it is the right
> approach, I'll submit the patch properly and rename __generic_dma_ops to
> xen_generic_dma_ops or something.

It looks fine to me (subject to testing successfully).

-- 
Catalin
