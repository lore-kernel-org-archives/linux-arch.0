Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:58019 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752436AbYBTGZN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Feb 2008 01:25:13 -0500
Date: Tue, 19 Feb 2008 23:24:55 -0700
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [patch 0/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
Message-ID: <20080220062455.GB6315@colo.lackof.org>
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
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
> This patch series consolidates most of them to use the x86 version.
> 
> This series is for discussion only at this point.  I'm interested in
> feedback about whether any of the differences are "real" and need to
> be preserved.
> 
> ARM and PA-RISC, in particular, have interesting differences:
>     - ARM always enables bridge devices, which no other arch does
>     - PA-RISC always turns on SERR and PARITY, which no other arch does
> 
> Should other arches do the same thing, or are these somehow related to
> ARM and PA-RISC architecture?

My impression was most x86 BIOS's did NOT turn on SERR/PERR when I added
that code to parisc-linux port (2000 or 2001 so) . HPUX was turning on
SERR/PERR and so I was comfortable the HW was stable and it not crash
under normal use unless something was really broken.

There is certainly nothing architectural specific about SERR/PERR.
I felt (at the time) this is more of a case of "if it's not reported to the
user, we won't get blamed for it not working well."

hth,
grant
