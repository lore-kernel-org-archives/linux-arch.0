Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52456 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbYBSGei (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Feb 2008 01:34:38 -0500
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20080219044307.878416912@ldl.fc.hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	 <20080219044307.878416912@ldl.fc.hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:33:50 +1100
Message-Id: <1203402830.6740.98.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>



> Index: work6/drivers/pci/Makefile
> ===================================================================
> --- work6.orig/drivers/pci/Makefile	2008-02-18 21:16:36.000000000 -0700
> +++ work6/drivers/pci/Makefile	2008-02-18 21:16:38.000000000 -0700
> @@ -2,7 +2,7 @@
>  # Makefile for the PCI bus specific drivers.
>  #
>  
> -obj-y		+= access.o bus.o probe.o remove.o pci.o quirks.o \
> +obj-y		+= access.o bios.o bus.o probe.o remove.o pci.o quirks.o \
>  			pci-driver.o search.o pci-sysfs.o rom.o setup-res.o
>  obj-$(CONFIG_PROC_FS) += proc.o
>  
> Index: work6/drivers/pci/bios.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ work6/drivers/pci/bios.c	2008-02-18 21:16:38.000000000 -070
                        ^^^^^^

Yuck :-)

Please, don't call this bios ... whatever is in this file really has
nothing to do with a "BIOS" in any shape or form :-) I know we used to
call those things pcibios_* but that's really historical...

If you want to make clear it's for "utilities" that can be overriden
by the arch, maybe call it utils.c, or just stick the function in
pci.c, or setup-res.c

Ben.


