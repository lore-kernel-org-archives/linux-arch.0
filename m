From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v6 2/2] x86/refcount: Implement fast refcount overflow protection
Date: Wed, 19 Jul 2017 12:45:19 -0700
Message-ID: <CAGXu5jKqqRJ3H0fwwc5W14U14p-QzTe1=UWJggA2yxLuj23ZTA@mail.gmail.com>
References: <1500422614-94821-1-git-send-email-keescook@chromium.org>
 <1500422614-94821-3-git-send-email-keescook@chromium.org> <20170719193718.bvkkde5apbboudrk@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37497 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934138AbdGSTpY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jul 2017 15:45:24 -0400
Received: by mail-io0-f174.google.com with SMTP id c74so4217917iod.4
        for <linux-arch@vger.kernel.org>; Wed, 19 Jul 2017 12:45:23 -0700 (PDT)
In-Reply-To: <20170719193718.bvkkde5apbboudrk@treble>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.>

On Wed, Jul 19, 2017 at 12:37 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Tue, Jul 18, 2017 at 05:03:34PM -0700, Kees Cook wrote:
>> +/*
>> + * Body of refcount error handling: in .text.unlikely, saved into CX the
>> + * address of the refcount that has entered a bad state, and trigger an
>> + * exception. Fixup address is back in regular execution flow in .text.
>> + */
>> +#define _REFCOUNT_EXCEPTION                          \
>> +     ".pushsection .text.unlikely\n"                 \
>> +     "111:\tlea %[counter], %%" _ASM_CX "\n"         \
>> +     "112:\t" ASM_UD0 "\n"                           \
>> +     ".popsection\n"                                 \
>> +     "113:\n"                                        \
>> +     _ASM_EXTABLE_REFCOUNT(112b, 113b)
>
> This confuses the freshly merged objtool 2.0, which is now too smart for
> its own good.  It's reporting some errors like:
>
>   >> kernel/sched/autogroup.o: warning: objtool: sched_autogroup_exit()+0x48: return with modified stack frame
>   >> kernel/sched/autogroup.o: warning: objtool: .text.unlikely+0x27: stack state mismatch: reg1[3]=-2-40 reg2[3]=-2-24
>   >> kernel/sched/autogroup.o: warning: objtool: sched_autogroup_exit()+0x14: stack state mismatch: reg1[3]=-2-40 reg2[3]=-2-24
>
> Because the UD instructions are used for both WARN and BUG, objtool
> doesn't know whether control flow continues past the instruction.  So in
> cases like this, it needs an "unreachable" annotation.
>
> Here's a patch to fix it, feel free to squash it into yours:

Thanks! I'll add it for v7.

> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index 13b91e850a02..e7587db3487c 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -15,6 +15,7 @@
>         ".pushsection .text.unlikely\n"                 \
>         "111:\tlea %[counter], %%" _ASM_CX "\n"         \
>         "112:\t" ASM_UD0 "\n"                           \
> +       ASM_UNREACHABLE                                 \
>         ".popsection\n"                                 \
>         "113:\n"                                        \
>         _ASM_EXTABLE_REFCOUNT(112b, 113b)
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index cd4bbe8242bd..85e0b8f42ca0 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -202,15 +202,25 @@
>  #endif
>
>  #ifdef CONFIG_STACK_VALIDATION
> +
>  #define annotate_unreachable() ({                                      \
>         asm("%c0:\t\n"                                                  \
> -           ".pushsection .discard.unreachable\t\n"                     \
> -           ".long %c0b - .\t\n"                                        \
> -           ".popsection\t\n" : : "i" (__LINE__));                      \
> +           ".pushsection .discard.unreachable\n\t"                     \
> +           ".long %c0b - .\n\t"                                        \
> +           ".popsection\n\t" : : "i" (__LINE__));                      \

Is this just an indentation change?

>  })
> +
> +#define ASM_UNREACHABLE                                                        \
> +       "999: .pushsection .discard.unreachable\n\t"                    \
> +       ".long 999b - .\n\t"                                            \
> +       ".popsection\n\t"

Just so I understand, we'll get a single byte added for each exception
case, but it'll get discarded during final link?

> +
>  #else
> +
>  #define annotate_unreachable()
> -#endif
> +#define ASM_UNREACHABLE
> +
> +#endif /* CONFIG_STACK_VALIDATION */
>
>  /*
>   * Mark a position in code as unreachable.  This can be used to

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
