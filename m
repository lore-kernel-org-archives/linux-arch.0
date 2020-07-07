From: Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Date: Tue, 7 Jul 2020 09:05:28 -0700
Message-ID: <20200707160528.GA1300535@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
 <20200629232059.GA3787278@google.com>
 <20200707155107.GA3357035@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGQFg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 12:05:36 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B20C061755
        for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2020 09:05:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so19317423pgc.8
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2020 09:05:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200707155107.GA3357035@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>

On Tue, Jul 07, 2020 at 08:51:07AM -0700, Sami Tolvanen wrote:
> After spending some time debugging this with Nick, it looks like the
> error is caused by a recent optimization change in LLVM, which together
> with the inlining of ur_load_imm_any into jeq_imm, changes a runtime
> check in FIELD_FIT that would always fail, to a compile-time check that
> breaks the build. In jeq_imm, we have:
> 
>     /* struct bpf_insn: _s32 imm */
>     u64 imm = insn->imm; /* sign extend */
>     ...
>     if (imm >> 32) { /* non-zero only if insn->imm is negative */
>     	/* inlined from ur_load_imm_any */
> 	u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
> 
>         /*
> 	 * __imm has a value known at compile-time, which means
> 	 * __builtin_constant_p(__imm) is true and we end up with
> 	 * essentially this in __BF_FIELD_CHECK:
> 	 */
> 	if (__builtin_constant_p(__imm) && __imm <= 255)

Should be __imm > 255, of course, which means the compiler will generate
a call to __compiletime_assert.

> Jiong, Jakub, do you see any issues here?

(Jiong's email bounced, so removing from the recipient list.)

Sami
