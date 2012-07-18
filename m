From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h
Date: Wed, 18 Jul 2012 14:33:12 +0100
Message-ID: <2722.1342618392@warthog.procyon.org.uk>
References: <201207181320.35807.arnd@arndb.de> <32350.1342615619@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867Ab2GRNd1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jul 2012 09:33:27 -0400
In-Reply-To: <201207181320.35807.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: dhowells@redhat.com, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

Arnd Bergmann <arnd@arndb.de> wrote:

> The method I try to use for architectures overriding asm-generic definitions
> is to make the architecture define the same symbol, like
> 
> #ifdef CONFIG_ARM_UNWIND
> struct mod_arch_specific {
> 	struct unwind_table *unwind[ARM_SEC_MAX];
> };
> #define mod_arch_specific mod_arch_specific
> #endif
> 
> and then let the asm-generic version test that using
> 
> #ifndef mod_arch_specific
> struct mod_arch_specific {};
> #endif

Ewww.  That's even ickier.

> I believe all architectures have either one or the other, but never both or
> neither of the two, right? If so, we only need one symbol here.

That's probably the case, but I don't know which it is for which arch, or
whether it has changed during the lifetime of an arch, requiring both to be
supported for that arch.

> some time back to provide a default so architectures no longer need
> to provide the apply_relocate function for both cases. If we have the
> Kconfig symbol you introduce, we can turn this into an nice inline
> function and do
> 
> #ifdef CONFIG_MODULES_USE_RELA_ONLY
> static inline int __weak apply_relocate(Elf_Shdr *sechdrs,

You don't then need the __weak attributes.

> and consequently kill off the remaining empty functions.

:-)

David
