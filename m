Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38700 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaJ5s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 05:57:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id 18so6482547oij.5
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 02:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190529141500.193390-1-elver@google.com> <20190529141500.193390-3-elver@google.com>
 <EE911EC6-344B-4EB2-90A4-B11E8D96BEDC@zytor.com>
In-Reply-To: <EE911EC6-344B-4EB2-90A4-B11E8D96BEDC@zytor.com>
From: Marco Elver <elver@google.com>
Date: Fri, 31 May 2019 11:57:36 +0200
Message-ID: <CANpmjNOsPnVd50cTzUW8UYXPGqpSnRLcjj=JbZraTYVq1n18Fw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190531095736.1yNweGwZ5duC2_Hm4W4RZYsjaE-POpw9Ao_R6uzBwwo@z>

On Wed, 29 May 2019 at 16:29, <hpa@zytor.com> wrote:
>
> On May 29, 2019 7:15:00 AM PDT, Marco Elver <elver@google.com> wrote:
> >This patch is a pre-requisite for enabling KASAN bitops
> >instrumentation:
> >moves boot_cpu_has feature test out of the uaccess region, as
> >boot_cpu_has uses test_bit. With instrumentation, the KASAN check would
> >otherwise be flagged by objtool.
> >
> >This approach is preferred over adding the explicit kasan_check_*
> >functions to the uaccess whitelist of objtool, as the case here appears
> >to be the only one.
> >
> >Signed-off-by: Marco Elver <elver@google.com>
> >---
> >v1:
> >* This patch replaces patch: 'tools/objtool: add kasan_check_* to
> >  uaccess whitelist'
> >---
> > arch/x86/ia32/ia32_signal.c | 9 ++++++++-
> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> >index 629d1ee05599..12264e3c9c43 100644
> >--- a/arch/x86/ia32/ia32_signal.c
> >+++ b/arch/x86/ia32/ia32_signal.c
> >@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal
> >*ksig,
> >       void __user *restorer;
> >       int err = 0;
> >       void __user *fpstate = NULL;
> >+      bool has_xsave;
> >
> >       /* __copy_to_user optimizes that into a single 8 byte store */
> >       static const struct {
> >@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct ksignal
> >*ksig,
> >       if (!access_ok(frame, sizeof(*frame)))
> >               return -EFAULT;
> >
> >+      /*
> >+       * Move non-uaccess accesses out of uaccess region if not strictly
> >+       * required; this also helps avoid objtool flagging these accesses
> >with
> >+       * instrumentation enabled.
> >+       */
> >+      has_xsave = boot_cpu_has(X86_FEATURE_XSAVE);
> >       put_user_try {
> >               put_user_ex(sig, &frame->sig);
> >               put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
> >               put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
> >
> >               /* Create the ucontext.  */
> >-              if (boot_cpu_has(X86_FEATURE_XSAVE))
> >+              if (has_xsave)
> >                       put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
> >               else
> >                       put_user_ex(0, &frame->uc.uc_flags);
>
> This was meant to use static_cpu_has(). Why did that get dropped?

I couldn't find any mailing list thread referring to why this doesn't
use static_cpu_has, do you have any background?

static_cpu_has also solves the UACCESS warning.

If you confirm it is safe to change to static_cpu_has(), I will change
this patch. Note that I should then also change
arch/x86/kernel/signal.c to mirror the change for 32bit  (although
KASAN is not supported for 32bit x86).

Thanks,
-- Marco
