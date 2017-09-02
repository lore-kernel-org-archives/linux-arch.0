From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] locking/refcounts, x86/asm: Use unique .text section for
 refcount exceptions
Date: Sat, 2 Sep 2017 12:29:45 +0200
Message-ID: <20170902102945.xb3rvd6ursb2s5a4@gmail.com>
References: <20170901202203.GA48925@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33936 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbdIBK3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Sep 2017 06:29:49 -0400
Content-Disposition: inline
In-Reply-To: <20170901202203.GA48925@beast>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@elte.hu>, x86@kernel.org, linux-arch@vger.kernel.org, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, "Reshetova, Elena" <elena.reshetova@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>


* Kees Cook <keescook@chromium.org> wrote:

> Using .text.unlikely for refcount exceptions isn't safe because gcc may
> move entire functions into .text.unlikely (e.g. in6_dev_get()), which
> would cause any uses of a protected refcount_t function to stay inline
> with the function, triggering the protection unconditionally:
> 
>         .section        .text.unlikely,"ax",@progbits
>         .type   in6_dev_get, @function
> in6_dev_getx:
> .LFB4673:
>         .loc 2 4128 0
>         .cfi_startproc
> ...
>         lock; incl 480(%rbx)
>         js 111f
>         .pushsection .text.unlikely
> 111:    lea 480(%rbx), %rcx
> 112:    .byte 0x0f, 0xff
> .popsection
> 113:
> 
> This creates a unique .text section and adds an additional test to the
> exception handler to WARN in the case of having none of OF, SF, nor ZF
> set so we can see things like this more easily in the future.
> 
> Reported-by: Mike Galbraith <efault@gmx.de>
> Fixes: 7a46ec0e2f48 ("locking/refcounts, x86/asm: Implement fast refcount overflow protection")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/Kconfig                  | 2 +-
>  arch/x86/include/asm/refcount.h   | 2 +-
>  arch/x86/mm/extable.c             | 7 ++++++-
>  include/asm-generic/vmlinux.lds.h | 1 +
>  4 files changed, 9 insertions(+), 3 deletions(-)

Could you please split this into two patches: one that fixes the .unlikely bug, 
the other that re-enables the optimized version?

Should there be any other problem with refcounts this would make any bisection 
result more clear-cut.

Thanks,

	Ingo
