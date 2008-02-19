Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 206-248-169-182.dsl.ncf.ca ([206.248.169.182]:22655 "EHLO
	phobos.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbYBSGWE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Feb 2008 01:22:04 -0500
Date: Tue, 19 Feb 2008 01:11:50 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [patch 0/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080219061150.GA10115@phobos.i.cabal.ca>
References: <20080219043952.845136014@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080219043952.845136014@ldl.fc.hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>

On Mon, Feb 18, 2008 at 09:39:52PM -0700, Bjorn Helgaas wrote:
>     - PA-RISC always turns on SERR and PARITY, which no other arch does
> 

I suspect this is because we set the host bus adapters to hard fail
(HPMC) on detecting an error, since we don't want to
	1) return possibly bogus (-1) data
	2) write code to use the (undocumented) error detection

More to the point, I suspect it's extra paranoia because firmware has
set it up this way. I put in a quick hack to test whether those bits
were set, and they came enabled that way by firmware on all the boxes I
tested. (Disclaimer, I didn't have any easily accessible boxes with
add-on cards installed, so firmware might just set it up for core
devices, and we're making sure its set everywhere.)

cheers, Kyle
