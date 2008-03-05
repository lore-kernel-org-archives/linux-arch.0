Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:55413 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbYCEPRa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 Mar 2008 10:17:30 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080304185821.354198782@ldl.fc.hp.com>
References: <20080304185821.354198782@ldl.fc.hp.com> <20080304185646.864917286@ldl.fc.hp.com>
Subject: Re: [patch 08/16] mn10300: use generic pci_enable_resources()
Date: Wed, 05 Mar 2008 15:13:10 +0000
Message-ID: <28205.1204729990@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dhowells@redhat.com, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Message-ID: <20080305151310.vKOSwT9gYqP4aJJ8uOzecdX8K0vMifMqVLNFSNsvK8I@z>


Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Use the generic pci_enable_resources() instead of the arch-specific code.
> 
> Unlike this arch-specific code, the generic version:
>     - checks PCI_NUM_RESOURCES (11), not 6, resources
>     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
>     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
>     - checks for resource collisions with "!r->parent"
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: David Howells <dhowells@redhat.com>
