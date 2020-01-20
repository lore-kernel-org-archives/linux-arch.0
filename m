Return-Path: <SRS0=nYHR=3J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39594 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgATOqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:46:10 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so30295419qko.6
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com>
In-Reply-To: <20200120141927.114373-1-elver@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 20 Jan 2020 15:45:57 +0100
Message-ID: <CACT4Y+bnRoKinPopVqyxj4av6_xa_OUN0wwnidpO3dX3iYq_gg@mail.gmail.com>
Subject: Re: [PATCH 1/5] include/linux: Add instrumented.h infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200120144557.mEKVaUWeeiKRQMFOFQjIjKA90QeY9L3Tr5ptPT30tgU@z>

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This adds instrumented.h, which provides generic wrappers for memory
> access instrumentation that the compiler cannot emit for various
> sanitizers. Currently this unifies KASAN and KCSAN instrumentation. In
> future this will also include KMSAN instrumentation.
>
> Note that, copy_{to,from}_user require special instrumentation,
> providing hooks before and after the access, since we may need to know
> the actual bytes accessed (currently this is relevant for KCSAN, and is
> also relevant in future for KMSAN).
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/instrumented.h | 153 +++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 include/linux/instrumented.h
>
> diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> new file mode 100644
> index 000000000000..9f83c8520223
> --- /dev/null
> +++ b/include/linux/instrumented.h
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This header provides generic wrappers for memory access instrumentation that
> + * the compiler cannot emit for: KASAN, KCSAN.
> + */
> +#ifndef _LINUX_INSTRUMENTED_H
> +#define _LINUX_INSTRUMENTED_H
> +
> +#include <linux/compiler.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +#include <linux/types.h>
> +
> +/**
> + * instrument_read - instrument regular read access
> + *
> + * Instrument a regular read access. The instrumentation should be inserted
> + * before the actual read happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */

Based on offline discussion, that's what we add for KMSAN:

> +static __always_inline void instrument_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_read(v, size);

KMSAN: nothing

> +}
> +
> +/**
> + * instrument_write - instrument regular write access
> + *
> + * Instrument a regular write access. The instrumentation should be inserted
> + * before the actual write happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_write(const volatile void *v, size_t size)
> +{
> +       kasan_check_write(v, size);
> +       kcsan_check_write(v, size);

KMSAN: nothing

> +}
> +
> +/**
> + * instrument_atomic_read - instrument atomic read access
> + *
> + * Instrument an atomic read access. The instrumentation should be inserted
> + * before the actual read happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
> +{
> +       kasan_check_read(v, size);
> +       kcsan_check_atomic_read(v, size);

KMSAN: nothing

> +}
> +
> +/**
> + * instrument_atomic_write - instrument atomic write access
> + *
> + * Instrument an atomic write access. The instrumentation should be inserted
> + * before the actual write happens.
> + *
> + * @ptr address of access
> + * @size size of access
> + */
> +static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
> +{
> +       kasan_check_write(v, size);
> +       kcsan_check_atomic_write(v, size);

KMSAN: nothing

> +}
> +
> +/**
> + * instrument_copy_to_user_pre - instrument reads of copy_to_user
> + *
> + * Instrument reads from kernel memory, that are due to copy_to_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted before the accesses. At this point the
> + * actual number of bytes accessed is not yet known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + */
> +static __always_inline void
> +instrument_copy_to_user_pre(const volatile void *src, size_t size)
> +{
> +       /* Check before, to warn before potential memory corruption. */
> +       kasan_check_read(src, size);

KMSAN: check that (src,size) is initialized

> +}
> +
> +/**
> + * instrument_copy_to_user_post - instrument reads of copy_to_user
> + *
> + * Instrument reads from kernel memory, that are due to copy_to_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted after the accesses. At this point the
> + * actual number of bytes accessed should be known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + * @left number of bytes left that were not copied
> + */
> +static __always_inline void
> +instrument_copy_to_user_post(const volatile void *src, size_t size, size_t left)
> +{
> +       /* Check after, to avoid false positive if memory was not accessed. */
> +       kcsan_check_read(src, size - left);

KMSAN: nothing

> +}
> +
> +/**
> + * instrument_copy_from_user_pre - instrument writes of copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted before the accesses. At this point the
> + * actual number of bytes accessed is not yet known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + */
> +static __always_inline void
> +instrument_copy_from_user_pre(const volatile void *dst, size_t size)
> +{
> +       /* Check before, to warn before potential memory corruption. */
> +       kasan_check_write(dst, size);

KMSAN: nothing

> +}
> +
> +/**
> + * instrument_copy_from_user_post - instrument writes of copy_from_user
> + *
> + * Instrument writes to kernel memory, that are due to copy_from_user (and
> + * variants).
> + *
> + * The instrumentation must be inserted after the accesses. At this point the
> + * actual number of bytes accessed should be known.
> + *
> + * @dst destination address
> + * @size maximum access size
> + * @left number of bytes left that were not copied
> + */
> +static __always_inline void
> +instrument_copy_from_user_post(const volatile void *dst, size_t size, size_t left)
> +{
> +       /* Check after, to avoid false positive if memory was not accessed. */
> +       kcsan_check_write(dst, size - left);

KMSAN: mark (dst, size-left) as initialized

> +}
> +
> +#endif /* _LINUX_INSTRUMENTED_H */
> --
> 2.25.0.341.g760bfbb309-goog
>
