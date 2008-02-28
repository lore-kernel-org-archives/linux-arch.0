Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:29519 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYB1RiR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Feb 2008 12:38:17 -0500
Date: Thu, 28 Feb 2008 12:38:16 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 5/6] PARISC: move PERR & SERR enables out of
	pcibios_enable_resources()
Message-ID: <20080228173816.GA32265@phobos.i.cabal.ca>
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.209248743@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080228001053.209248743@ldl.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Wed, Feb 27, 2008 at 05:04:42PM -0700, Bjorn Helgaas wrote:
> Move PERR and SERR enables from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.
> 

I don't have any problems with this, but I think the naming needs to
change. pcibios_* namespace should probably remain arch dependent.
Renaming the unified implementation to pci_enable_resources, and adding
a weak function pcibios_enable_resources that can be overridden by
parisc and arm to enable PERR/SERR after calling the generic
pci_enable_resources function. No?

regards, Kyle
