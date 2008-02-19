Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50442 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbYBSUXU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Feb 2008 15:23:20 -0500
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <200802190911.56901.bjorn.helgaas@hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	 <20080219044307.878416912@ldl.fc.hp.com> <1203402667.6740.94.camel@pasglop>
	 <200802190911.56901.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Wed, 20 Feb 2008 07:21:43 +1100
Message-Id: <1203452503.18618.8.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>


> > That is, whatever the arch code decides to use to decide whether
> > resources are assigned by firmware or by the first pass assignment code
> > or not and collide or not, once that phase is finished (which is the
> > case when calling pcibios_enable_device(), having the resource in the
> > resource-tree or not is, I believe, the proper way to test whether it's
> > a useable resource.
> 
> So should x86 adopt that collision check?  I don't hear anything about
> actual architecture differences that are behind this implementation
> difference.

Well, on powerpc we do allow under some circumstances a 0 start value
in BARs, which is why I wanted to use a different check.

Ben.


