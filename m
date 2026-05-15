Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAB3F7A9A
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831936; cv=pass; b=g/lWkMxOsw497ZLfDQgrmIWYRfa3UjldeCQ4yLrEoSQfLMrqSHF7hIDI4JukIO1SHUG0ZgM0oe8py32wfkbVGBkuStzxQK5aTqgqZwlEGMKAd/djAm0HcnVnGrjInhFno1vXI9U6vRhD1tv7nPLZOj0ZN3s9JmxFc8JIEwRgPpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831936; c=relaxed/simple;
	bh=RCsS+99jCloj45tXu0KNSIKblXL+S9I7Qw2LJZVqj5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFSLByetO5+NVMtrpm18+SMJweTQLvAgNzxoBqaCuQEm+sLH3DDGkweiXMLkoEkYgBFh6XSNxQIdCeH8Gi/jDpuApBHclpEgNWxTaiN51r4KhILA/MowtiONURfZ+tdlIndlAjruBssIwH7PtN3ggXHiK+3hsU5VmLORaGaA7GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5pRH1Jb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TRtmM1TO; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5pRH1Jb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRtmM1TO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778831933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9abunBSi6kKWqVAEh2nRnQ9n8glx3NIg99QVPut5WFw=;
	b=D5pRH1JbJtJjwccdHodcEpspqyjuZbuccWhdTQsZKgrIXYjqigdzlqFlhd4nl0AZmQHiiv
	deddpNbPkI6kZVh+Xoi3tR2ym/vc5x5Koaqj6TDzMM/0MYBZ6BlDbwS7dT2bjhHSoi7ozk
	zZVUHKpvvnU/Iqf/J+qu3TyviOIOznI=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-iabH-0nePG6nCe_ccfA7og-1; Fri, 15 May 2026 03:58:51 -0400
X-MC-Unique: iabH-0nePG6nCe_ccfA7og-1
X-Mimecast-MFC-AGG-ID: iabH-0nePG6nCe_ccfA7og_1778831931
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65d8659ae23so2299039d50.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 00:58:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778831931; cv=none;
        d=google.com; s=arc-20240605;
        b=Mtf7Rxj09UsD5U7wrODx3Hia92xy+YF5IyCDC0bd8dzgvCfgviLQZ3GUlLE/tLjGVg
         jwwMtmud5XA9tgw5es+gb5mDGU3gUbxqkDrh8hdqmc3GANUC0Nj3c2NrBVW69CyPx0SM
         3jhmG5rX3UuucnWXcFZWaSzE3kqCFzf6hqh/stp0tbHXJGS5ulYq8RzqLlThRYz7+NIZ
         Yd0AOfhqPfENgcrvoQTCTqkVqQzP6fMCSAdzQr/JYdq1mICqzL+bMvDW4LXuy1hXwnBH
         rZLOUUP/QfM5GV1298LbshH9W4RDSlxdJHbMZQiM5wtmrUvwXxgVwtH8fX2ZKsxsIDMP
         dY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9abunBSi6kKWqVAEh2nRnQ9n8glx3NIg99QVPut5WFw=;
        fh=MV+zuW7f+sAknPHy1xYp5yca+Nv/H6+Uxpk2z22U4Ro=;
        b=Faqv/oedXMi4pusahihMEvggYxQGCqtfWq9Zq43gves/lAk9FCFzqbpf+5U0zv6wXK
         iEJxTpGgPBN7R0+kY2ABHWxPLERvO9596VZU1u4BK3y45m9Rn+LNCcm06cgIgta0ZgJ+
         EWlLqvhL2/byIRWMPQBnaDh0NT9Bb5zu+V7L0PXbFZ7wEuZqwdn3vqMFRlh1VwduvZpq
         JtTpk/gF51LTHfcxPEqwFD8mzZX9q5+mBuuYFNC4wzoF76DKqoUlnfQiza3YFR5lWBBn
         KQZqMixRg/4otz8lTD5NQjuPUgrMvipucD1w9Feem8VUw/WUE2hsZ/m41sKIfK5TiIZ8
         KopA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778831931; x=1779436731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9abunBSi6kKWqVAEh2nRnQ9n8glx3NIg99QVPut5WFw=;
        b=TRtmM1TO7ORj+04dtyAYmyeB7OqKxq1/CSLiQ+YWcgW181NF8TlrUSjNrv0iCC/tJh
         Qtitb5+7PnuqLbEUpehurQRT98DO57IyNX9jKII11zugDeQCEti8Xa1QouKxHd/f3gLC
         g0F0fcei5e2xve3s5ZMKHbaRdE3FtPN5buKmIhjrWh+cuJCLMUVCYrMyKxnFVC0K/sis
         RJ+C+Bo6It0dgqFT7w7b2D4ccmFrg97aWbU9WZtYsb/B6xyPwsC/3ZXofuWNEuxnq86f
         gShnBjH9OLaYSkcXvv8bMsq4FqlkoJieL3cgZwpMoM4NvJ6mRtCAKPOgWnmlmxTSBiVF
         3j9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778831931; x=1779436731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9abunBSi6kKWqVAEh2nRnQ9n8glx3NIg99QVPut5WFw=;
        b=and2Vqrlm5aG/NXgYnK4Ulp5L3/qqGqqgElxNkKuLtAYYJO+TQyaV+EIptgt1uUE6C
         mff2fqi36E1+FmF2dwxd7xMYhsGGu1A41b69+JZK8hw/Pm52jUydg5pSiw3q8/fSlfE1
         2L583gYzxqzWWGIVND5MiACBP+5E9zW5jZXpiCFFWHWvxr2eW80vwxshO+dqfWZDabOi
         6fxK4rHiwpMCI0ly2rswPBTJ9pP2IhZhjbbsBEv1ch/lFxOio0paVAsU02oxHNJLlDDP
         1Yjsl32sBup9+8OvShAbi0OGuNdjqQDsa9jp6oaT2v2mtRGZVtoWx+eXlVLcagqUKVeI
         xWhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8X0N5nkdrZJeDDIq8fVZDS9XPwJjUfrGrKpOslwtLUbfiWiTK34Mr4mRXR7OyZ1yxs/vxY+oSg+LVR@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnpN3ZpeHeC6And2zqUIu3Bx3U04qsjhMmcxShZkHAEPs12v4
	Ckt/JhowNKosbafvQ3bGZojaa8KSvlHEZJCrYPMheI96mWrFJ35ZTevZPV4Jw8rMQER+u01inFa
	YFkyHm7LIuOQOQ6CfMJO+tBrYseULnZSIcG6vE0wlJGqXrp2Qj1f9qTOnPfah9YUftJGkPLq0/G
	0UlZZs9CkF+ILeRYFd/+S4c0yvzhbMsN+DO4ZXoQ==
X-Gm-Gg: Acq92OH94P2eedqMnwz5JViiWCzQukrtPwlEmDclR6Ms89dzkzvWiqkPI3UMl37py0R
	QO1szMDeXHDS1XyUes/IGx5TAU2cIRgDbuPM1+gmukcZSJ9/4Jz7zMj3pF8tuyX9hsI737KTIbg
	Sf3yRTsQtAPXLINqyGx4gE+hKEg0ujpWue4K7IfgsGJ+w0gy/PrlgAeZuPG/GrkHR7N7cswe4A2
	GqxkA==
X-Received: by 2002:a05:690c:d81:b0:7b4:6f40:639 with SMTP id 00721157ae682-7c7e7d24b12mr66309687b3.17.1778831930890;
        Fri, 15 May 2026 00:58:50 -0700 (PDT)
X-Received: by 2002:a05:690c:d81:b0:7b4:6f40:639 with SMTP id
 00721157ae682-7c7e7d24b12mr66309427b3.17.1778831930213; Fri, 15 May 2026
 00:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-kunit_add_support-v11-0-b36a530a6d8f@redhat.com> <20260514-kunit_add_support-v11-1-b36a530a6d8f@redhat.com>
In-Reply-To: <20260514-kunit_add_support-v11-1-b36a530a6d8f@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 09:58:39 +0200
X-Gm-Features: AVHnY4Jk17N99KjZWqz1ja65c_9n08dsWWvIkos7tlRHOCMPehhAq9VKq_17m1k
Message-ID: <CADSE00L3LuzrkUbuDj=TFRueeNY6cmgFgN8BsKsBdKNzW4ppiQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] bug/kunit: Core support for suppressing warning backtraces
To: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
	Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 1:07=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> From: Alessandro Carminati <acarmina@redhat.com>
>
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
>
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons:
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
>
> Solve the problem by providing a means to suppress warning backtraces
> originating from the current kthread while executing test code. Since
> each KUnit test runs in its own kthread, this effectively scopes
> suppression to the test that enabled it. Limit changes to generic code
> to the absolute minimum.
>
> Implementation details:
> Suppression is integrated into the existing KUnit hooks infrastructure
> in test-bug.h, reusing the kunit_running static branch for zero
> overhead when no tests are running.
>
> Suppression is checked at three points in the warning path:
> - In warn_slowpath_fmt(), the check runs before any output, fully
>   suppressing both message and backtrace. This covers architectures
>   without __WARN_FLAGS.
> - In __warn_printk(), the check suppresses the warning message text.
>   This covers architectures that define __WARN_FLAGS but not their own
>   __WARN_printf (arm64, loongarch, parisc, powerpc, riscv, sh), where
>   the message is printed before the trap enters __report_bug().
> - In __report_bug(), the check runs before __warn() is called,
>   suppressing the backtrace and stack dump.
>
> To avoid double-counting on architectures where both __warn_printk()
> and __report_bug() run for the same warning, kunit_is_suppressed_warning(=
)
> takes a bool parameter: true to increment the suppression counter
> (used in warn_slowpath_fmt and __report_bug), false to check only
> (used in __warn_printk).
>
> The suppression state is dynamically allocated via kunit_kzalloc() and
> tied to the KUnit test lifecycle via kunit_add_action(), ensuring
> automatic cleanup at test exit. Writer-side access to the global
> suppression list is serialized with a spinlock; readers use RCU.
>
> Two API forms are provided:
> - kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
>   automatic teardown on scope exit, kunit_add_action() as safety net
>   for abnormal exits (e.g. kthread_exit from failed assertions).
>   Suppression handle is only accessible inside the block.
> - kunit_start/end_suppress_warning(test): direct functions returning
>   an explicit handle, for retaining the handle within the test,
>   or for cross-function usage.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/kunit/test-bug.h |  26 ++++++++++
>  include/kunit/test.h     |  98 ++++++++++++++++++++++++++++++++++++++
>  kernel/panic.c           |  11 +++++
>  lib/bug.c                |  14 +++++-
>  lib/kunit/Makefile       |   3 +-
>  lib/kunit/bug.c          | 120 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  lib/kunit/hooks-impl.h   |   2 +
>  7 files changed, 271 insertions(+), 3 deletions(-)
>
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> index 47aa8f21ccce8..99869029fc686 100644
> --- a/include/kunit/test-bug.h
> +++ b/include/kunit/test-bug.h
> @@ -10,6 +10,7 @@
>  #define _KUNIT_TEST_BUG_H
>
>  #include <linux/stddef.h> /* for NULL */
> +#include <linux/types.h>  /* for bool */
>
>  #if IS_ENABLED(CONFIG_KUNIT)
>
> @@ -23,6 +24,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
>  extern struct kunit_hooks_table {
>         __printf(3, 4) void (*fail_current_test)(const char*, int, const =
char*, ...);
>         void *(*get_static_stub_address)(struct kunit *test, void *real_f=
n_addr);
> +       bool (*is_suppressed_warning)(bool count);
>  } kunit_hooks;
>
>  /**
> @@ -60,9 +62,33 @@ static inline struct kunit *kunit_get_current_test(voi=
d)
>                 }                                                        =
       \
>         } while (0)
>
> +/**
> + * kunit_is_suppressed_warning() - Check if warnings are being suppresse=
d
> + *                                 by the current KUnit test.
> + * @count: if true, increment the suppression counter on match.
> + *
> + * Returns true if the current task has active warning suppression.
> + * Uses the kunit_running static branch for zero overhead when no tests =
run.
> + *
> + * A single WARN*() may traverse multiple call sites in the warning path
> + * (e.g., __warn_printk() and __report_bug()). Pass @count =3D true at t=
he
> + * primary suppression point to count each warning exactly once, and
> + * @count =3D false at secondary points to suppress output without
> + * inflating the count.
> + */
> +static inline bool kunit_is_suppressed_warning(bool count)
> +{
> +       if (!static_branch_unlikely(&kunit_running))
> +               return false;
> +
> +       return kunit_hooks.is_suppressed_warning &&
> +              kunit_hooks.is_suppressed_warning(count);
> +}
> +
>  #else
>
>  static inline struct kunit *kunit_get_current_test(void) { return NULL; =
}
> +static inline bool kunit_is_suppressed_warning(bool count) { return fals=
e; }
>
>  #define kunit_fail_current_test(fmt, ...) do {} while (0)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9cd1594ab697d..be71612f61655 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1795,4 +1795,102 @@ do {                                             =
                              \
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
>
> +/*
> + * Warning backtrace suppression API.
> + *
> + * Suppresses WARN*() backtraces on the current task while active. Two f=
orms
> + * are provided:
> + *
> + * - Scoped: kunit_warning_suppress(test) { ... }
> + *   Suppression is active for the duration of the block. On normal exit=
,
> + *   the for-loop increment deactivates suppression. On early exit (brea=
k,
> + *   return, goto), the __cleanup attribute fires. On kthread_exit() (e.=
g.,
> + *   a failed KUnit assertion), kunit_add_action() cleans up at test
> + *   teardown. The suppression handle is only accessible inside the bloc=
k,
> + *   so warning counts must be checked before the block exits.
> + *
> + * - Direct: kunit_start_suppress_warning() / kunit_end_suppress_warning=
()
> + *   The underlying functions, returning an explicit handle pointer. Use
> + *   when the handle needs to be retained (e.g., for post-suppression
> + *   count checks) or passed across helper functions.
> + */
> +struct kunit_suppressed_warning;
> +
> +struct kunit_suppressed_warning *
> +kunit_start_suppress_warning(struct kunit *test);
> +void kunit_end_suppress_warning(struct kunit *test,
> +                               struct kunit_suppressed_warning *w);
> +int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w);
> +void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **wp)=
;
> +bool kunit_has_active_suppress_warning(void);
> +
> +/**
> + * kunit_warning_suppress() - Suppress WARN*() backtraces for the durati=
on
> + *                            of a block.
> + * @test: The test context object.
> + *
> + * Scoped form of the suppression API. Suppression starts when the block=
 is
> + * entered and ends automatically when the block exits through any path.=
 See
> + * the section comment above for the cleanup guarantees on each exit pat=
h.
> + * Fails the test if suppression is already active; nesting is not suppo=
rted.
> + *
> + * The warning count can be checked inside the block via
> + * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(). The handle is not accessible
> + * after the block exits.
> + *
> + * Example::
> + *
> + *   kunit_warning_suppress(test) {
> + *       trigger_warning();
> + *       KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> + *   }
> + */
> +#define kunit_warning_suppress(test)                                   \
> +       for (struct kunit_suppressed_warning *__kunit_suppress          \
> +            __cleanup(__kunit_suppress_auto_cleanup) =3D                =
 \
> +            kunit_start_suppress_warning(test);                        \
> +            __kunit_suppress;                                          \
> +            kunit_end_suppress_warning(test, __kunit_suppress),        \
> +            __kunit_suppress =3D NULL)
> +
> +/**
> + * KUNIT_SUPPRESSED_WARNING_COUNT() - Returns the suppressed warning cou=
nt.
> + *
> + * Returns the number of WARN*() calls suppressed since the current
> + * suppression block started, or 0 if the handle is NULL. Usable inside =
a
> + * kunit_warning_suppress() block.
> + */
> +#define KUNIT_SUPPRESSED_WARNING_COUNT() \
> +       kunit_suppressed_warning_count(__kunit_suppress)
> +
> +/**
> + * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT() - Sets an expectation that th=
e
> + *                                           suppressed warning count eq=
uals
> + *                                           @expected.
> + * @test: The test context object.
> + * @expected: an expression that evaluates to the expected warning count=
.
> + *
> + * Sets an expectation that the number of suppressed WARN*() calls equal=
s
> + * @expected. This is semantically equivalent to
> + * KUNIT_EXPECT_EQ(@test, KUNIT_SUPPRESSED_WARNING_COUNT(), @expected).
> + * See KUNIT_EXPECT_EQ() for more information.
> + */
> +#define KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected) \
> +       KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
> +
> +/**
> + * KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT() - Sets an assertion that the
> + *                                           suppressed warning count eq=
uals
> + *                                           @expected.
> + * @test: The test context object.
> + * @expected: an expression that evaluates to the expected warning count=
.
> + *
> + * Sets an assertion that the number of suppressed WARN*() calls equals
> + * @expected. This is the same as KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(=
),
> + * except it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when =
the
> + * assertion is not met.
> + */
> +#define KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT(test, expected) \
> +       KUNIT_ASSERT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
> +
>  #endif /* _KUNIT_TEST_H */
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 20feada5319d4..213725b612aa1 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -39,6 +39,7 @@
>  #include <linux/sys_info.h>
>  #include <trace/events/error_report.h>
>  #include <asm/sections.h>
> +#include <kunit/test-bug.h>
>
>  #define PANIC_TIMER_STEP 100
>  #define PANIC_BLINK_SPD 18
> @@ -1124,6 +1125,11 @@ void warn_slowpath_fmt(const char *file, int line,=
 unsigned taint,
>         bool rcu =3D warn_rcu_enter();
>         struct warn_args args;
>
> +       if (kunit_is_suppressed_warning(true)) {
> +               warn_rcu_exit(rcu);
> +               return;
> +       }
> +
>         pr_warn(CUT_HERE);
>
>         if (!fmt) {
> @@ -1146,6 +1152,11 @@ void __warn_printk(const char *fmt, ...)
>         bool rcu =3D warn_rcu_enter();
>         va_list args;
>
> +       if (kunit_is_suppressed_warning(false)) {
> +               warn_rcu_exit(rcu);
> +               return;
> +       }
> +
>         pr_warn(CUT_HERE);
>
>         va_start(args, fmt);
> diff --git a/lib/bug.c b/lib/bug.c
> index 224f4cfa4aa31..d99e369bc1103 100644
> --- a/lib/bug.c
> +++ b/lib/bug.c
> @@ -48,6 +48,7 @@
>  #include <linux/rculist.h>
>  #include <linux/ftrace.h>
>  #include <linux/context_tracking.h>
> +#include <kunit/test-bug.h>
>
>  extern struct bug_entry __start___bug_table[], __stop___bug_table[];
>
> @@ -209,8 +210,6 @@ static enum bug_trap_type __report_bug(struct bug_ent=
ry *bug, unsigned long buga
>                         return BUG_TRAP_TYPE_NONE;
>         }
>
> -       disable_trace_on_warning();
> -
>         bug_get_file_line(bug, &file, &line);
>         fmt =3D bug_get_format(bug);
>
> @@ -220,6 +219,17 @@ static enum bug_trap_type __report_bug(struct bug_en=
try *bug, unsigned long buga
>         no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
>         has_args =3D bug->flags & BUGFLAG_ARGS;
>
> +#ifdef CONFIG_KUNIT

Sashiko says:
"""
Is the CONFIG_KUNIT check sufficient here?
CONFIG_KUNIT is a tristate configuration option. When KUnit is built as a
module, the preprocessor macro CONFIG_KUNIT_MODULE is defined instead,
leaving CONFIG_KUNIT undefined.
Because lib/bug.c is compiled into the core kernel, this block will be
silently stripped out during a module build. This prevents warning
suppression from working on all architectures that rely on __report_bug().
Could this use IS_ENABLED(CONFIG_KUNIT) instead, or be dropped completely
since include/kunit/test-bug.h provides a safe stub?
"""
Ugh, it is right. I did not consider the module case. Not only is it
safe now as it says, but iirc we added it for performance, however,
since we now have static_branch, it is not really needed. I think
removing it is the right thing to do here.


> +       /*
> +        * Before the once logic so suppressed warnings do not consume
> +        * the single-fire budget of WARN_ON_ONCE().
> +        */
> +       if (warning && kunit_is_suppressed_warning(true))
> +               return BUG_TRAP_TYPE_WARN;
> +#endif
> +
> +       disable_trace_on_warning();
> +
>         if (warning && once) {
>                 if (done)
>                         return BUG_TRAP_TYPE_WARN;
> diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> index 656f1fa35abcc..4592f9d0aa8dd 100644
> --- a/lib/kunit/Makefile
> +++ b/lib/kunit/Makefile
> @@ -10,7 +10,8 @@ kunit-objs +=3D                         test.o \
>                                         executor.o \
>                                         attributes.o \
>                                         device.o \
> -                                       platform.o
> +                                       platform.o \
> +                                       bug.o
>
>  ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
>  kunit-objs +=3D                          debugfs.o
> diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> new file mode 100644
> index 0000000000000..8579235c9ca68
> --- /dev/null
> +++ b/lib/kunit/bug.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit helpers for backtrace suppression
> + *
> + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> + */
> +
> +#include <kunit/resource.h>
> +#include <linux/export.h>
> +#include <linux/rculist.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <linux/spinlock.h>
> +
> +#include "hooks-impl.h"
> +
> +struct kunit_suppressed_warning {
> +       struct list_head node;
> +       struct task_struct *task;
> +       struct kunit *test;
> +       atomic_t counter;
> +};
> +
> +static LIST_HEAD(suppressed_warnings);
> +static DEFINE_SPINLOCK(suppressed_warnings_lock);
> +
> +static void kunit_suppress_warning_remove(struct kunit_suppressed_warnin=
g *w)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&suppressed_warnings_lock, flags);
> +       list_del_rcu(&w->node);
> +       spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
> +       put_task_struct(w->task);

Sashiko says:
"""
Does this code introduce a use-after-free regression for concurrent RCU
readers?
Because the suppression handle is allocated using kunit_kzalloc() below,
the KUnit framework will automatically free it with a synchronous kfree()
at the end of the test.
Since the handle is unlinked using list_del_rcu() here, but there is no
synchronize_rcu() or kfree_rcu() between the list removal and the memory
free, a concurrent task evaluating warnings under rcu_read_lock() could
dereference the pointer after it has been freed.
Would it be safer to allocate the handle with kzalloc() and explicitly free
it using kfree_rcu() inside this cleanup action?
"""
It is taking a few iterations to get this right...
In the previous version we ruled out synchronize_rcu() because it is a
blocking call that can deadlock if exited while holding the RCU lock.
On the other hand, the suggested kfree_rcu(), only frees memory, but
we also need to release the task reference in the w struct after the
grace period. Reading
`Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst`,
a solution could be to hold an `rcu_head` in the suppressed warning
struct and invoke call_rcu directly (and explicitly free as suggested
by Sashiko, so I'd need to change kunit_kzalloc() too).
I hope that clears all races.

> +}
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(kunit_suppress_warning_cleanup,
> +                           kunit_suppress_warning_remove,
> +                           struct kunit_suppressed_warning *);
> +
> +bool kunit_has_active_suppress_warning(void)
> +{
> +       return __kunit_is_suppressed_warning_impl(false);
> +}
> +EXPORT_SYMBOL_GPL(kunit_has_active_suppress_warning);
> +
> +struct kunit_suppressed_warning *
> +kunit_start_suppress_warning(struct kunit *test)
> +{
> +       struct kunit_suppressed_warning *w;
> +       unsigned long flags;
> +       int ret;
> +
> +       if (kunit_has_active_suppress_warning()) {
> +               KUNIT_FAIL(test, "Another suppression block is already ac=
tive");
> +               return NULL;
> +       }
> +
> +       w =3D kunit_kzalloc(test, sizeof(*w), GFP_KERNEL);
> +       if (!w) {
> +               KUNIT_FAIL(test, "Failed to allocate suppression handle."=
);
> +               return NULL;
> +       }
> +
> +       w->task =3D get_task_struct(current);
> +       w->test =3D test;
> +
> +       spin_lock_irqsave(&suppressed_warnings_lock, flags);
> +       list_add_rcu(&w->node, &suppressed_warnings);
> +       spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
> +
> +       ret =3D kunit_add_action_or_reset(test,
> +                                       kunit_suppress_warning_cleanup, w=
);
> +       if (ret) {
> +               KUNIT_FAIL(test, "Failed to add suppression cleanup actio=
n.");
> +               return NULL;
> +       }
> +
> +       return w;
> +}
> +EXPORT_SYMBOL_GPL(kunit_start_suppress_warning);
> +
> +void kunit_end_suppress_warning(struct kunit *test,
> +                               struct kunit_suppressed_warning *w)
> +{
> +       if (!w)
> +               return;
> +       kunit_release_action(test, kunit_suppress_warning_cleanup, w);
> +}
> +EXPORT_SYMBOL_GPL(kunit_end_suppress_warning);
> +
> +void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **wp)
> +{
> +       if (*wp)
> +               kunit_end_suppress_warning((*wp)->test, *wp);
> +}
> +EXPORT_SYMBOL_GPL(__kunit_suppress_auto_cleanup);
> +
> +int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w)
> +{
> +       return w ? atomic_read(&w->counter) : 0;
> +}
> +EXPORT_SYMBOL_GPL(kunit_suppressed_warning_count);
> +
> +bool __kunit_is_suppressed_warning_impl(bool count)
> +{
> +       struct kunit_suppressed_warning *w;
> +
> +       guard(rcu)();
> +       list_for_each_entry_rcu(w, &suppressed_warnings, node) {
> +               if (w->task =3D=3D current) {
> +                       if (count)
> +                               atomic_inc(&w->counter);
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
> index 4e71b2d0143ba..d8720f2616925 100644
> --- a/lib/kunit/hooks-impl.h
> +++ b/lib/kunit/hooks-impl.h
> @@ -19,6 +19,7 @@ void __printf(3, 4) __kunit_fail_current_test_impl(cons=
t char *file,
>                                                    int line,
>                                                    const char *fmt, ...);
>  void *__kunit_get_static_stub_address_impl(struct kunit *test, void *rea=
l_fn_addr);
> +bool __kunit_is_suppressed_warning_impl(bool count);
>
>  /* Code to set all of the function pointers. */
>  static inline void kunit_install_hooks(void)
> @@ -26,6 +27,7 @@ static inline void kunit_install_hooks(void)
>         /* Install the KUnit hook functions. */
>         kunit_hooks.fail_current_test =3D __kunit_fail_current_test_impl;
>         kunit_hooks.get_static_stub_address =3D __kunit_get_static_stub_a=
ddress_impl;
> +       kunit_hooks.is_suppressed_warning =3D __kunit_is_suppressed_warni=
ng_impl;
>  }
>
>  #endif /* _KUNIT_HOOKS_IMPL_H */
>
> --
> 2.53.0
>

