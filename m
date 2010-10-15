Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:62955 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546Ab0JOUPk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2010 16:15:40 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 22/22] bitops: remove minix bitops from asm/bitops.h
Date: Fri, 15 Oct 2010 22:15:20 +0200
References: <1287135981-17604-1-git-send-email-akinobu.mita@gmail.com> <201010151253.15653.arnd@arndb.de> <AANLkTimK__Z_KrZ+fEUQuu51cdrYviTAmXSfQ0jD_EvP@mail.gmail.com>
In-Reply-To: <AANLkTimK__Z_KrZ+fEUQuu51cdrYviTAmXSfQ0jD_EvP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <201010152215.20400.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20101015201520.N0UScDdce1DhSMI-a5334OWnKvRU4Lxm0iR2eAQ_t94@z>

On Friday 15 October 2010 20:53:16 Mike Frysinger wrote:
> > You have defined these as "native endian":
> >
> > always LE:
> >        alpha, blackfin, ia64, score, tile, x86
> >
> > always BE:
> >        h8300, microblaze, s390, sparc
> >
> > configurable:
> >        m32r, mips, sh, xtensa
> >
> > The only ones among these that possibly ever cared about mounting minix
> > file systems on a big-endian kernel are really old sparc and mips systems,
> > everyone else probably never noticed their mistake.
> >
> > I'd say let's define the minix bitops as always LE and be done with it.
> 
> or at least make it so that this is the default, and you only have to
> update Kconfig if you need to deviate from the default.  i dont like
> having to add this minix option to every single arch Kconfig.

Yes, that would also work if we find a compelling reason to keep it that
way. You can actually keep it private to fs/minix/Kconfig by writing it
as

config MINIX_FS_NATIVE_ENDIAN
	def_bool y
	depends on H8300 || M32R || MICROBLAZE || MIPS || S390 || SUPERH || SPARC || XTENSA

We normally use select for arch specific options, but in this case I think
I would prefer the single option since we know we don't want new architectures
to do it too.

	Arnd
