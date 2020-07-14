From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Tue, 14 Jul 2020 10:54:02 -0700
Message-ID: <CAKwvOdnFxihNnGYTsowzEbtMvb-pwv9pHNo-tihD2h74LX+H+g@mail.gmail.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <671d8923-ed43-4600-2628-33ae7cb82ccb@molgen.mpg.de> <CA+icZUXPB_C1bjA13zi3OLFCpiZh+GsgHT0y6kumzVRavs4LkQ@mail.gmail.com>
 <20200712184041.GA1838@Ryzen-9-3900X.localdomain> <CA+icZUWyqb8jdzTAophvBKuX3e2NvG7vQPnMW+SRW5v0PmU7TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgGNRyO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 13:54:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27CC061794
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 10:54:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so7326174plm.10
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2020 10:54:14 -0700 (PDT)
In-Reply-To: <CA+icZUWyqb8jdzTAophvBKuX3e2NvG7vQPnMW+SRW5v0PmU7TA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Clang-Built-Linux ML <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>

On Tue, Jul 14, 2020 at 2:44 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jul 12, 2020 at 8:40 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Lastly, for the future, I would recommend grabbing b4 to easily apply
> > patches (specifically full series) from lore.kernel.org.
> >
> > https://git.kernel.org/pub/scm/utils/b4/b4.git/
> > https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/README.rst
> >
> > You could grab this series and apply it easily by either downloading the
> > mbox file and following the instructions it gives for applying the mbox
> > file:
> >
> > $ b4 am 20200624203200.78870-1-samitolvanen@google.com
> >
> > or I prefer piping so that I don't have to clean up later:
> >
> > $ b4 am -o - 20200624203200.78870-1-samitolvanen@google.com | git am
> >
>
> It is always a pleasure to read your replies and enrich my know-how
> beyond Linux-kernel hacking :-).
>
> Thanks for the tip with "b4" tool.
> Might add this to our ClangBuiltLinux wiki "Command line tips and tricks"?
>
> - Sedat -
>
> [1] https://github.com/ClangBuiltLinux/linux/wiki/Command-line-tips-and-tricks

Good idea, done.

-- 
Thanks,
~Nick Desaulniers
