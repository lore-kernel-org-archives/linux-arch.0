From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Make most arch asm/module.h files use asm-generic/module.h
Date: Wed, 18 Jul 2012 13:20:35 +0000
Message-ID: <201207181320.35807.arnd@arndb.de>
References: <32350.1342615619@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53215 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab2GRNU6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jul 2012 09:20:58 -0400
In-Reply-To: <32350.1342615619@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

On Wednesday 18 July 2012, David Howells wrote:
> Hi Rusty, Arnd,
> 
> Here's a patch to asm-genericise the arch asm/module.h files.  It allows four
> of them to be deleted outright.  MIPS is the only weirdo of the bunch.
> 

Good idea!

> commit 4ef65a8a753f6fee4436dfa369e7471d3496b3ae
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Jul 18 13:26:21 2012 +0100
> 
>     Make most arch asm/module.h files use asm-generic/module.h
>     
>     Use the mapping of Elf_[SPE]hdr, Elf_Sym, Elf_Dyn, Elf_Rel/Rela, ELF_R_TYPE()
>     and ELF_R_SYM() to either the 32-bit version or the 64-bit version into
>     asm-generic/module.h for all arches bar MIPS.
>     
>     Also, use the generic definition mod_arch_specific where possible.
>     
>     To this end, I've defined three new config bools:
>     
>      (*) HAVE_MOD_ARCH_SPECIFIC
>     
>          Arches define this if they don't want to use the empty generic
>          mod_arch_specific struct.

The method I try to use for architectures overriding asm-generic definitions
is to make the architecture define the same symbol, like

#ifdef CONFIG_ARM_UNWIND
struct mod_arch_specific {
	struct unwind_table *unwind[ARM_SEC_MAX];
};
#define mod_arch_specific mod_arch_specific
#endif

and then let the asm-generic version test that using

#ifndef mod_arch_specific
struct mod_arch_specific {};
#endif

>      (*) MODULES_USE_RELA_ONLY
>     
>          Arches define this if their modules will only contain RELA records (and
>          not REL records).  This causes the Elf_Rel mapping not to be emitted.
>     
>      (*) MODULES_USE_REL_ONLY
>     
>          Arches define this if their modules will only contain REL records (and
>          not RELA records).  This causes the Elf_Rela mapping not to be emitted.

I believe all architectures have either one or the other, but never both or neither
of the two, right? If so, we only need one symbol here.

We also introduced

int __weak apply_relocate(Elf_Shdr *sechdrs,
                          const char *strtab,
                          unsigned int symindex,
                          unsigned int relsec,
                          struct module *me)
{
        pr_err("module %s: REL relocation unsupported\n", me->name);
        return -ENOEXEC;
}

int __weak apply_relocate_add(Elf_Shdr *sechdrs,
                              const char *strtab,
                              unsigned int symindex,
                              unsigned int relsec,
                              struct module *me)
{
        pr_err("module %s: RELA relocation unsupported\n", me->name);
        return -ENOEXEC;
}

some time back to provide a default so architectures no longer need
to provide the apply_relocate function for both cases. If we have the
Kconfig symbol you introduce, we can turn this into an nice inline
function and do

#ifdef CONFIG_MODULES_USE_RELA_ONLY
static inline int __weak apply_relocate(Elf_Shdr *sechdrs,
                          const char *strtab,
                          unsigned int symindex,
                          unsigned int relsec,
                          struct module *me)
{
        pr_err("module %s: REL relocation unsupported\n", me->name);
        return -ENOEXEC;
}
int __weak apply_relocate_add(Elf_Shdr *sechdrs,
                              const char *strtab,
                              unsigned int symindex,
                              unsigned int relsec,
                              struct module *me);
#else
int __weak apply_relocate(Elf_Shdr *sechdrs,
                          const char *strtab,
                          unsigned int symindex,
                          unsigned int relsec,
                          struct module *me);
static inline int __weak apply_relocate_add(Elf_Shdr *sechdrs,
                              const char *strtab,
                              unsigned int symindex,
                              unsigned int relsec,
                              struct module *me)
{
        pr_err("module %s: RELA relocation unsupported\n", me->name);
        return -ENOEXEC;
}
#endif

and consequently kill off the remaining empty functions.

	Arnd
