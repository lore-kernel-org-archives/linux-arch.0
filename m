Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43923
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750784AbWATKG1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Jan 2006 05:06:27 -0500
Date: Fri, 20 Jan 2006 02:00:32 -0800 (PST)
Message-Id: <20060120.020032.119957438.davem@davemloft.net>
Subject: Re: sys_pciconfig_{read,write}
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060109162718.GP19769@parisc-linux.org>
References: <20060109162718.GP19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: matthew@wil.cx
Cc: linux-arch@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, cneira@srb.cl
List-ID: <linux-arch.vger.kernel.org>

From: Matthew Wilcox <matthew@wil.cx>
Date: Mon, 9 Jan 2006 09:27:18 -0700

[ Going through some old emails I intended to get to before
  heading off to linux.conf.au :-) ]

> So I propose the following three patches:
> 
> 1/ New Kconfig symbol CONFIG_PCI_SYSCALLS to be defined by the above
> architectures.  Makefile altered accordingly.
> 
> 2/ Removal of BKL from syscall implementation.
> 
> 3/ Removal of !CONFIG_PCI pciconfig stubs from alpha, ia64 and sparc64
> (we already have cond_syscalls for them).

Sounds fine to me.

> I don't quite understand why we need
> compat_sys_pciconfig_{read,write,iobase} on ppc64.  Can't these just
> call the normal versions?

I don't see this in the current tree, were they removed as
a result of this observation?
