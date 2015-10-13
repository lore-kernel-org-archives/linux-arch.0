From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v7,51/60] PCI: Unify skip_ioresource_align()
Date: Tue, 13 Oct 2015 20:45:45 +1100 (AEDT)
Message-ID: <20151013094545.BD37A14029E@ozlabs.org>
References: <1444340359-8011-52-git-send-email-yinghai@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:52494 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbbJMJpr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Oct 2015 05:45:47 -0400
In-Reply-To: <1444340359-8011-52-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>, Yijing Wang <wangyijing@huawei.com>, Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Yinghai Lu <yinghai@kernel.org>

On Thu, 2015-08-10 at 21:39:10 UTC, Yinghai Lu wrote:
> There are powerpc generic version and x86 local version for
> skip_ioresource_align().
> 
> Move the powerpc version to setup-bus.c, and kill x86 local version.
> 
> Also kill dummy version in microblaze.
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 7587b2a..8853667 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1052,15 +1052,6 @@ void pci_fixup_cardbus(struct pci_bus *bus)
>  	pcibios_setup_bus_devices(bus);
>  }
>  
> -
> -static int skip_isa_ioresource_align(struct pci_dev *dev)
> -{
> -	if (pci_has_flag(PCI_CAN_SKIP_ISA_ALIGN) &&
> -	    !(dev->bus->bridge_ctl & PCI_BRIDGE_CTL_ISA))
> -		return 1;
> -	return 0;
> -}
> -
>  /*
>   * We need to avoid collisions with `mirrored' VGA ports
>   * and other strange ISA hardware, so we always want the
> @@ -1081,7 +1072,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO) {
> -		if (skip_isa_ioresource_align(dev))
> +		if (skip_isa_ioresource_align(dev->bus))
>  			return start;
>  		if (start & 0x300)
>  			start = (start + 0x3ff) & ~0x3ff;

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
