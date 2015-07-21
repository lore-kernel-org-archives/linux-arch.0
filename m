From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/10] arch: unify ioremap prototypes and macro aliases
Date: Tue, 21 Jul 2015 15:34:57 +0200
Message-ID: <20150721133457.GC8902@lst.de>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com> <20150720001759.30857.23753.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41986 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbbGUNfA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jul 2015 09:35:00 -0400
Content-Disposition: inline
In-Reply-To: <20150720001759.30857.23753.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, mcgrof@suse.com, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, kbuild test robot <fengguang.wu@intel.com>, hch@lst.de, linux-arm-kernel@lists.infradead.org

On Sun, Jul 19, 2015 at 08:18:00PM -0400, Dan Williams wrote:
> Some archs define the first parameter to ioremap() as unsigned long,
> while the balance define it as resource_size_t, similar confusion exists
> for the type of the 'size' parameter.  Unify on (resource_size_t,
> unsigned long) to enable passing ioremap function pointers.  Also, some
> archs use function-like macros for defining ioremap aliases, but
> asm-generic/io.h expects object-like macros, unify on the latter.
> 
> Move all handling of ioremap aliasing (i.e. ioremap_wt => ioremap) to
> include/linux/io.h.  Add a check to lib/devres.c to warn at compile time
> if an arch violates type expectations.

I don't think devres really has aything to do with this code.

> Kill ARCH_HAS_IOREMAP_WC and ARCH_HAS_IOREMAP_WT in favor of just
> testing for ioremap_wc, and ioremap_wt being defined.  This arrangement
> allows drivers to know when ioremap_<foo> are being re-directed to plain
> ioremap.  A later patch uses this arrangement to implement support for
> strict mappings.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

I only ACKed this as a band-aid to get the pmem code in.  Now that
we got that in with a less invasive hack I don't see any reasons to
do this over doing the proper common prototypes and per-arch runtime checks
of flags variant.
