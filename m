From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Make most arch asm/module.h files use
 asm-generic/module.h
Date: Wed, 18 Jul 2012 16:21:19 +0200
Message-ID: <20120718142119.GA26087@linux-mips.org>
References: <32350.1342615619@warthog.procyon.org.uk>
 <201207181320.35807.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:38706 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2GROVb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jul 2012 10:21:31 -0400
Received: from localhost.localdomain ([127.0.0.1]:35801 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903559Ab2GROV3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jul 2012 16:21:29 +0200
Content-Disposition: inline
In-Reply-To: <201207181320.35807.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org

On Wed, Jul 18, 2012 at 01:20:35PM +0000, Arnd Bergmann wrote:

> >      (*) MODULES_USE_RELA_ONLY
> >     
> >          Arches define this if their modules will only contain RELA records (and
> >          not REL records).  This causes the Elf_Rel mapping not to be emitted.
> >     
> >      (*) MODULES_USE_REL_ONLY
> >     
> >          Arches define this if their modules will only contain REL records (and
> >          not RELA records).  This causes the Elf_Rela mapping not to be emitted.
> 
> I believe all architectures have either one or the other, but never both
> or neither of the two, right? If so, we only need one symbol here.

How sweet life would be without the SGI designed ELF NABI.  For the
purposes of kernel modules that means 64-bit MIPS kernels.  The 64-bit
ELF spec [1] allows both REL and RELA.  I believe that GNU tools only
emit rela relocations and in the hope that things are going to stay
like this I'd like 64-bit MIPS to be treated as RELA-only.  However we're
in the hand of the tools guy here - they always could make use of the
rope provided.

32-bit MIPS uses REL only.

  Ralf

[1] https://www.linux-mips.org/pub/linux/mips/doc/ABI/elf64-2.4.pdf
