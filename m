From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge
 mmu and non-mmu versions of sys_call_table)
Date: Wed, 13 Apr 2011 20:05:25 +0200
Message-ID: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55226 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab1DMSF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2011 14:05:27 -0400
Received: by bwz15 with SMTP id 15so791303bwz.19
        for <linux-arch@vger.kernel.org>; Wed, 13 Apr 2011 11:05:26 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Thu, Apr 7, 2011 at 10:29, Andreas Schwab <schwab@linux-m68k.org> wr=
ote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Isn't there a reason it was read-write on m68k, like the table may b=
e changed
>> at runtime (to install rootkits :-)? Have to check what the other ar=
ches do...
>
> Initially the syscall_table in Linux has always been writable, bb152f=
53
> ("x86/x86_64: mark rodata section read-only: make some datastructures
> const") made it read-only on x86. =C2=A0Apparently nobody bothered to=
 do the
> equivalent change on m68k (I don't think anything makes the kernel te=
xt
> segment write protected anyway).

11 arches still store it in "data", including the 4 using the new
asm-generic/unistd.h
framework. 9 use "rodata" and 6 use "text".
The constness of C "extern" declarations doesn't necessarily matches th=
e
actual sections.

alpha:          .data
arm:            presumably .text?
avr32:          .section .rodata,"a",@progbits
blackfin:       .section .l1.data / .data
cris:           .section .rodata,"a"
frv:            .section .rodata
h8300:          .section .text
ia64:           .rodata
                extern unsigned long sys_call_table[NR_syscalls];
m32r:           .section .rodata,"a"
m68k:           .data (mmu), .text (nommu)
m68knommu:      .text
microblaze:     .section .rodata,"a"
mips:           presumably .text?
mn10300:        .data
                extern const unsigned long sys_call_table[];
parisc:         .section .rodata,"a"
powerpc:        presumably .text?
                extern unsigned long *sys_call_table;
                static void *spu_syscall_table[] (SPU in CBEA)
s390:           .section .rodata, "a"
                extern const unsigned int sys_call_table[];
score:          void *sys_call_table[__NR_syscalls[] =3D { ... }
sh:             .data
                extern const unsigned long sys_call_table[];
sh64:           .section .data, "aw"
sparc:          .data
                extern const unsigned int sys_call_table[];
sparc64:        .text
tile:           void *sys_call_table[__NR_syscalls] =3D { ... }
                void *compat_sys_call_table[__NR_syscalls] =3D { ... }
um:             extern syscall_handler_t *sys_call_table[];
unicore32:      void *sys_call_table[__NR_syscalls] =3D { ... }
x86:            .section .rodata,"a"
                extern const unsigned long sys_call_table[];
                const sys_call_ptr_t
sys_call_table[__NR_syscall_max+1] =3D { ...  }
xtensa:         syscall_t sys_call_table[__NR_syscall_count] =3D { ... =
}

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
