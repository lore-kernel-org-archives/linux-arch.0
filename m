Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33860 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732340AbfJVSRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Oct 2019 14:17:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so15069681oii.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2019 11:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-8-elver@google.com>
 <20191022123329.GC11583@lakrids.cambridge.arm.com>
In-Reply-To: <20191022123329.GC11583@lakrids.cambridge.arm.com>
From: Marco Elver <elver@google.com>
Date: Tue, 22 Oct 2019 20:17:43 +0200
Message-ID: <CANpmjNOhoyDMFMUz6by3hLtX7aBFk4pXTmzjmWYiq2+z+R5fAQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] locking/atomics, kcsan: Add KCSAN instrumentation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191022181743.tFjqouOhIxXbARh9r_9yb5WB5sy6qk2mapVOPzdo3x0@z>

On Tue, 22 Oct 2019 at 14:33, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 17, 2019 at 04:13:04PM +0200, Marco Elver wrote:
> > This adds KCSAN instrumentation to atomic-instrumented.h.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Use kcsan_check{,_atomic}_{read,write} instead of
> >   kcsan_check_{access,atomic}.
> > * Introduce __atomic_check_{read,write} [Suggested by Mark Rutland].
> > ---
> >  include/asm-generic/atomic-instrumented.h | 393 +++++++++++-----------
> >  scripts/atomic/gen-atomic-instrumented.sh |  17 +-
> >  2 files changed, 218 insertions(+), 192 deletions(-)
>
> The script changes and generated code look fine to me, so FWIW:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Great, thank you Mark!

> Thanks,
> Mark.
>
> > diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
> > index e09812372b17..8b8b2a6f8d68 100755
> > --- a/scripts/atomic/gen-atomic-instrumented.sh
> > +++ b/scripts/atomic/gen-atomic-instrumented.sh
> > @@ -20,7 +20,7 @@ gen_param_check()
> >       # We don't write to constant parameters
> >       [ ${type#c} != ${type} ] && rw="read"
> >
> > -     printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
> > +     printf "\t__atomic_check_${rw}(${name}, sizeof(*${name}));\n"
> >  }
> >
> >  #gen_param_check(arg...)
> > @@ -107,7 +107,7 @@ cat <<EOF
> >  #define ${xchg}(ptr, ...)                                            \\
> >  ({                                                                   \\
> >       typeof(ptr) __ai_ptr = (ptr);                                   \\
> > -     kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));          \\
> > +     __atomic_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));               \\
> >       arch_${xchg}(__ai_ptr, __VA_ARGS__);                            \\
> >  })
> >  EOF
> > @@ -148,6 +148,19 @@ cat << EOF
> >
> >  #include <linux/build_bug.h>
> >  #include <linux/kasan-checks.h>
> > +#include <linux/kcsan-checks.h>
> > +
> > +static inline void __atomic_check_read(const volatile void *v, size_t size)
> > +{
> > +     kasan_check_read(v, size);
> > +     kcsan_check_atomic_read(v, size);
> > +}
> > +
> > +static inline void __atomic_check_write(const volatile void *v, size_t size)
> > +{
> > +     kasan_check_write(v, size);
> > +     kcsan_check_atomic_write(v, size);
> > +}
> >
> >  EOF
> >
> > --
> > 2.23.0.866.gb869b98d4c-goog
> >
