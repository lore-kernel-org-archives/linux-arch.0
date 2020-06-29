From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 08/17] arm64/mm: Remove needless section quotes
Date: Mon, 29 Jun 2020 13:04:31 -0700
Message-ID: <202006291301.46FEF3B7@keescook>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-9-keescook@chromium.org>
 <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbgF2UEe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 16:04:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FCC03E97A
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 13:04:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so8336925pfa.12
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 13:04:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKwvOd=r6bsBfSZxVYrnbm1Utq==ApWBDjx+0Fxsm90Aq3Jghw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.in>

On Mon, Jun 29, 2020 at 12:53:47PM -0700, Nick Desaulniers wrote:
> On Sun, Jun 28, 2020 at 11:18 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Fix a case of needless quotes in __section(), which Clang doesn't like.
> >
> > Acked-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Yep, I remember bugs from this.  Probably should scan the kernel for
> other instances of this.  +Joe for checkpatch.pl validation.

I think the others are safe because they're in macros:

$ git grep -4 '__section("'
include/linux/compiler.h-# define KENTRY(sym)                                           \
include/linux/compiler.h-       extern typeof(sym) sym;                                 \
include/linux/compiler.h-       static const unsigned long __kentry_##sym               \
include/linux/compiler.h-       __used                                                  \
include/linux/compiler.h:       __section("___kentry" "+" #sym )                        \
include/linux/compiler.h-       = (unsigned long)&sym;
--
include/linux/export.h-#define __ksym_marker(sym)       \
include/linux/export.h: static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
