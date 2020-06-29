Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbgF2U3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 16:29:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B5C03E979
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 13:29:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so1964521pgm.11
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 13:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org> <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
 <9b7f9c3aed7223e49def6e775d3b250aa780e562.camel@perches.com>
In-Reply-To: <9b7f9c3aed7223e49def6e775d3b250aa780e562.camel@perches.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 29 Jun 2020 13:29:38 -0700
Message-ID: <CAKwvOdnOCEZ8LUEY6+gVcTcNuaabRnj4hXG6-pcb_6fcQJsr6w@mail.gmail.com>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20200629202938.Bpk-wu95d0qd08kJvaol3zeCNQAkVB2TuH-W5Zs3Efs@z>

On Mon, Jun 29, 2020 at 1:03 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-06-29 at 12:53 -0700, Nick Desaulniers wrote:
> > On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> > > Fix a case of needless quotes in __section(), which Clang doesn't like.
> > >
> > > Acked-by: Will Deacon <will@kernel.org>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Yep, I remember bugs from this.  Probably should scan the kernel for
> > other instances of this.  +Joe for checkpatch.pl validation.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> $ git grep -P -n '__section\s*\(\s*\"'
> arch/arm64/mm/mmu.c:45:u64 __section(".mmuoff.data.write") vabits_actual;
> include/linux/compiler.h:211:   __section("___kentry" "+" #sym )                        \
> include/linux/export.h:133:     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> include/linux/srcutree.h:127:           __section("___srcu_struct_ptrs") = &name
>
> My recollection is I submitted a patch
> to _add_ quotes
>
> https://lore.kernel.org/patchwork/patch/1125785/

Hey, yeah!  Did you end up sending v2?

-- 
Thanks,
~Nick Desaulniers
