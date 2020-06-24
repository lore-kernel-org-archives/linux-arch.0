Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbgFXU5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:57:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F58EC061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:57:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u5so1775658pfn.7
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-14-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-14-samitolvanen@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 24 Jun 2020 13:57:11 -0700
Message-ID: <CAKwvOd=XxsGowjitcqDrw6g-cxB=kqAsvRS+PyaMrYWnPgjqbg@mail.gmail.com>
Subject: Re: [PATCH 13/22] scripts/mod: disable LTO for empty.c
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200624205711.LvRFQft6b9ObqVqWoZ_E2skA4ZlgU9CXe2C-oW5SIX0@z>

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
> files. As empty.o is used for probing target properties, disable LTO
> for it to produce an object file instead.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/mod/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index 296b6a3878b2..b6e3b40c6eeb 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  OBJECT_FILES_NON_STANDARD := y
> +CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
>
>  hostprogs      := modpost mk_elfconfig
>  always-y       := $(hostprogs) empty.o
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
