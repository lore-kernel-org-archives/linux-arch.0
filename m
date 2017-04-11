From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 21/32] powerpc: include default ioremap_nopost()
 implementation
Date: Tue, 11 Apr 2017 15:24:56 +0100
Message-ID: <20170411142456.GB6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
 <1491917928.7236.8.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491917928.7236.8.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 11, 2017 at 11:38:48PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:29 +0100, Lorenzo Pieralisi wrote:
> > The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
> > mandate non-posted configuration transactions. As further highlighted in
> > the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
> > Enhanced Configuration Access Mechanism"), through ECAM and
> > ECAM-derivative configuration mechanism, the memory mapped transactions
> > from the host CPU into Configuration Requests on the PCI express fabric
> > may create ordering problems for software because writes to memory
> > address are typically posted transactions (unless the architecture can
> > enforce through virtual address mapping non-posted write transactions
> > behaviour) but writes to Configuration Space are not posted on the PCI
> > express fabric.
> > 
> > Include the asm-generic ioremap_nopost() implementation (currently
> > falling back to ioremap_nocache()) to provide a non-posted writes
> > ioremap interface to kernel subsystems.
> 
> NAK. As explained in my reply to patch 0.

Ok, point taken. BTW, may I ask you guys to have a look into this
please ?

https://lkml.org/lkml/2017/4/6/743

It is a side effect of this thread (v2), not sure why <asm/io.h>
on powerpc has to include <linux/io.h>.

Thanks,
Lorenzo

> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > ---
> >  arch/powerpc/include/asm/io.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> > index 5ed2924..6dcd0e2 100644
> > --- a/arch/powerpc/include/asm/io.h
> > +++ b/arch/powerpc/include/asm/io.h
> > @@ -757,6 +757,7 @@ extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
> >  extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
> > >  #define ioremap_nocache(addr, size)	ioremap((addr), (size))
> > >  #define ioremap_uc(addr, size)		ioremap((addr), (size))
> > +#include <asm-generic/ioremap-nopost.h>
> >  
> >  extern void iounmap(volatile void __iomem *addr);
> >  
