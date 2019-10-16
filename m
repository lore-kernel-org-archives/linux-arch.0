From: Marco Elver <elver@google.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Date: Wed, 16 Oct 2019 12:06:51 +0200
Message-ID: <CANpmjNOxmQDKin=9Cyi+ERVQ-ehH79AaPjRvJNfFfmgOjJAogA@mail.gmail.com>
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-2-elver@google.com>
 <20191016094234.GB2701514@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016094234.GB2701514@tardis>
Sender: linux-kernel-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, ard.biesheuvel@linaro.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, dave.hansen@linux.intel.com, dhowells@redhat.com, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark
List-Id: linux-arch.vger.kernel.org

On Wed, 16 Oct 2019 at 11:42, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi Marco,
>
> On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
> [...]
> > --- /dev/null
> > +++ b/kernel/kcsan/kcsan.c
> > @@ -0,0 +1,81 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
> > + * see Documentation/dev-tools/kcsan.rst.
> > + */
> > +
> > +#include <linux/export.h>
> > +
> > +#include "kcsan.h"
> > +
> > +/*
> > + * Concurrency Sanitizer uses the same instrumentation as Thread Sanitizer.
>
> Is there any documentation on the instrumentation? Like a complete list
> for all instrumentation functions plus a description of where the
> compiler will use those functions. Yes, the names of the below functions
> are straightforward, but an accurate doc on the instrumentation will
> cerntainly help people review KCSAN.

As far as I'm aware neither GCC nor Clang have documentation on the
emitted instrumentation that we could reference (other than look into
the compiler passes).

However it is as straightforward as it seems: the compiler emits
instrumentation calls for all loads and stores that the compiler
generates; inline asm is not instrumented. I will add a comment to
that effect for v2.

Thanks,
-- Marco

> Regards,
> Boqun
>
> > + */
> > +
> > +#define DEFINE_TSAN_READ_WRITE(size)                                           \
> > +     void __tsan_read##size(void *ptr)                                      \
> > +     {                                                                      \
> > +             __kcsan_check_access(ptr, size, false);                        \
> > +     }                                                                      \
> > +     EXPORT_SYMBOL(__tsan_read##size);                                      \
> > +     void __tsan_write##size(void *ptr)                                     \
> > +     {                                                                      \
> > +             __kcsan_check_access(ptr, size, true);                         \
> > +     }                                                                      \
> > +     EXPORT_SYMBOL(__tsan_write##size)
> > +
> > +DEFINE_TSAN_READ_WRITE(1);
> > +DEFINE_TSAN_READ_WRITE(2);
> > +DEFINE_TSAN_READ_WRITE(4);
> > +DEFINE_TSAN_READ_WRITE(8);
> > +DEFINE_TSAN_READ_WRITE(16);
> > +
> > +/*
> > + * Not all supported compiler versions distinguish aligned/unaligned accesses,
> > + * but e.g. recent versions of Clang do.
> > + */
> > +#define DEFINE_TSAN_UNALIGNED_READ_WRITE(size)                                 \
> > +     void __tsan_unaligned_read##size(void *ptr)                            \
> > +     {                                                                      \
> > +             __kcsan_check_access(ptr, size, false);                        \
> > +     }                                                                      \
> > +     EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
> > +     void __tsan_unaligned_write##size(void *ptr)                           \
> > +     {                                                                      \
> > +             __kcsan_check_access(ptr, size, true);                         \
> > +     }                                                                      \
> > +     EXPORT_SYMBOL(__tsan_unaligned_write##size)
> > +
> > +DEFINE_TSAN_UNALIGNED_READ_WRITE(2);
> > +DEFINE_TSAN_UNALIGNED_READ_WRITE(4);
> > +DEFINE_TSAN_UNALIGNED_READ_WRITE(8);
> > +DEFINE_TSAN_UNALIGNED_READ_WRITE(16);
> > +
> > +void __tsan_read_range(void *ptr, size_t size)
> > +{
> > +     __kcsan_check_access(ptr, size, false);
> > +}
> > +EXPORT_SYMBOL(__tsan_read_range);
> > +
> > +void __tsan_write_range(void *ptr, size_t size)
> > +{
> > +     __kcsan_check_access(ptr, size, true);
> > +}
> > +EXPORT_SYMBOL(__tsan_write_range);
> > +
> > +/*
> > + * The below are not required KCSAN, but can still be emitted by the compiler.
> > + */
> > +void __tsan_func_entry(void *call_pc)
> > +{
> > +}
> > +EXPORT_SYMBOL(__tsan_func_entry);
> > +void __tsan_func_exit(void)
> > +{
> > +}
> > +EXPORT_SYMBOL(__tsan_func_exit);
> > +void __tsan_init(void)
> > +{
> > +}
> > +EXPORT_SYMBOL(__tsan_init);
> [...]
