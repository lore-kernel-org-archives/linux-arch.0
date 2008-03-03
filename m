Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-104.bluehost.com ([69.89.22.14]:37781 "HELO
	outbound-mail-104.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751914AbYCCSHW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2008 13:07:22 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 4/6] ARM: move bridge enable out of pcibios_enable_resources()
Date: Mon, 3 Mar 2008 09:59:35 -0800
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.013269726@ldl.fc.hp.com>
In-Reply-To: <20080228001053.013269726@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200803030959.35625.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
Message-ID: <20080303175935.zMS4x3dLExkwGme_4B1Yu-xBGnyUGnyxYmL8oLEwDQg@z>

On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> Move bridge enable from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.

I really like the direction of these patches.  Getting PCI resources assigned 
& devices setup correctly for new arches has always been a bit more trouble 
than it should be...

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

Probably worth giving this printk a prefix at some point (doesn't matter for 
this patchset though since you're just moving it around).

Rest of it looks good.

Jesse
