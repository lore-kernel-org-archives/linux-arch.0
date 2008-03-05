From: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Subject: Re: [patch 09/16] parisc: use generic pci_enable_resources()
Date: Wed, 5 Mar 2008 11:17:10 -0500
Message-ID: <20080305161709.GA3354@phobos.i.cabal.ca>
References: <20080304185646.864917286@ldl.fc.hp.com> <20080304185821.554040328@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080304185821.554040328-e+Ta4ugHZmL3oGB3hsPCZA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Kyle McMartin <kyle-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>

On Tue, Mar 04, 2008 at 11:56:55AM -0700, Bjorn Helgaas wrote:
> Use the generic pci_enable_resources() instead of the arch-specific code.
> 
> Unlike this arch-specific code, the generic version:
>     - checks PCI_NUM_RESOURCES (11), not DEVICE_COUNT_RESOURCE (12), resources
>     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
>     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
>     - checks for resource collisions with "!r->parent"
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> 

Acked-by: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
