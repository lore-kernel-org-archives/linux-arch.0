Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from jurassic.park.msu.ru ([195.208.223.243]:44674 "EHLO
	jurassic.park.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbYBSRIM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2008 12:08:12 -0500
Date: Tue, 19 Feb 2008 20:08:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080219170814.GA8288@jurassic.park.msu.ru>
References: <20080219043952.845136014@ldl.fc.hp.com> <20080219044307.878416912@ldl.fc.hp.com> <1203402667.6740.94.camel@pasglop> <200802190911.56901.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200802190911.56901.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: benh@kernel.crashing.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Tue, Feb 19, 2008 at 09:11:55AM -0700, Bjorn Helgaas wrote:
> > That is, whatever the arch code decides to use to decide whether
> > resources are assigned by firmware or by the first pass assignment code
> > or not and collide or not, once that phase is finished (which is the
> > case when calling pcibios_enable_device(), having the resource in the
> > resource-tree or not is, I believe, the proper way to test whether it's
> > a useable resource.
> 
> So should x86 adopt that collision check?

Yes, and other arches as well, I believe.

> I don't hear anything about
> actual architecture differences that are behind this implementation
> difference.

On ppc64 "0" can be a valid value for resource start, as far as I know.

Ivan.
