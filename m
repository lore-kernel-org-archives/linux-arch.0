Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47131 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbYCFPIQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2008 10:08:16 -0500
Date: Thu, 6 Mar 2008 15:06:40 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [patch 4/6] ARM: move bridge enable out of pcibios_enable_resources()
Message-ID: <20080306150640.GL3283@flint.arm.linux.org.uk>
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.013269726@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080228001053.013269726@ldl.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.arm.linux.org.uk
Message-ID: <20080306150640.EygLif_SqiEqBkhf4DTgGT-QN5HREv6HyP8w62Otk9E@z>

On Wed, Feb 27, 2008 at 05:04:41PM -0700, Bjorn Helgaas wrote:
> Move bridge enable from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work6/arch/arm/kernel/bios32.c
> ===================================================================
> --- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
> +++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
> @@ -683,15 +683,32 @@
>  			cmd |= PCI_COMMAND_MEMORY;
>  	}
>  
> +	if (cmd != old_cmd) {
> +		printk("PCI: enabling device %s (%04x -> %04x)\n",
> +		       pci_name(dev), old_cmd, cmd);

Should be dev_info().

Apart from that...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
