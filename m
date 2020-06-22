Return-Path: <SRS0=TrJs=AD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgFVXEx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:04:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70368C061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:04:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so627123pje.4
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org> <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook> <20200622225237.ybol4qmz4mhkmlqc@google.com>
 <202006221555.45BB6412F@keescook>
In-Reply-To: <202006221555.45BB6412F@keescook>
From: =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date: Mon, 22 Jun 2020 16:04:40 -0700
Message-ID: <CAFP8O3KdGc9TtziFX7UzmxA-=wfPzm5oi6NCEwRiyyrp+JD3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20200622230440.fGJ-0B28pLY5W3aE36EWtmYLBQOwz8naSSBiZe5m4Hc@z>

On Mon, Jun 22, 2020 at 3:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > > And it's not in the output:
> > >
> > > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > > No version information found in this file.
> > >
> > > So... for the kernel we need to silence it right now.
> >
> > Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> > sections come from?
>
> It's not reporting it correctly:
>
> .gnu.version_d  0x00000000008966b0        0x0
>  .gnu.version_d
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version    0x00000000008966b0        0x0
>  .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version_r  0x00000000008966b0        0x0
>  .gnu.version_r
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> it just reports whatever file is listed on the link command line first.
>
> > If it is a bug, we should probably figure out which version of binutils
> > has fixed the bug.
>
> I see this with binutils 2.34...
>
> --
> Kees Cook

:( It deserves a binutils bug
(https://sourceware.org/bugzilla/enter_bug.cgi?product=binutils ) and
a comment..

With the description adjusted to say that this works around a bug

Reviewed-by: Fangrui Song <maskray@google.com>
