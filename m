Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:15819 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYCCTIo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2008 14:08:44 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch 6/6] PCI: consolidate several pcibios_enable_resources() implementations
Date: Mon, 3 Mar 2008 12:10:46 -0700
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.404893334@ldl.fc.hp.com> <200803031045.07054.jbarnes@virtuousgeek.org>
In-Reply-To: <200803031045.07054.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200803031210.47906.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
Message-ID: <20080303191046.PzqEOuDExkinW4-MRx17Ll6T8b1LvZzbb8YMxGPO8EE@z>

On Monday 03 March 2008 11:45:06 am Jesse Barnes wrote:
> On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> >
> > Not-Yet-Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> So you'd like to see the MIPS stuff cleaned up a bit more first before actual 
> sign-off?  Or just more testing?

I think it'd be *nice* if that MIPS stuff got cleaned up, but that's
way beyond my scope.  I just want to address Kyle's comments and make
sure I don't screw up ARM and PARISC.

Bjorn
