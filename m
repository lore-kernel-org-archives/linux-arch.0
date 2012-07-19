From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h
Date: Thu, 19 Jul 2012 12:53:51 +0100
Message-ID: <8411.1342698831@warthog.procyon.org.uk>
References: <20120719062320.GA21565@linux-sh.org> <32350.1342615619@warthog.procyon.org.uk> <2597.1342617840@warthog.procyon.org.uk> <874np4cymj.fsf@rustcorp.com.au>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab2GSLyK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2012 07:54:10 -0400
In-Reply-To: <20120719062320.GA21565@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: dhowells@redhat.com, Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

Paul Mundt <lethal@linux-sh.org> wrote:

> The DWARF_UNWINDER check is already done in the Kconfig part of this
> patch, so the ifdef here simply seems like a remnant that should have
> been deleted (as the endif was) -- similar to the ARM unwinder case.

No, you still need the #ifdef here.

In the sh/Kconfig you can see this:

	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER

This says that the arch defines struct mod_arch_specific if
CONFIG_DWARF_UNWINDER is enabled.

If it is not enabled, asm-generic/module.h will emit its own definition of
struct mod_arch_specific which will clash with the one in
arch/sh/include/asm/module.h if the latter is not hidden by the preprocessor.

Note that the ARM unwinder case is the same.  In the Kconfig you have:

	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND

and in ARM's module.h you have:

	#ifdef CONFIG_ARM_UNWIND
	enum {
		ARM_SEC_INIT,
		ARM_SEC_DEVINIT,
		ARM_SEC_CORE,
		ARM_SEC_EXIT,
		ARM_SEC_DEVEXIT,
		ARM_SEC_MAX,
	};

	struct mod_arch_specific {
		struct unwind_table *unwind[ARM_SEC_MAX];
	};
	#endif

(Note I'm quoting from the latest version of the patch which got substantially
reworked).

David
