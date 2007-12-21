Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from there.is.no.cabal.ca ([134.117.69.58]:55906 "EHLO
	fattire.cabal.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbXLURvI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2007 12:51:08 -0500
Date: Fri, 21 Dec 2007 12:51:06 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
Message-ID: <20071221175106.GB17656@fattire.cabal.ca>
References: <20071220115200.C767E26F98A@magilla.localdomain> <20071220115816.504CC26F98E@magilla.localdomain> <20071221071229.GC4345@infradead.org> <20071221085609.4D53B26F98A@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071221085609.4D53B26F98A@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>

On Fri, Dec 21, 2007 at 12:56:09AM -0800, Roland McGrath wrote:
> > On Thu, Dec 20, 2007 at 03:58:16AM -0800, Roland McGrath wrote:
> > > +obj-$(CONFIG_PPC64)		+= ../../../fs/compat_binfmt_elf.o
> > 
> > Building files from another directory is nasty.  Please add a
> > CONFIG_BINFMT_COMPAT_ELF so we can simply build it in fs/
> 
> If that's better, please post the precise Kconfig magic you have in mind to
> have it set when it should be.
> 

Just taking a stab that hch means,

config BINFMT_COMPAT_ELF
	def_bool n
	depends on 64BIT

and then in arch/powerpc/Kconfig

config COMPAT
	bool
	default y if PPC64
	select BINFMT_COMPAT_ELF

or somesuch.

Regards, Kyle
