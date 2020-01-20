Return-Path: <SRS0=nYHR=3J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42667 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATOwC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jan 2020 09:52:02 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so30304185qkg.9
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 06:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20200120141927.114373-1-elver@google.com> <20200120141927.114373-5-elver@google.com>
In-Reply-To: <20200120141927.114373-5-elver@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 20 Jan 2020 15:51:48 +0100
Message-ID: <CACT4Y+bUvoePVPV+BqU-cwhF6bR41_eaYkr9WLLMYi-2q11JjQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] copy_to_user, copy_from_user: Use generic instrumented.h
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev <kasan-dev@googlegroups.com>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Axtens <dja@axtens.net>, Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Daniel Borkmann <daniel@iogearbox.net>, cyphar@cyphar.com, Kees Cook <keescook@chromium.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20200120145148.0TqPTqRjMyezX6UNxbYi5KbCnp_YRcr-V2HWRFRvdW4@z>

On Mon, Jan 20, 2020 at 3:19 PM Marco Elver <elver@google.com> wrote:
>
> This replaces the KASAN instrumentation with generic instrumentation,
> implicitly adding KCSAN instrumentation support.
>
> For KASAN no functional change is intended.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/uaccess.h | 46 +++++++++++++++++++++++++++++------------
>  lib/usercopy.c          | 14 ++++++++-----
>  2 files changed, 42 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67f016010aad..d3f2d9a8cae3 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -2,9 +2,9 @@
>  #ifndef __LINUX_UACCESS_H__
>  #define __LINUX_UACCESS_H__
>
> +#include <linux/instrumented.h>
>  #include <linux/sched.h>
>  #include <linux/thread_info.h>
> -#include <linux/kasan-checks.h>
>
>  #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
>
> @@ -58,18 +58,26 @@
>  static __always_inline __must_check unsigned long
>  __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
>  {
> -       kasan_check_write(to, n);
> +       unsigned long res;
> +
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_pre(to, n);
> +       res = raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_post(to, n, res);
> +       return res;
>  }

There is also something called strncpy_from_user() that has kasan
instrumentation now:
https://elixir.bootlin.com/linux/v5.5-rc6/source/lib/strncpy_from_user.c#L117

>  static __always_inline __must_check unsigned long
>  __copy_from_user(void *to, const void __user *from, unsigned long n)
>  {
> +       unsigned long res;
> +
>         might_fault();
> -       kasan_check_write(to, n);
>         check_object_size(to, n, false);
> -       return raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_pre(to, n);
> +       res = raw_copy_from_user(to, from, n);
> +       instrument_copy_from_user_post(to, n, res);
> +       return res;
>  }
>
>  /**
> @@ -88,18 +96,26 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
>  static __always_inline __must_check unsigned long
>  __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
>  {
> -       kasan_check_read(from, n);
> +       unsigned long res;
> +
>         check_object_size(from, n, true);
> -       return raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_pre(from, n);
> +       res = raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_post(from, n, res);
> +       return res;
>  }
>
>  static __always_inline __must_check unsigned long
>  __copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       unsigned long res;
> +
>         might_fault();
> -       kasan_check_read(from, n);
>         check_object_size(from, n, true);
> -       return raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_pre(from, n);
> +       res = raw_copy_to_user(to, from, n);
> +       instrument_copy_to_user_post(from, n, res);
> +       return res;
>  }
>
>  #ifdef INLINE_COPY_FROM_USER
> @@ -109,8 +125,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
>         unsigned long res = n;
>         might_fault();
>         if (likely(access_ok(from, n))) {
> -               kasan_check_write(to, n);
> +               instrument_copy_from_user_pre(to, n);
>                 res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_post(to, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> @@ -125,12 +142,15 @@ _copy_from_user(void *, const void __user *, unsigned long);
>  static inline __must_check unsigned long
>  _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       unsigned long res = n;
> +
>         might_fault();
>         if (access_ok(to, n)) {
> -               kasan_check_read(from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_pre(from, n);
> +               res = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_post(from, n, res);
>         }
> -       return n;
> +       return res;
>  }
>  #else
>  extern __must_check unsigned long
> diff --git a/lib/usercopy.c b/lib/usercopy.c
> index cbb4d9ec00f2..1c20d4423b86 100644
> --- a/lib/usercopy.c
> +++ b/lib/usercopy.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/uaccess.h>
>  #include <linux/bitops.h>
> +#include <linux/instrumented.h>
> +#include <linux/uaccess.h>
>
>  /* out-of-line parts */
>
> @@ -10,8 +11,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
>         unsigned long res = n;
>         might_fault();
>         if (likely(access_ok(from, n))) {
> -               kasan_check_write(to, n);
> +               instrument_copy_from_user_pre(to, n);
>                 res = raw_copy_from_user(to, from, n);
> +               instrument_copy_from_user_post(to, n, res);
>         }
>         if (unlikely(res))
>                 memset(to + (n - res), 0, res);
> @@ -23,12 +25,14 @@ EXPORT_SYMBOL(_copy_from_user);
>  #ifndef INLINE_COPY_TO_USER
>  unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
>  {
> +       unsigned long res = n;
>         might_fault();
>         if (likely(access_ok(to, n))) {
> -               kasan_check_read(from, n);
> -               n = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_pre(from, n);
> +               res = raw_copy_to_user(to, from, n);
> +               instrument_copy_to_user_post(from, n, res);
>         }
> -       return n;
> +       return res;
>  }
>  EXPORT_SYMBOL(_copy_to_user);
>  #endif
> --
> 2.25.0.341.g760bfbb309-goog
>
