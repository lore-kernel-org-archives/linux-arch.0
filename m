Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-29.bluehost.com ([69.89.17.211]:57958 "HELO
	outbound-mail-29.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759942AbYCCSpv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Mar 2008 13:45:51 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 6/6] PCI: consolidate several pcibios_enable_resources() implementations
Date: Mon, 3 Mar 2008 10:45:06 -0800
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.404893334@ldl.fc.hp.com>
In-Reply-To: <20080228001053.404893334@ldl.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200803031045.07054.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
Message-ID: <20080303184506.WMUpPcT2OILrl6BZ4APYyxZJLNPn4eTjYXzuZXiYTc4@z>

On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> There are many implementations of pcibios_enable_resources() that differ
> in minor ways that look more like bugs than architectural differences.
>
> This patch consolidates most of them to use the version annotated below.
> This is the original x86 version, except that it uses the resource
> collision check from powerpc at (5):

Looks really good to me, definitely a step in the right direction.

> The mips/pmc-sierra implementation of pcibios_enable_resources() is
> cluttered with a bunch of titan stuff, so I can't immediately consolidate
> it with the others.  So I made the generic version "weak" so pmc-sierra
> can override it.
>
> Not-Yet-Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

So you'd like to see the MIPS stuff cleaned up a bit more first before actual 
sign-off?  Or just more testing?

>  18 files changed, 43 insertions(+), 507 deletions(-)

Nice diffstat. :)

Jesse
