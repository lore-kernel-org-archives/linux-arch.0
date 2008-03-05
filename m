From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [patch 08/16] mn10300: use generic pci_enable_resources()
Date: Wed, 5 Mar 2008 12:15:06 -0800
Message-ID: <20080305201506.GF13569@kroah.com>
References: <20080304185821.354198782@ldl.fc.hp.com> <20080304185646.864917286@ldl.fc.hp.com> <28205.1204729990@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <28205.1204729990-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Kyle McMartin <kyle-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Mar 05, 2008 at 03:13:10PM +0000, David Howells wrote:
> 
> Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org> wrote:
> 
> > Use the generic pci_enable_resources() instead of the arch-specific code.
> > 
> > Unlike this arch-specific code, the generic version:
> >     - checks PCI_NUM_RESOURCES (11), not 6, resources
> >     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
> >     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
> >     - checks for resource collisions with "!r->parent"
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 
> Acked-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

added, thanks.

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
