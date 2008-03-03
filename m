From: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [patch 0/6] RFC: PCI: consolidate pcibios_enable_resources() implementations, v2
Date: Mon, 3 Mar 2008 19:44:09 +0000
Message-ID: <20080303194408.GC20251@flint.arm.linux.org.uk>
References: <20080228000437.880811124@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080228000437.880811124-e+Ta4ugHZmL3oGB3hsPCZA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Kyle McMartin <kyle-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>

On Wed, Feb 27, 2008 at 05:04:37PM -0700, Bjorn Helgaas wrote:
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
> This patch series consolidates most of them to use the x86 version.
> 
> Changes between v1 and v2:
> 
>   - Moved ARM bridge enable to new platform_pci_enable_device(),
>     called by pcibios_enable_device()

Looks fine.  However, long term I've no idea what to do about this because
I don't remember the reasoning behind it.  So to change it risks breakage
of one sort or another.

It might have been something to do with the Mobility Cardbus docking
station, which adds a pair of P2P bridges onto the PCI chain downstream
of the Cardbus controller, and then a full PCI bus containing USB, VGA,
and other peripherals.

This _once_ used to work with Linux but I suspect as a result of "fixing"
other issues its now utterly broken.

In any case, that docking station isn't ARM specific in any way; merely
a toy Alan Cox sent me.  When I gave up my PCMCIA maintainership, I gave
up trying to keep it supported by Linux.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
