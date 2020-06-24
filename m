Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgFXXGB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:06:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA308C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:06:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so1995621pjs.3
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-18-samitolvanen@google.com> <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
 <20200624215231.GC120457@google.com>
In-Reply-To: <20200624215231.GC120457@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 24 Jun 2020 16:05:48 -0700
Message-ID: <CAKwvOdnWfhU7n0VfoydC7epJPrj+ASZzyNRpBCNuvT_5E+=FcQ@mail.gmail.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200624230548.Y8wS4KDb5tYZUQyb4txuWwhMjYLOcuLJbvnekPjHUCQ@z>

On Wed, Jun 24, 2020 at 2:52 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 01:58:57PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > Filter out CC_FLAGS_LTO for the vDSO.
> >
> > Just curious about this patch (and the following one for x86's vdso),
> > do you happen to recall specifically what the issues with the vdso's
> > are?
>
> I recall the compiler optimizing away functions at some point, but as
> LTO is not really needed in the vDSO, it's just easiest to disable it
> there.

Sounds fishy; with extern linkage then I would think it's not safe to
eliminate functions.  Probably unnecessary for the initial
implementation, and something we can follow up on, but always good to
have an answer to the inevitable question "why?" in the commit
message.
-- 
Thanks,
~Nick Desaulniers
