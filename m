Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FD8322B72
	for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852184; cv=pass; b=gItKEWnZQJe8Kxn/h6MImZ9VBMCtLb22sX758C5MPUCvMR35xJQGUTjZsaxX7bo+Hj8Dr0ONpVi1lhfWrz0CNbhtuIC1cVJIhGC0mytHbfRbtZrh+AMBuqAw8dHcel19ux81zHfXZFXWnmlm95R5C3lB+gLA5Tpb4/phSjbJUYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852184; c=relaxed/simple;
	bh=QsKVBnXqVnbEl1JYB5zmYCaayNt8OHtwYAj+1cbz5SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pG2nOl9UY2Y6zYtZFKPta8Eih1eYsyi4nU+S4Hyupuutf5KtdgUigkSzhjYT/cs25IpZVdVZGZrmgYcJjNBwWbGgiv5k2AJ7O9m9zrqy8nZttGZE71PRTrHxicNb25pnIvUb2+pR/cMRkZd4OwHvXNZqr6lUt017M24QLSpATxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKDpt1A0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQy8jYOy; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKDpt1A0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQy8jYOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778852181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vs5z+Cy+WDXZfGxnHcx3NRfvTfPi48ZmkddcmMXaAgo=;
	b=JKDpt1A0lPnT6v72qlD6FE1jPLDkbev8iEWWner9q0QJUJEL1S07b6vx6NcHgsX2pqnDj/
	FJ8feZqK8gbh6+KK0Yp2zJmaqfZCe0r6Lw+MsZjpl58ImfzaSzFoE681q0hkL9tpDKl8e5
	W8vGsRFfeUj8PNyqKwbjZBJSQv0BTog=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-VQ-3s3XANKKfsDLL-b67fQ-1; Fri, 15 May 2026 09:36:16 -0400
X-MC-Unique: VQ-3s3XANKKfsDLL-b67fQ-1
X-Mimecast-MFC-AGG-ID: VQ-3s3XANKKfsDLL-b67fQ_1778852175
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65c2a05102cso14160047d50.1
        for <linux-arch@vger.kernel.org>; Fri, 15 May 2026 06:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778852175; cv=none;
        d=google.com; s=arc-20240605;
        b=lNg7sNEQh9sCgcmZltv/7g4XfUelhdsidfuyZ+dV60uQcu8RyzZT3j+zqCXSJaReSX
         uelB+LyJGJu0oDKjM3CCh59rnD17QnuHd0hfh53XBrV4+mh1Mp4nrQkCeMCSCS/BA56i
         xnFoKu3aRzRhaUK4NI2Zdylw9ApC0fQ+Mha11P7cuE+mbvpRA0pIeMvHvtNDfVdj3wV/
         lS+RQc/DBhmQoAsF0FkALdBC24GIK/DMBTNeTV8b1F66P1mRSFrFMWgVEgZJfXg++oqL
         n66KHSu7uWDQWI7zkQQh17pgCMKtfYclcDlBR7d3ljW/UUgu5Yd6YAv2AtiTzQS6Qsj4
         Kg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vs5z+Cy+WDXZfGxnHcx3NRfvTfPi48ZmkddcmMXaAgo=;
        fh=LbOt+e20CQ9VCLcmdKgnsEUMpSuXlQOPe1BiDFbIikM=;
        b=ZpHVHAu3ahOndkoMR/+OWqZYp97l+TbPRXUL/RyBz4mEfOMlcLgbdHSxjG5le8sKmU
         EYFZSBnWhgmJ02urhot/Eb8NJf9/PWiSow8iIIh1awjXAbJ6tkVBPK1gHcADcjeNJZm6
         UB0m4Ham5XApnxnz3H3vI3837NEbgTtLn6/D4oH9nUim6kHDKgeA2awGDaHJcRusVwMT
         H0wLZrXnm0KL0MvJgjwgZyjl7TMfSrukKZBo6hl+08SMRgOsMNTSri/N3U6Ri/UMak3S
         Iu7E72PQpILSEesmd1CaU2R9yApE/6hwQwvW7yxDLTZUT6KAVCkPsxwOf/jvSPCDmfMd
         yU3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778852175; x=1779456975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs5z+Cy+WDXZfGxnHcx3NRfvTfPi48ZmkddcmMXaAgo=;
        b=jQy8jYOyWN6/tC+lsF6LL3pTIupAf7+I+E6oJOgQggrGG9bN/hPBiIpppx06C2mgG/
         SsNtSfSs+gd+k7VgKglPqQcuS0ajpuCvocSSrvizNB2ahd3G9A2pdHniok+4BWoNQ49y
         bOkregqh9IKhEoAtHBqFdfQeq9gM5ntz2pfuKS9ZJ/wHPHyfW7nYi+7BerbZH+En6d9J
         LkIjGzZqnoqPcIUczaynj75KZeW1RMlplbwhnJfxDx14cInu4b91DP5tJzc794EM+Bh4
         MHzyUlMDnbHfwfCBTHa5eXXj1i7ucYvXAAZ/aevYNEHx9Q/ghLa9LX2lfDunuf3EDORT
         crTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778852175; x=1779456975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vs5z+Cy+WDXZfGxnHcx3NRfvTfPi48ZmkddcmMXaAgo=;
        b=ER2PI4+cW/8kUF90JluA9/OFy4xLmajY+rZ+fhQNFkdjYszYngVhE8/x4LZ8vZXXWy
         CWbAdRhZsPJHw2072qy01Y6jZ/Ibwcz4RFx10ARkt7Oq3yC+VnHnyjFt9PmxvBD/h4KW
         W9IIrNy4lJgHYYqY+ZNTDvr+vrv0AklfaaQfmxyBC5hYbPAwWm/bO5IDgxWkTqWgHej9
         VJHDPuxROKP2J8S3zMRuhReQwqz95aIRDGYuRAj8fDGQ7ru1oFM8gcXEgk6pdvvl99t+
         lx9EWJZEWdKJOslkW6uokIxQFPg5aFqedIBV3F1ysiqDoMyd4ljofnWD6S5JKSwFpTVv
         vSpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VtAyubfchJPkOnGKDK3CVF9FjtXt2Wp3dEIUG7TMJz33v4cuYrbMpIE0SGxFYBt9NwISUNqv82r3P@vger.kernel.org
X-Gm-Message-State: AOJu0YxtOF3hkVTAbKwo/0pFAsrEPcloiDd19DjxdA/52QMJ21n8f0Bm
	npRnkmgnbf5dw9uIfqtuca1aUjikmiy+HNjZWDhGgvGtFwzB2RH4laJHfSnKiTcE6RWOkT6/9Tz
	dwnAW3K18XaBoiEZjae2SQN8QxUNx3G7K8cT/J1dEk+yQ2FEnxIqMTFHZaPhOqUbJCJ5VFhc+75
	G9d4NjyrrtsvvYOGRHQsBKykVIUTJu6wtS9KcDiQ==
X-Gm-Gg: Acq92OHG/0KOpvVM0cDGfmkfio04ZihV2EnpWqCQWJ9cEc/iKabRVZzESQQha+4an2O
	gzvqrUMLisn8PDee6kVK+I/Nzi/EjKrbKyQfZZmHVFWjZiaXazqG+/CJIA9sChPb6hhWXW2hwpR
	V/pfoTiFye35TwiaLGrU4f0q9t7S2x75VWicKgpSCc8UrdPtSFtfUbdhQtTBuJCOLYbNT6Myu5O
	2m1Cg==
X-Received: by 2002:a05:690c:f14:b0:7bd:8cd8:ea29 with SMTP id 00721157ae682-7c95c3f7a03mr45356867b3.45.1778852175075;
        Fri, 15 May 2026 06:36:15 -0700 (PDT)
X-Received: by 2002:a05:690c:f14:b0:7bd:8cd8:ea29 with SMTP id
 00721157ae682-7c95c3f7a03mr45356027b3.45.1778852174329; Fri, 15 May 2026
 06:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515-kunit_add_support-v13-0-18ee42f96e7b@redhat.com> <20260515-kunit_add_support-v13-1-18ee42f96e7b@redhat.com>
In-Reply-To: <20260515-kunit_add_support-v13-1-18ee42f96e7b@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 15 May 2026 15:36:00 +0200
X-Gm-Features: AVHnY4J9HVsjczy7s5GPoIaLoUR6NOQHvCxtN95w_wrV3IRoKz4puWpTmU905w8
Message-ID: <CADSE00+X=QKg7kcOvu8YCbuJT1jEEwwH+HL1wpRhbc6aea9fKw@mail.gmail.com>
Subject: Re: [PATCH v13 1/4] bug/kunit: Core support for suppressing warning backtraces
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

On Fri, May 15, 2026 at 2:29=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
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
> automatic cleanup at test exit. On cleanup, the node is removed with
> list_del_rcu() followed by synchronize_rcu() to wait for any concurrent
> RCU readers to finish. Because kunit_end_suppress_warning() (and the
> __cleanup wrapper) always runs from process context, synchronize_rcu()
> is safe. The handle memory remains valid until the test exits, so the
> suppression count can be read after the scope closes. Writer-side
> access to the global suppression list is serialized with a spinlock;
> readers use RCU. To avoid false suppression of warnings fired from
> hardware interrupt handlers (where current still points to the test
> task), the check exits early when not in task context.
>
> Two API forms are provided:
> - kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
>   automatic teardown on scope exit, kunit_add_action() as safety net
>   for abnormal exits (e.g. kthread_exit from failed assertions).
>   Suppression handle is only accessible inside the block.
> - kunit_start/end_suppress_warning(test): direct functions returning
>   an explicit handle, for retaining the handle within the test,
>   or for cross-function usage.

Let me address sashiko's comments for
https://sashiko.dev/#/patchset/20260515-kunit_add_support-v13-0-18ee42f96e7=
b%40redhat.com?part=3D1
here:

1. "Is this assumption always accurate? Tests frequently acquire
spinlocks or RCU read locks."
The assumption is accurate because kunit_end_suppress_warning() and
the __cleanup wrapper fire at the closing brace of the
kunit_warning_suppress() scope. If a developer holds a spinlock or RCU
read lock when that scope closes, their test is structurally incorrect
regardless of this API. The API documentation notes that process
context is required.

2. "If kunit_start_suppress_warning() fails and returns NULL, will
this skip the entire loop body?"
Yes, intentionally. KUNIT_FAIL() is called before returning NULL, so
the test is already marked as failed at that point. Skipping the body
of a failed test is expected KUnit behavior. In patch 3,
scaling_factor is initialized to INT_MIN precisely for this reason.

3. "Does this mean the single-fire budget is consumed anyway on
non-CONFIG_GENERIC_BUG architectures?"
Yes, true, but it should only affect non-__WARN_FLAGS architectures.
If there is demand, it can be addressed in a follow-up series. It does
not affect current API users.

4. "Would GFP_KERNEL / synchronize_rcu() cause a sleep-in-atomic bug
if used in atomic context?"
Yes, and that would be a test design error. kunit_warning_suppress()
is a KUnit test API; KUnit tests run in process context by design. As
stated in `Documentation/core-api/memory-allocation.rst`, GFP_KERNEL
implies GFP_RECLAIM, which requires the calling context to be allowed
to sleep. Using it in an atomic context is incorrect regardless of
which API calls it. `kunit_kzalloc(test, ..., GFP_KERNEL)` is the
standard allocation pattern throughout KUnit itself (e.g.,
lib/kunit/assert_test.c, platform-test.c, ...), so this API follows
the same convention.

5. "Could a child kthread's task_struct be freed and reused, causing
false suppression?"
The API is designed to be called from the test task only. w->task =3D
current stores the caller's task_struct, and the inline comment
explains the stability guarantee: the test task cannot exit before
KUnit tears down the test. The correct pattern for child kthread is
demonstrated in backtrace_suppression_test_cross_kthread: the test
task opens and closes the suppression scope; child threads only read
the suppression state. Otherwise it is an API misuse.

>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/kunit/test-bug.h |  26 ++++++++++
>  include/kunit/test.h     |  98 ++++++++++++++++++++++++++++++++++++
>  kernel/panic.c           |  11 ++++
>  lib/bug.c                |  12 ++++-
>  lib/kunit/Makefile       |   3 +-
>  lib/kunit/bug.c          | 127 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  lib/kunit/hooks-impl.h   |   2 +
>  7 files changed, 276 insertions(+), 3 deletions(-)
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
> index 224f4cfa4aa31..874cb4ae4d047 100644
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
> @@ -220,6 +219,15 @@ static enum bug_trap_type __report_bug(struct bug_en=
try *bug, unsigned long buga
>         no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
>         has_args =3D bug->flags & BUGFLAG_ARGS;
>
> +       /*
> +        * Before the once logic so suppressed warnings do not consume
> +        * the single-fire budget of WARN_ON_ONCE().
> +        */
> +       if (warning && kunit_is_suppressed_warning(true))
> +               return BUG_TRAP_TYPE_WARN;
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
> index 0000000000000..6752b497aeefe
> --- /dev/null
> +++ b/lib/kunit/bug.c
> @@ -0,0 +1,127 @@
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
> +       synchronize_rcu(); /* Wait for readers to finish */
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
> +       /*
> +        * Store current without taking a reference. The test task cannot
> +        * exit before kunit tears down the test, so the pointer is stabl=
e
> +        * for the lifetime of this handle.
> +        */
> +       w->task =3D current;
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
> +       if (!in_task())
> +               return false;
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

