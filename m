Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:10953 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964818AbWAIQ1S
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jan 2006 11:27:18 -0500
Date: Mon, 9 Jan 2006 09:27:18 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: sys_pciconfig_{read,write}
Message-ID: <20060109162718.GP19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: carlos neira <cneira@srb.cl>
List-ID: <linux-arch.vger.kernel.org>


I bet most people don't even know we have these syscalls.  But they're
built into every arch except X86, and only hooked up on alpha, arm,
ia64, ppc32, sparc and sparc64.

Given the existence of sysfs and the inability of the syscalls to handle
domains, I don't see any point in hooking them up on new architectures.
I suspect they could even be deleted since any software trying them must
fall back to other methods to be portable.

The syscalls also take the BKL, as pointed out by Carlos on kernel janitors.
This is unnecessary as they're already spinlocked at a lower level.

So I propose the following three patches:

1/ New Kconfig symbol CONFIG_PCI_SYSCALLS to be defined by the above
architectures.  Makefile altered accordingly.

2/ Removal of BKL from syscall implementation.

3/ Removal of !CONFIG_PCI pciconfig stubs from alpha, ia64 and sparc64
(we already have cond_syscalls for them).

I don't quite understand why we need
compat_sys_pciconfig_{read,write,iobase} on ppc64.  Can't these just
call the normal versions?
