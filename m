Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38216 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfJQA0D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 20:26:03 -0400
Date: Thu, 17 Oct 2019 08:25:51 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191017002551.GC2701514@tardis>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
 <20191016094234.GB2701514@tardis>
 <CANpmjNOxmQDKin=9Cyi+ERVQ-ehH79AaPjRvJNfFfmgOjJAogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <CANpmjNOxmQDKin=9Cyi+ERVQ-ehH79AaPjRvJNfFfmgOjJAogA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, ard.biesheuvel@linaro.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, dave.hansen@linux.intel.com, dhowells@redhat.com, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191017002551.BGfs0miCp_tmWCefFOn69vyHmqGl-ZbSb7JOI2qjAOs@z>


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 12:06:51PM +0200, Marco Elver wrote:
> On Wed, 16 Oct 2019 at 11:42, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hi Marco,
> >
> > On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
> > [...]
> > > --- /dev/null
> > > +++ b/kernel/kcsan/kcsan.c
> > > @@ -0,0 +1,81 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +/*
> > > + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more=
 info please
> > > + * see Documentation/dev-tools/kcsan.rst.
> > > + */
> > > +
> > > +#include <linux/export.h>
> > > +
> > > +#include "kcsan.h"
> > > +
> > > +/*
> > > + * Concurrency Sanitizer uses the same instrumentation as Thread San=
itizer.
> >
> > Is there any documentation on the instrumentation? Like a complete list
> > for all instrumentation functions plus a description of where the
> > compiler will use those functions. Yes, the names of the below functions
> > are straightforward, but an accurate doc on the instrumentation will
> > cerntainly help people review KCSAN.
>=20
> As far as I'm aware neither GCC nor Clang have documentation on the
> emitted instrumentation that we could reference (other than look into
> the compiler passes).
>=20

Yeah, I don't find them either, which makes me surprised, because I
think the thread sanitizer has been there for a while...

> However it is as straightforward as it seems: the compiler emits
> instrumentation calls for all loads and stores that the compiler
> generates; inline asm is not instrumented. I will add a comment to
> that effect for v2.
>=20

Or you can push the compiler people to document it, and we can simply
reference it in kernel ;-)

Regards,
Boqun

> Thanks,
> -- Marco
>=20
> > Regards,
> > Boqun
> >
> > > + */
> > > +
> > > +#define DEFINE_TSAN_READ_WRITE(size)                                =
           \
> > > +     void __tsan_read##size(void *ptr)                              =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, false);                =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_read##size);                              =
        \
> > > +     void __tsan_write##size(void *ptr)                             =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, true);                 =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_write##size)
> > > +
> > > +DEFINE_TSAN_READ_WRITE(1);
> > > +DEFINE_TSAN_READ_WRITE(2);
> > > +DEFINE_TSAN_READ_WRITE(4);
> > > +DEFINE_TSAN_READ_WRITE(8);
> > > +DEFINE_TSAN_READ_WRITE(16);
> > > +
> > > +/*
> > > + * Not all supported compiler versions distinguish aligned/unaligned=
 accesses,
> > > + * but e.g. recent versions of Clang do.
> > > + */
> > > +#define DEFINE_TSAN_UNALIGNED_READ_WRITE(size)                      =
           \
> > > +     void __tsan_unaligned_read##size(void *ptr)                    =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, false);                =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_unaligned_read##size);                    =
        \
> > > +     void __tsan_unaligned_write##size(void *ptr)                   =
        \
> > > +     {                                                              =
        \
> > > +             __kcsan_check_access(ptr, size, true);                 =
        \
> > > +     }                                                              =
        \
> > > +     EXPORT_SYMBOL(__tsan_unaligned_write##size)
> > > +
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(2);
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(4);
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(8);
> > > +DEFINE_TSAN_UNALIGNED_READ_WRITE(16);
> > > +
> > > +void __tsan_read_range(void *ptr, size_t size)
> > > +{
> > > +     __kcsan_check_access(ptr, size, false);
> > > +}
> > > +EXPORT_SYMBOL(__tsan_read_range);
> > > +
> > > +void __tsan_write_range(void *ptr, size_t size)
> > > +{
> > > +     __kcsan_check_access(ptr, size, true);
> > > +}
> > > +EXPORT_SYMBOL(__tsan_write_range);
> > > +
> > > +/*
> > > + * The below are not required KCSAN, but can still be emitted by the=
 compiler.
> > > + */
> > > +void __tsan_func_entry(void *call_pc)
> > > +{
> > > +}
> > > +EXPORT_SYMBOL(__tsan_func_entry);
> > > +void __tsan_func_exit(void)
> > > +{
> > > +}
> > > +EXPORT_SYMBOL(__tsan_func_exit);
> > > +void __tsan_init(void)
> > > +{
> > > +}
> > > +EXPORT_SYMBOL(__tsan_init);
> > [...]

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2ntP8ACgkQSXnow7UH
+rj4IwgAr1ZTnb6a5VMzzEFJsOsttb8ZWdPW5m/sNmxxMh6TIPZzl1rWAzFMMC7R
52lRrsSAQ+3JsII8i8lMPGPFo4Fc4g1ivQa604Zf+KjqHPtM4bBOigkNgRmFkM5r
gsrimY5mX0B4O0hg7CtV0kn3FAJKsFTE+daVXj6W0p18pshZ3HgulHPKDH7qrMnh
Hc/9JhxxvcnRAN9uUuukBr4vGHq+iDJqqGZqOuykwTufSRnGNlQk9BoGczLX+7+2
zJ+dLh8nSVw+R2tV8eVAZ+84dHfNRTFa+iBPMSW1UQ27RFR0iqY9UmwAgYmUU3YD
4F9k35sBc8/lxL1IGFblpg3dSS/4CQ==
=9czZ
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
