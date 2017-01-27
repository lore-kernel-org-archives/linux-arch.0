Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37442 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933332AbdA0QVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2017 11:21:04 -0500
Received: by mail-it0-f44.google.com with SMTP id r185so59451353ita.0
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2017 08:21:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485274600-21976-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1485274600-21976-1-git-send-email-ard.biesheuvel@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 27 Jan 2017 16:13:24 +0000
Message-ID: <CAKv+Gu8RUVVU=FhK4TT5nHiXtLmB8079GEWfZPq4jid5LQ5a5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] modversions: redefine kcrctab entries as 32-bit values
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, Jessica Yu <jeyu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20170127161324.PtqUiSrQV1n3tu_gq1i3lmN3c70tN0jsWXGPcRyCqUs@z>

On 24 January 2017 at 16:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> This v4 is a followup to [0] 'modversions: redefine kcrctab entries as
> relative CRC pointers', but since relative CRC pointers do not work in
> modules, and are actually only needed by powerpc with CONFIG_RELOCATABLE=y,
> I have made it a Kconfig selectable feature instead.
>
> Patch #1 introduces the MODULE_REL_CRCS Kconfig symbol, and adds the kbuild
> handling of it, i.e., modpost, genksyms and kallsyms.
>
> Patch #2 switches all architectures to 32-bit CRC entries in kcrctab, where
> all architectures except powerpc with CONFIG_RELOCATABLE=y use absolute ELF
> symbol references as before.
>
> v4: make relative CRCs kconfig selectable
>     use absolute CRC symbols in modules regardless of kconfig selection
>     split into two patches
>
> v3: emit CRCs into .rodata rather than .rodata.modver, given that the latter
>     will be emitted with read-write permissions, making the CRCs end up in a
>     writable module segment.
>
>     fold the modpost fix to ensure that the section address is only substracted
>     from the symbol address when the ELF object in question is fully linked
>     (i.e., ET_DYN or ET_EXEC, and not ET_REL)
>
> v2: update modpost as well, so that genksyms no longer has to emit symbols
>     for both the actual CRC value and the reference to where it is stored
>     in the image
>
> [0] http://marc.info/?l=linux-arch&m=148493613415294&w=2
>
> Ard Biesheuvel (2):
>   kbuild: modversions: add infrastructure for emitting relative CRCs
>   modversions: treat symbol CRCs as 32 bit quantities
>

Linus, Andrew,

I think this code is in good shape now, given that I had to revert the
full switch to relative CRC references due to the fact many
architectures don't support that in modules, and so the only arch that
opts into these relative CRCs is power with CONFIG_RELOCATABLE=y.

I haven't heard any complaints or objections, so perhaps it is time to
get this queued somewhere.

Andrew, is this something you would be able to pick up? Thanks.

Regards,
Ard.
