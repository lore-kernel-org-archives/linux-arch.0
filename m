From: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
Subject: Re: [patch 6/6] PCI: consolidate several pcibios_enable_resources() implementations
Date: Mon, 3 Mar 2008 10:45:06 -0800
Message-ID: <200803031045.07054.jbarnes@virtuousgeek.org>
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.404893334@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080228001053.404893334-e+Ta4ugHZmL3oGB3hsPCZA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org
Cc: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Kyle McMartin <kyle-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, Grant Grundler <grundler-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>

On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
>
> This patch consolidates most of them to use the version annotated below.
> This is the original x86 version, except that it uses the resource
> collision check from powerpc at (5):

Looks really good to me, definitely a step in the right direction.

> The mips/pmc-sierra implementation of pcibios_enable_resources() is
> cluttered with a bunch of titan stuff, so I can't immediately consolidate
> it with the others.  So I made the generic version "weak" so pmc-sierra
> can override it.
>
> Not-Yet-Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>

So you'd like to see the MIPS stuff cleaned up a bit more first before actual 
sign-off?  Or just more testing?

>  18 files changed, 43 insertions(+), 507 deletions(-)

Nice diffstat. :)

Jesse
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
