From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [patch 4/6] ARM: move bridge enable out of pcibios_enable_resources()
Date: Thu, 6 Mar 2008 08:42:49 -0700
Message-ID: <200803060842.51127.bjorn.helgaas@hp.com>
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.013269726@ldl.fc.hp.com> <20080306150640.GL3283@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080306150640.GL3283-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Kyle McMartin <kyle-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org

On Thursday 06 March 2008 08:06:40 am Russell King - ARM Linux wrote:
> On Wed, Feb 27, 2008 at 05:04:41PM -0700, Bjorn Helgaas wrote:
> > Move bridge enable from pcibios_enable_resources() to
> > platform_pci_enable_device() so the former matches other
> > architectures and can be shared.
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> > 
> > Index: work6/arch/arm/kernel/bios32.c
> > ===================================================================
> > --- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
> > +++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
> > @@ -683,15 +683,32 @@
> >  			cmd |= PCI_COMMAND_MEMORY;
> >  	}
> >  
> > +	if (cmd != old_cmd) {
> > +		printk("PCI: enabling device %s (%04x -> %04x)\n",
> > +		       pci_name(dev), old_cmd, cmd);
> 
> Should be dev_info().
> 
> Apart from that...
> 
> Acked-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

I fixed that in the v3 patch that Greg KH put in his tree.

Thanks,
  Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
