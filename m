Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52428 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbYBSGb4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Feb 2008 01:31:56 -0500
Subject: Re: [patch 4/4] RFC: PCI: consolidate several
	pcibios_enable_resources() implementations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20080219044307.878416912@ldl.fc.hp.com>
References: <20080219043952.845136014@ldl.fc.hp.com>
	 <20080219044307.878416912@ldl.fc.hp.com>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 17:31:07 +1100
Message-Id: <1203402667.6740.94.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>


On Mon, 2008-02-18 at 21:39 -0700, Bjorn Helgaas wrote:
>     powerpc: has a different collision check at (5)

I've always found the collision check dodgy. I tend to want to keep
the way powerpc does it here.

pci_enable_device() should only enable resources that have successfully
been added to the resource tree (that have passed all the collision
check etc...). There is a simple & clear indication of that: res->parent
is non-NULL. I think that is a better check than the test x86 does on
start and end.

That is, whatever the arch code decides to use to decide whether
resources are assigned by firmware or by the first pass assignment code
or not and collide or not, once that phase is finished (which is the
case when calling pcibios_enable_device(), having the resource in the
resource-tree or not is, I believe, the proper way to test whether it's
a useable resource.

Ben.


