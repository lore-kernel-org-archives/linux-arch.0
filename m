Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:33672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbYCEPFf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 Mar 2008 10:05:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080304185820.723623873@ldl.fc.hp.com>
References: <20080304185820.723623873@ldl.fc.hp.com> <20080304185646.864917286@ldl.fc.hp.com>
Subject: Re: [patch 05/16] frv: use generic pci_enable_resources()
Date: Wed, 05 Mar 2008 14:52:46 +0000
Message-ID: <20881.1204728766@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dhowells@redhat.com, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Message-ID: <20080305145246._gHHNe94YrPSQDIWR1WPXN7zp5PCVNPIvG1uX8r9WXI@z>


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
