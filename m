From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 05/17] ctype: Work around Clang
 -mbranch-protection=none bug
Date: Mon, 29 Jun 2020 11:37:16 -0700
Message-ID: <202006291136.E6DF8242@keescook>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-6-keescook@chromium.org>
 <CAMj1kXE+toCd=Bx-zw7D9bvDRNB2aPn5-_7CY7MOKcVGA-azVg@mail.gmail.com>
 <202006290806.3BDE2A8@keescook>
 <CAKwvOd=DMfmvfiEX7KDPLs75SbNz+LAGSwC3V_=LgGH3kjtE=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgF2Smw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDBEC033C3C
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 11:37:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so7429368pls.5
        for <linux-arch@vger.kernel.org>; Mon, 29 Jun 2020 11:37:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKwvOd=DMfmvfiEX7KDPLs75SbNz+LAGSwC3V_=LgGH3kjtE=g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Mon, Jun 29, 2020 at 11:02:51AM -0700, Nick Desaulniers wrote:
> This is definitely better than the empty function.  Though a patch is
> posted for fixing this in LLVM. Assuming that lands before this, we
> might not actually need this workaround?
> 
> arch/arm64/Kconfig
> 1625 config ARM64_BTI_KERNEL
> ...
> 1633   # https://reviews.llvm.org/rGb8ae3fdfa579dbf366b1bb1cbfdbf8c51db7fa55
> 1634   depends on !CC_IS_CLANG || CLANG_VERSION >= 100001
> 
> So if Daniel's patch lands AND is backported into the clang 10.0.1
> release, then we might not need to carry this workaround?  Either way,

True, though as I mentioned in the review, I don't think it's quite
right -- the warning getting removed is actually quite valuable.

> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks!

-- 
Kees Cook
