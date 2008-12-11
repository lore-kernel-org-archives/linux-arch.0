From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Thu, 11 Dec 2008 15:00:24 +0000
Message-ID: <23213.1229007624@redhat.com>
References: <20081209231202.18153.60227.stgit@bob.kio> <20081209231037.18153.86962.stgit@bob.kio>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:46014 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159AbYLKPCN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Dec 2008 10:02:13 -0500
In-Reply-To: <20081209231202.18153.60227.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dhowells@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

>  
> +u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
> +{
> +	/* This implements Table 9-1 of the PCI-to-PCI bridge spec */
> +	return (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
> +}
> +

Can you please add a banner comment to this function that gives at least a
quick description of what this function is meant to do?  Feel free to use
kerneldoc.

Saying table X of document Y isn't immediately helpful.

David
