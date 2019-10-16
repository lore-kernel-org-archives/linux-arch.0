Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42024 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJPJmr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 05:42:47 -0400
Date: Wed, 16 Oct 2019 17:42:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
Message-ID: <20191016094234.GB2701514@tardis>
References: <20191016083959.186860-1-elver@google.com>
 <20191016083959.186860-2-elver@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20191016083959.186860-2-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191016094234.Z_IwTn7w2E0dYTwauif7LnTlvTYyGqpVbVHSnfR3Fls@z>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marco,

On Wed, Oct 16, 2019 at 10:39:52AM +0200, Marco Elver wrote:
[...]
> --- /dev/null
> +++ b/kernel/kcsan/kcsan.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
> + * see Documentation/dev-tools/kcsan.rst.
> + */
> +
> +#include <linux/export.h>
> +
> +#include "kcsan.h"
> +
> +/*
> + * Concurrency Sanitizer uses the same instrumentation as Thread Sanitizer.

Is there any documentation on the instrumentation? Like a complete list
for all instrumentation functions plus a description of where the
compiler will use those functions. Yes, the names of the below functions
are straightforward, but an accurate doc on the instrumentation will
cerntainly help people review KCSAN.

Regards,
Boqun

> + */
> +
> +#define DEFINE_TSAN_READ_WRITE(size)                                           \
> +	void __tsan_read##size(void *ptr)                                      \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, false);                        \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_read##size);                                      \
> +	void __tsan_write##size(void *ptr)                                     \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, true);                         \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_write##size)
> +
> +DEFINE_TSAN_READ_WRITE(1);
> +DEFINE_TSAN_READ_WRITE(2);
> +DEFINE_TSAN_READ_WRITE(4);
> +DEFINE_TSAN_READ_WRITE(8);
> +DEFINE_TSAN_READ_WRITE(16);
> +
> +/*
> + * Not all supported compiler versions distinguish aligned/unaligned accesses,
> + * but e.g. recent versions of Clang do.
> + */
> +#define DEFINE_TSAN_UNALIGNED_READ_WRITE(size)                                 \
> +	void __tsan_unaligned_read##size(void *ptr)                            \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, false);                        \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
> +	void __tsan_unaligned_write##size(void *ptr)                           \
> +	{                                                                      \
> +		__kcsan_check_access(ptr, size, true);                         \
> +	}                                                                      \
> +	EXPORT_SYMBOL(__tsan_unaligned_write##size)
> +
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(2);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(4);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(8);
> +DEFINE_TSAN_UNALIGNED_READ_WRITE(16);
> +
> +void __tsan_read_range(void *ptr, size_t size)
> +{
> +	__kcsan_check_access(ptr, size, false);
> +}
> +EXPORT_SYMBOL(__tsan_read_range);
> +
> +void __tsan_write_range(void *ptr, size_t size)
> +{
> +	__kcsan_check_access(ptr, size, true);
> +}
> +EXPORT_SYMBOL(__tsan_write_range);
> +
> +/*
> + * The below are not required KCSAN, but can still be emitted by the compiler.
> + */
> +void __tsan_func_entry(void *call_pc)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_func_entry);
> +void __tsan_func_exit(void)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_func_exit);
> +void __tsan_init(void)
> +{
> +}
> +EXPORT_SYMBOL(__tsan_init);
[...]

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2m5gMACgkQSXnow7UH
+rjJegf/Rrq3dKwfP4Vyd25nX8MIlEeiMrDXyxhCS2tQFw7EfcgilRD8INFnob38
H/FZ9xR3ndkcpXmoq64gGCN+dEULY78jI7Zg1fpnvUcoVI+q7Hc43PWERvU3otLo
c65FZXO36WKdEg0PJ//SWfSgwQBDfUdjmJ+17YBUd/78SleSsDk9PQNm+A6yb+u5
5jsmrV1uo7vDA+B7/n8Pn06Zu8Uwi0qZn9aWQzoGwmAFrwaF7KRbvWX86p2SMr6k
Tqi7Rpp0uoJDTBFyZg3Dmnizqh81BsHEEQtI3Yjh6bKUpGdre0tyMNUVRYHpQaYX
oVHK6bV3bKlerxpvUT/SE2yOUOBGtw==
=zQTb
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
