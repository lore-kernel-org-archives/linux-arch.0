Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfFGJoD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 05:44:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so980164oif.10
        for <linux-arch@vger.kernel.org>; Fri, 07 Jun 2019 02:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190531150828.157832-1-elver@google.com> <20190531150828.157832-3-elver@google.com>
In-Reply-To: <20190531150828.157832-3-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 7 Jun 2019 11:43:50 +0200
Message-ID: <CANpmjNP_-J5dZVtDeHUeDk2TBBkOgoPvGKq42Qd7rezbnFWNGg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] x86: Use static_cpu_has in uaccess region to avoid instrumentation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <mark.rutland@arm.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190607094350.PZ0umoVv5yA1ECmlAZ7gjBwlHpcyMe2jSopdQd3MjKs@z>

Gentle ping.  I would appreciate quick feedback if this approach is reasonable.

Peter: since you suggested that we should not change objtool, did you
have a particular approach in mind that is maybe different from v2 and
v3? Or is this what you were thinking of?

Many thanks!

On Fri, 31 May 2019 at 17:11, Marco Elver <elver@google.com> wrote:
>
> This patch is a pre-requisite for enabling KASAN bitops instrumentation;
> using static_cpu_has instead of boot_cpu_has avoids instrumentation of
> test_bit inside the uaccess region. With instrumentation, the KASAN
> check would otherwise be flagged by objtool.
>
> For consistency, kernel/signal.c was changed to mirror this change,
> however, is never instrumented with KASAN (currently unsupported under
> x86 32bit).
>
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> ---
> Changes in v3:
> * Use static_cpu_has instead of moving boot_cpu_has outside uaccess
>   region.
>
> Changes in v2:
> * Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
>   whitelist'
> ---
>  arch/x86/ia32/ia32_signal.c | 2 +-
>  arch/x86/kernel/signal.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 629d1ee05599..1cee10091b9f 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
>                 put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
>
>                 /* Create the ucontext.  */
> -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> +               if (static_cpu_has(X86_FEATURE_XSAVE))
>                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
>                 else
>                         put_user_ex(0, &frame->uc.uc_flags);
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index 364813cea647..52eb1d551aed 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>                 put_user_ex(&frame->uc, &frame->puc);
>
>                 /* Create the ucontext.  */
> -               if (boot_cpu_has(X86_FEATURE_XSAVE))
> +               if (static_cpu_has(X86_FEATURE_XSAVE))
>                         put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
>                 else
>                         put_user_ex(0, &frame->uc.uc_flags);
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
