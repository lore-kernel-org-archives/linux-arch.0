From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 1/3] lib/test_kasan: Add bitops tests
Date: Thu, 13 Jun 2019 15:00:09 +0200
Message-ID: <CANpmjNNMmSHvP+tzod=WeoDp6jsxGsDKV5cXiTr3F9fxEMasaw@mail.gmail.com>
References: <20190613123028.179447-1-elver@google.com> <20190613123028.179447-2-elver@google.com>
 <6cc5e12d-1492-d9b7-3ea7-6381407439d7@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6cc5e12d-1492-d9b7-3ea7-6381407439d7@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <mark.rutland@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 13 Jun 2019 at 14:49, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>
>
> On 6/13/19 3:30 PM, Marco Elver wrote:
> > This adds bitops tests to the test_kasan module. In a follow-up patch,
> > support for bitops instrumentation will be added.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
>
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>
>
>
>
> > +static noinline void __init kasan_bitops(void)
> > +{
> > +     /*
> > +      * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
> > +      * this way we do not actually corrupt other memory, in case
> > +      * instrumentation is not working as intended.
>
> This sound like working instrumentation somehow save us from corrupting memory. In fact it doesn't,
> it only reports corruption.

Thanks, I removed the confusing wording. Sent v5.

> > +      */
> > +     long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
> > +     if (!bits)
> > +             return;
> > +
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/6cc5e12d-1492-d9b7-3ea7-6381407439d7%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.
