Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC04374745
	for <linux-arch@vger.kernel.org>; Fri,  8 May 2026 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778223141; cv=pass; b=sh82wLvuO7jT23Kx8Y6/BF9D1OpG1+WlBGfd5nPSz5zQd4YPOiNmxoVknKt94oKhrEonBmqlmGPFEb1TL2e/ZcpEGeL0XszGDqxKDRVbkNt2wmCPJkTrSxPbS4rYLX5bR5yXp9cftBMxPyJTE2sVjQ7Vx3vsVdIv0YG+GnppBzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778223141; c=relaxed/simple;
	bh=oUUcLG8RBWhqsP3nvXj/e/2jsC+HkZvybphhQvcZ+dY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJGTXBIPT9WTBon3QH/lGaIiQFs0RVP2PAEHClojU0gQyy32/yVP2LdBSHL6HwF0pAeTbK6WD5CNJ3QCMl4/L169i2DLwJEaYdas6X/OetNZwDTElmrvhPD6G3FutFPk2wrA1KVXNlWi59J1o4LwiFS2wUdrDe15XGY4i1qYWdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5/U83it; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtGGAxDZ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5/U83it";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtGGAxDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778223135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fY/UZO8qiQOWg5SWfBzXdF2X2Rl1DNNHRPCYWLtBI8=;
	b=G5/U83itOv8n6OZk9G35DSmf4hHn9lc4zSVd2l6koDpb5G0kXcfLRLspSXRSScu2tm4X88
	nHxEj9S5HMowGxXEl+ZoZIerAfPczJGWdBueyhYwNPipHYsOeZEGa+yKc1XoI72frQyFTZ
	+Gw7x1Nsdq66Idc+x3h+x3zXpKrxKe0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-UXRk0vzoMim2W74YRFOeUw-1; Fri, 08 May 2026 02:52:14 -0400
X-MC-Unique: UXRk0vzoMim2W74YRFOeUw-1
X-Mimecast-MFC-AGG-ID: UXRk0vzoMim2W74YRFOeUw_1778223133
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd5c267082so30403597b3.0
        for <linux-arch@vger.kernel.org>; Thu, 07 May 2026 23:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778223133; cv=none;
        d=google.com; s=arc-20240605;
        b=f+4eH/l4CZwRTdUuAqr8w+L39lAHiq5iyP3GPuxARX0H5TPPARH/0fUsS4Gey9EWuF
         ry2qiQaOdoOZ5gckDRp+iH4aVwsyrabDFF3wmMhNf56sxnYGDkS2YIAHSiBRN0vT8Ggf
         qqEgqkgQtP2y4MhzUiIhvKpaGz2hSVAW03aO7AJSHvPr6g+5jIfH8yJ9F3hwIjsWVzrw
         yT9GBgP2fgClJkC9AS51oFAPzRMlpJ37rMLaIBBDZwJpXCtxVuMk1GGXE5zx2qGzgKfv
         09h48he1mf1vTXweWGMdHLGsIBclsSHQojfgcNqOHbhbkMLgzTwzg/CD9MWJlAqFMQbe
         IqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9fY/UZO8qiQOWg5SWfBzXdF2X2Rl1DNNHRPCYWLtBI8=;
        fh=wNZ+svLb2LV604LAjRSsMAOX2cxA9uQzux13xRfOLKk=;
        b=gqTcMoC5KWg5/PwdjddtIAvJQKVczws0+mnwM7jeklPDnxobkHb7kThIo0oFjKiU/2
         z5BsuDpsUeRZOQUF8jtWs4l0wPV9hfbU+aAvmhf/anwYg+LAFlK7DDc2b7IVbOzy8aXc
         aovAHCIPJtf2z2aCaooOP8hKB8O/ZxvVILhQSVuCu1DD8DVpCTptz6S8iQ1bUXoHZ4j3
         7fDHCNSjwkD5BSrAV9VxCFUkeFxL5xq8dSE/3rwiSRP6zLmGE18EHy52XFZsxokc28p5
         Zf8XsR6NuzYggowCn1OJ4qIq7uLHd9ZsjWUWaoT0be+FB3fi1R+WKYD0PeN6rhsAYY7y
         xI2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778223133; x=1778827933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fY/UZO8qiQOWg5SWfBzXdF2X2Rl1DNNHRPCYWLtBI8=;
        b=TtGGAxDZEg4txLNgdiLCkUzJN/f9MNev6QSFLrcPYntth27eUg1gbAnlyMo0divyAQ
         HeAfw5NUh4hkKnWb6JGL1SfaMOuh8z3heYgMtWqVZKUsQmFkLuz+FM4MbOqm54HcVxRs
         M3m0Jw9AVTtDBc+JE4OjioYDNPLScyjPFG93eOQca7LN7irz+i/t9nHRMlj4I6bCgchx
         7ah+oU18u5ssIJrhw/vv4ClFBW5u18FkbGsRPDH+57DOR3T8A8dsbSJFEFYH1HmPc2f4
         hxZ8g6c4/mKSNiTSmYexBmoS7vgxYr3s/ulk9A1dgw9s+47DE3pbqCIjB+bm4n6aLcVF
         AHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778223133; x=1778827933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9fY/UZO8qiQOWg5SWfBzXdF2X2Rl1DNNHRPCYWLtBI8=;
        b=lBvK2IpkkIhJPZIxHy2Jd8kidVdoKEEdk1K6AGNQk13KZg4ZwJ46bdnpt8+nJybR47
         +62o4rPW4GgVPaUxQzJMzVfXbC//gKWS4KzSr0VaAwHW1CaN3RTKmZVgUI1NNR/RMQ6m
         8lfx+E8+FLdV4xMt3ySHHW9gneptMIduAv64aL7QcDdhiJ0VH1wVEIy0Pn7caAbutS5q
         Vjo9Os+DAnzr8GIdgabvIsZCccESDtDJEjETRL29qj6K/MSULsIvQ2Wq2+HKv8atrVUL
         8aVx5ioHoQEimcYFNBVCHi9pZkUQaEXxlbNzMukA+bfSQAbIDEan2RH/137Xw0Z4GcRu
         QPtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5obc0jk/2Id5aO5qZQbBd5r7aXiX36K3TmWJxP8VwcP6s/Vaz6tu72UpzXswoFlvNiO72S52DJv/D@vger.kernel.org
X-Gm-Message-State: AOJu0YysI8tqnaBixnUEmWyOuVIuw+fu1qZGqex9zf2MDVYEWU3Mh4S1
	SxsbmTCQYY+pL+wiI49sc4zg5EVivbyGYZnHWkJ/C5D9FyOiqdn4qmNDF56FlKMKeKNpqCN/Lpa
	RWzZj2cKq0CIkMDOZ9q6JPcPjh6fU512ZUwDjJv8UZGqwtdFIEs9TLhTNwALjpDCweA5i6un/2w
	Nd2Oj2mZ66jkzdgbWerEBEjzTET5dVnW7yCJGdHQ==
X-Gm-Gg: Acq92OGP+avXYEv2e0rm6JUgA7SFQjRIjuLpozWkZxc0GCky3XOCAOh6IHyBToa/zvA
	gK4ghSKwT5Lloi0buS/y0fdqBsGMuYXMGZgB/ybC/mtMpduGW65wxv2LQj+AL76Xw2ZsBAapaXz
	EUbbF21zl0GWGnxboIZnrJn64sKNHw9CJdh+pw55RGleTTVYr9Jz2hS2sgGRcj3HK9aRvrbD9ee
	ZR3mg==
X-Received: by 2002:a05:690c:389:b0:7a4:80ce:8275 with SMTP id 00721157ae682-7bdf5eb925emr115870757b3.35.1778223133180;
        Thu, 07 May 2026 23:52:13 -0700 (PDT)
X-Received: by 2002:a05:690c:389:b0:7a4:80ce:8275 with SMTP id
 00721157ae682-7bdf5eb925emr115870487b3.35.1778223132602; Thu, 07 May 2026
 23:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-1-3e5957cdd235@redhat.com> <c5c28f16-3940-4960-84e6-33f5479a5450@davidgow.net>
 <CADSE00KLhyUpRD031-YveOv+o71jJ-NojX6VteSyF+SqxG0n4g@mail.gmail.com>
In-Reply-To: <CADSE00KLhyUpRD031-YveOv+o71jJ-NojX6VteSyF+SqxG0n4g@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 8 May 2026 08:52:01 +0200
X-Gm-Features: AVHnY4J-w_smt4NdJgep3bSQTcgic6-xJhW_Zr-7uK_aZEXtV2FzlbXhyyMnoX0
Message-ID: <CADSE00L5OCSNH_XsUHSvi_wAwZWiC2=bUGmiXVAu-LZ=XtvDjQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] bug/kunit: Core support for suppressing warning backtraces
To: David Gow <david@davidgow.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	peterz@infradead.org, Alessandro Carminati <acarmina@redhat.com>, 
	Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 12:11=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Wed, May 6, 2026 at 11:40=E2=80=AFAM David Gow <david@davidgow.net> wr=
ote:
> >
> > Le 04/05/2026 =C3=A0 3:41 PM, Albert Esteve a =C3=A9crit :
> > > From: Alessandro Carminati <acarmina@redhat.com>
> > >
> > > Some unit tests intentionally trigger warning backtraces by passing b=
ad
> > > parameters to kernel API functions. Such unit tests typically check t=
he
> > > return value from such calls, not the existence of the warning backtr=
ace.
> > >
> > > Such intentionally generated warning backtraces are neither desirable
> > > nor useful for a number of reasons:
> > > - They can result in overlooked real problems.
> > > - A warning that suddenly starts to show up in unit tests needs to be
> > >    investigated and has to be marked to be ignored, for example by
> > >    adjusting filter scripts. Such filters are ad hoc because there is
> > >    no real standard format for warnings. On top of that, such filter
> > >    scripts would require constant maintenance.
> > >
> > > Solve the problem by providing a means to suppress warning backtraces
> > > originating from the current kthread while executing test code. Since
> > > each KUnit test runs in its own kthread, this effectively scopes
> > > suppression to the test that enabled it. Limit changes to generic cod=
e
> > > to the absolute minimum.
> > >
> > > Implementation details:
> > > Suppression is integrated into the existing KUnit hooks infrastructur=
e
> > > in test-bug.h, reusing the kunit_running static branch for zero
> > > overhead when no tests are running.
> > >
> > > Suppression is checked at three points in the warning path:
> > > - In warn_slowpath_fmt(), the check runs before any output, fully
> > >    suppressing both message and backtrace. This covers architectures
> > >    without __WARN_FLAGS.
> > > - In __warn_printk(), the check suppresses the warning message text.
> > >    This covers architectures that define __WARN_FLAGS but not their o=
wn
> > >    __WARN_printf (arm64, loongarch, parisc, powerpc, riscv, sh), wher=
e
> > >    the message is printed before the trap enters __report_bug().
> > > - In __report_bug(), the check runs before __warn() is called,
> > >    suppressing the backtrace and stack dump.
> > >
> > > To avoid double-counting on architectures where both __warn_printk()
> > > and __report_bug() run for the same warning, kunit_is_suppressed_warn=
ing()
> > > takes a bool parameter: true to increment the suppression counter
> > > (used in warn_slowpath_fmt and __report_bug), false to check only
> > > (used in __warn_printk).
> > >
> > > The suppression state is dynamically allocated via kunit_kzalloc() an=
d
> > > tied to the KUnit test lifecycle via kunit_add_action(), ensuring
> > > automatic cleanup at test exit. Writer-side access to the global
> > > suppression list is serialized with a spinlock; readers use RCU.
> > >
> > > Three API forms are provided:
> > > - kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
> > >    automatic teardown on scope exit, kunit_add_action() as safety net
> > >    for abnormal exits (e.g. kthread_exit from failed assertions).
> > >    Suppression handle is only accessible inside the block.
> > > - KUNIT_START/END_SUPPRESSED_WARNING(test): manual macros for larger
> > >    blocks or when warning counts need to be checked after suppression
> > >    ends. Limited to one pair per scope.
> > > - kunit_start/end_suppress_warning(test): direct functions returning
> > >    an explicit handle, for retaining the handle within the test,
> > >    or for cross-function usage.
> > >
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > > Reviewed-by: Kees Cook <kees@kernel.org>
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> >
> > This looks pretty good to me, thanks.
> >
> > Reviewed-by: David Gow <david@davidgow.net>
> >
> > It's maybe slightly over-the-top to now have three different ways of
> > enabling warning suppression: I'd probably personally get rid of
> > KUNIT_START/END_SUPPRESSED_WARNING() if we had to lose one. But if
> > there's a real reason to prefer keeping all three, it's not actually a
> > problem to do so.
>
> Thanks for the review!
>
> I think the three forms earn their keep: the scoped form is the go-to
> for most cases, but the macros avoid indentation without requiring
> users to manage a raw pointer. I initially removed the macros and
> added them back later. Direct calls to the functions will be less
> frequent, used only when you need the handle.
>
> That said, if it becomes a maintenance burden, the macros are the
> easiest to drop since they're thin wrappers. Let me know if you prefer
> them to be dropped, and I will send a v9 with that and the
> `KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT` additions to the drm test
> patch.
>
> BR,
> Albert.
>
> >
> > Regardless, this series is looking pretty ready to me. Let me know if
> > you're planning a v9, otherwise we'll take this when you're ready.

I have been thinking, and despite my last response arguing against it,
I think I will send that v9 and remove
KUNIT_START/END_SUPPRESSED_WARNING(). Since the scoped approach with a
reduced extent should be the default style for most cases, the direct
calls can cover any other use cases without needing macros. Plus,
since macros set the handler name for you, it seems odd not to be able
to use them more than once per test.

I hope that's ok. After that I think it should be ready (at least from my s=
ide).

BR,
Albert

> >
> > Cheers,
> > -- David
> >
> > >   include/kunit/test-bug.h |  25 +++++++++
> > >   include/kunit/test.h     | 138 ++++++++++++++++++++++++++++++++++++=
+++++++++++
> > >   kernel/panic.c           |  15 +++++-
> > >   lib/bug.c                |  10 ++++
> > >   lib/kunit/Makefile       |   3 +-
> > >   lib/kunit/bug.c          | 115 ++++++++++++++++++++++++++++++++++++=
+++
> > >   lib/kunit/hooks-impl.h   |   2 +
> > >   7 files changed, 305 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > > index 47aa8f21ccce8..6237e48ceadfd 100644
> > > --- a/include/kunit/test-bug.h
> > > +++ b/include/kunit/test-bug.h
> > > @@ -23,6 +23,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
> > >   extern struct kunit_hooks_table {
> > >       __printf(3, 4) void (*fail_current_test)(const char*, int, cons=
t char*, ...);
> > >       void *(*get_static_stub_address)(struct kunit *test, void *real=
_fn_addr);
> > > +     bool (*is_suppressed_warning)(bool count);
> > >   } kunit_hooks;
> > >
> > >   /**
> > > @@ -60,9 +61,33 @@ static inline struct kunit *kunit_get_current_test=
(void)
> > >               }                                                      =
         \
> > >       } while (0)
> > >
> > > +/**
> > > + * kunit_is_suppressed_warning() - Check if warnings are being suppr=
essed
> > > + *                                 by the current KUnit test.
> > > + * @count: if true, increment the suppression counter on match.
> > > + *
> > > + * Returns true if the current task has active warning suppression.
> > > + * Uses the kunit_running static branch for zero overhead when no te=
sts run.
> > > + *
> > > + * A single WARN*() may traverse multiple call sites in the warning =
path
> > > + * (e.g., __warn_printk() and __report_bug()). Pass @count =3D true =
at the
> > > + * primary suppression point to count each warning exactly once, and
> > > + * @count =3D false at secondary points to suppress output without
> > > + * inflating the count.
> > > + */
> > > +static inline bool kunit_is_suppressed_warning(bool count)
> > > +{
> > > +     if (!static_branch_unlikely(&kunit_running))
> > > +             return false;
> > > +
> > > +     return kunit_hooks.is_suppressed_warning &&
> > > +            kunit_hooks.is_suppressed_warning(count);
> > > +}
> > > +
> > >   #else
> > >
> > >   static inline struct kunit *kunit_get_current_test(void) { return N=
ULL; }
> > > +static inline bool kunit_is_suppressed_warning(bool count) { return =
false; }
> > >
> > >   #define kunit_fail_current_test(fmt, ...) do {} while (0)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index 9cd1594ab697d..f278ec028019c 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -1795,4 +1795,142 @@ do {                                         =
                                \
> > >   // include resource.h themselves if they need it.
> > >   #include <kunit/resource.h>
> > >
> > > +/*
> > > + * Warning backtrace suppression API.
> > > + *
> > > + * Suppresses WARN*() backtraces on the current task while active. T=
hree forms
> > > + * are provided, in order of convenience:
> > > + *
> > > + * - Scoped: kunit_warning_suppress(test) { ... }
> > > + *   Suppression is active for the duration of the block. On normal =
exit,
> > > + *   the for-loop increment deactivates suppression. On early exit (=
break,
> > > + *   return, goto), the __cleanup attribute fires. On kthread_exit()=
 (e.g.,
> > > + *   a failed KUnit assertion), kunit_add_action() cleans up at test
> > > + *   teardown. The suppression handle is only accessible inside the =
block,
> > > + *   so warning counts must be checked before the block exits.
> > > + *
> > > + * - Manual macros: KUNIT_[START|END]_SUPPRESSED_WARNING(test)
> > > + *   Suppression spans an explicit range in the same scope. kunit_ad=
d_action()
> > > + *   guarantees cleanup even if KUNIT_END_SUPPRESSED_WARNING() is no=
t reached.
> > > + *   Prefer this form when suppressing warnings across a large block=
 where
> > > + *   extra indentation is undesirable, or when the warning count nee=
ds to be
> > > + *   checked after suppression ends. Limited to one pair per scope.
> > > + *
> > > + * - Direct: kunit_start_suppress_warning() / kunit_end_suppress_war=
ning()
> > > + *   The underlying functions, returning an explicit handle pointer.=
 Use
> > > + *   when the handle needs to be retained (e.g., for post-suppressio=
n
> > > + *   count checks) or passed across helper functions.
> > > + */
> > > +struct kunit_suppressed_warning;
> > > +
> > > +struct kunit_suppressed_warning *
> > > +kunit_start_suppress_warning(struct kunit *test);
> > > +void kunit_end_suppress_warning(struct kunit *test,
> > > +                             struct kunit_suppressed_warning *w);
> > > +int kunit_suppressed_warning_count(struct kunit_suppressed_warning *=
w);
> > > +void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning *=
*wp);
> > > +bool kunit_has_active_suppress_warning(void);
> > > +
> > > +/**
> > > + * kunit_warning_suppress() - Suppress WARN*() backtraces for the du=
ration
> > > + *                            of a block.
> > > + * @test: The test context object.
> > > + *
> > > + * Scoped form of the suppression API. Suppression starts when the b=
lock is
> > > + * entered and ends automatically when the block exits through any p=
ath. See
> > > + * the section comment above for the cleanup guarantees on each exit=
 path.
> > > + * Fails the test if suppression is already active; nesting is not s=
upported.
> > > + *
> > > + * The warning count can be checked inside the block via
> > > + * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(). The handle is not access=
ible
> > > + * after the block exits.
> > > + *
> > > + * Example::
> > > + *
> > > + *   kunit_warning_suppress(test) {
> > > + *       trigger_warning();
> > > + *       KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> > > + *   }
> > > + */
> > > +#define kunit_warning_suppress(test)                                =
 \
> > > +     for (struct kunit_suppressed_warning *__kunit_suppress         =
 \
> > > +          __cleanup(__kunit_suppress_auto_cleanup) =3D              =
   \
> > > +          kunit_start_suppress_warning(test);                       =
 \
> > > +          __kunit_suppress;                                         =
 \
> > > +          kunit_end_suppress_warning(test, __kunit_suppress),       =
 \
> > > +          __kunit_suppress =3D NULL)
> > > +
> > > +/**
> > > + * KUNIT_START_SUPPRESSED_WARNING() - Begin suppressing WARN*() back=
traces.
> > > + * @test: The test context object.
> > > + *
> > > + * Manual form of the suppression API. Must be paired with
> > > + * KUNIT_END_SUPPRESSED_WARNING() in the same scope. See the section=
 comment
> > > + * above for cleanup guarantees. Fails the test if suppression is al=
ready
> > > + * active; nesting is not supported. Limited to one pair per scope; =
use
> > > + * sequential kunit_warning_suppress() blocks or the direct function=
 API
> > > + * when more than one suppression region is needed.
> > > + *
> > > + * Example::
> > > + *
> > > + *   KUNIT_START_SUPPRESSED_WARNING(test);
> > > + *   trigger_code_that_should_warn_once();
> > > + *   KUNIT_END_SUPPRESSED_WARNING(test);
> > > + *   KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> > > + */
> > > +#define KUNIT_START_SUPPRESSED_WARNING(test)                        =
 \
> > > +     struct kunit_suppressed_warning *__kunit_suppress =3D          =
   \
> > > +             kunit_start_suppress_warning(test)
> > > +
> > > +/**
> > > + * KUNIT_END_SUPPRESSED_WARNING() - End suppressing WARN*() backtrac=
es.
> > > + * @test: The test context object.
> > > + *
> > > + * Deactivates suppression started by KUNIT_START_SUPPRESSED_WARNING=
().
> > > + * The warning count remains readable via KUNIT_SUPPRESSED_WARNING_C=
OUNT()
> > > + * after this call.
> > > + */
> > > +#define KUNIT_END_SUPPRESSED_WARNING(test)                          =
 \
> > > +     kunit_end_suppress_warning(test, __kunit_suppress)
> > > +
> > > +/**
> > > + * KUNIT_SUPPRESSED_WARNING_COUNT() - Returns the suppressed warning=
 count.
> > > + *
> > > + * Returns the number of WARN*() calls suppressed since the current
> > > + * suppression block started, or 0 if the handle is NULL. Usable ins=
ide a
> > > + * kunit_warning_suppress() block or after KUNIT_END_SUPPRESSED_WARN=
ING().
> > > + */
> > > +#define KUNIT_SUPPRESSED_WARNING_COUNT() \
> > > +     kunit_suppressed_warning_count(__kunit_suppress)
> > > +
> > > +/**
> > > + * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT() - Sets an expectation tha=
t the
> > > + *                                           suppressed warning coun=
t equals
> > > + *                                           @expected.
> > > + * @test: The test context object.
> > > + * @expected: an expression that evaluates to the expected warning c=
ount.
> > > + *
> > > + * Sets an expectation that the number of suppressed WARN*() calls e=
quals
> > > + * @expected. This is semantically equivalent to
> > > + * KUNIT_EXPECT_EQ(@test, KUNIT_SUPPRESSED_WARNING_COUNT(), @expecte=
d).
> > > + * See KUNIT_EXPECT_EQ() for more information.
> > > + */
> > > +#define KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected) \
> > > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expecte=
d)
> > > +
> > > +/**
> > > + * KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT() - Sets an assertion that =
the
> > > + *                                           suppressed warning coun=
t equals
> > > + *                                           @expected.
> > > + * @test: The test context object.
> > > + * @expected: an expression that evaluates to the expected warning c=
ount.
> > > + *
> > > + * Sets an assertion that the number of suppressed WARN*() calls equ=
als
> > > + * @expected. This is the same as KUNIT_EXPECT_SUPPRESSED_WARNING_CO=
UNT(),
> > > + * except it causes an assertion failure (see KUNIT_ASSERT_TRUE()) w=
hen the
> > > + * assertion is not met.
> > > + */
> > > +#define KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT(test, expected) \
> > > +     KUNIT_ASSERT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expecte=
d)
> > > +
> > >   #endif /* _KUNIT_TEST_H */
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index c78600212b6c1..697d8ca054bef 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -39,6 +39,7 @@
> > >   #include <linux/sys_info.h>
> > >   #include <trace/events/error_report.h>
> > >   #include <asm/sections.h>
> > > +#include <kunit/test-bug.h>
> > >
> > >   #define PANIC_TIMER_STEP 100
> > >   #define PANIC_BLINK_SPD 18
> > > @@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void *=
caller, unsigned taint,
> > >   void warn_slowpath_fmt(const char *file, int line, unsigned taint,
> > >                      const char *fmt, ...)
> > >   {
> > > -     bool rcu =3D warn_rcu_enter();
> > > +     bool rcu;
> > >       struct warn_args args;
> > >
> > > +     if (kunit_is_suppressed_warning(true))
> > > +             return;
> > > +
> > > +     rcu =3D warn_rcu_enter();
> > > +
> > >       pr_warn(CUT_HERE);
> > >
> > >       if (!fmt) {
> > > @@ -1102,9 +1108,14 @@ EXPORT_SYMBOL(warn_slowpath_fmt);
> > >   #else
> > >   void __warn_printk(const char *fmt, ...)
> > >   {
> > > -     bool rcu =3D warn_rcu_enter();
> > > +     bool rcu;
> > >       va_list args;
> > >
> > > +     if (kunit_is_suppressed_warning(false))
> > > +             return;
> > > +
> > > +     rcu =3D warn_rcu_enter();
> > > +
> > >       pr_warn(CUT_HERE);
> > >
> > >       va_start(args, fmt);
> > > diff --git a/lib/bug.c b/lib/bug.c
> > > index 623c467a8b76c..a5cebde554ed8 100644
> > > --- a/lib/bug.c
> > > +++ b/lib/bug.c
> > > @@ -48,6 +48,7 @@
> > >   #include <linux/rculist.h>
> > >   #include <linux/ftrace.h>
> > >   #include <linux/context_tracking.h>
> > > +#include <kunit/test-bug.h>
> > >
> > >   extern struct bug_entry __start___bug_table[], __stop___bug_table[]=
;
> > >
> > > @@ -223,6 +224,15 @@ static enum bug_trap_type __report_bug(struct bu=
g_entry *bug, unsigned long buga
> > >       no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
> > >       has_args =3D bug->flags & BUGFLAG_ARGS;
> > >
> > > +#ifdef CONFIG_KUNIT
> > > +     /*
> > > +      * Before the once logic so suppressed warnings do not consume
> > > +      * the single-fire budget of WARN_ON_ONCE().
> > > +      */
> > > +     if (warning && kunit_is_suppressed_warning(true))
> > > +             return BUG_TRAP_TYPE_WARN;
> > > +#endif
> > > +
> > >       if (warning && once) {
> > >               if (done)
> > >                       return BUG_TRAP_TYPE_WARN;
> > > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > > index 656f1fa35abcc..4592f9d0aa8dd 100644
> > > --- a/lib/kunit/Makefile
> > > +++ b/lib/kunit/Makefile
> > > @@ -10,7 +10,8 @@ kunit-objs +=3D                               test.=
o \
> > >                                       executor.o \
> > >                                       attributes.o \
> > >                                       device.o \
> > > -                                     platform.o
> > > +                                     platform.o \
> > > +                                     bug.o
> > >
> > >   ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> > >   kunit-objs +=3D                               debugfs.o
> > > diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> > > new file mode 100644
> > > index 0000000000000..b0b6778d7399a
> > > --- /dev/null
> > > +++ b/lib/kunit/bug.c
> > > @@ -0,0 +1,115 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * KUnit helpers for backtrace suppression
> > > + *
> > > + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> > > + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> > > + */
> > > +
> > > +#include <kunit/resource.h>
> > > +#include <linux/export.h>
> > > +#include <linux/rculist.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +#include "hooks-impl.h"
> > > +
> > > +struct kunit_suppressed_warning {
> > > +     struct list_head node;
> > > +     struct task_struct *task;
> > > +     struct kunit *test;
> > > +     int counter;
> > > +};
> > > +
> > > +static LIST_HEAD(suppressed_warnings);
> > > +static DEFINE_SPINLOCK(suppressed_warnings_lock);
> > > +
> > > +static void kunit_suppress_warning_remove(struct kunit_suppressed_wa=
rning *w)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&suppressed_warnings_lock, flags);
> > > +     list_del_rcu(&w->node);
> > > +     spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
> > > +     synchronize_rcu(); /* Wait for readers to finish */
> > > +}
> > > +
> > > +KUNIT_DEFINE_ACTION_WRAPPER(kunit_suppress_warning_cleanup,
> > > +                         kunit_suppress_warning_remove,
> > > +                         struct kunit_suppressed_warning *);
> > > +
> > > +bool kunit_has_active_suppress_warning(void)
> > > +{
> > > +     return __kunit_is_suppressed_warning_impl(false);
> > > +}
> > > +EXPORT_SYMBOL_GPL(kunit_has_active_suppress_warning);
> > > +
> > > +struct kunit_suppressed_warning *
> > > +kunit_start_suppress_warning(struct kunit *test)
> > > +{
> > > +     struct kunit_suppressed_warning *w;
> > > +     unsigned long flags;
> > > +     int ret;
> > > +
> > > +     if (kunit_has_active_suppress_warning()) {
> > > +             KUNIT_FAIL(test, "Another suppression block is already =
active");
> > > +             return NULL;
> > > +     }
> > > +
> > > +     w =3D kunit_kzalloc(test, sizeof(*w), GFP_KERNEL);
> > > +     if (!w)
> > > +             return NULL;
> > > +
> > > +     w->task =3D current;
> > > +     w->test =3D test;
> > > +
> > > +     spin_lock_irqsave(&suppressed_warnings_lock, flags);
> > > +     list_add_rcu(&w->node, &suppressed_warnings);
> > > +     spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
> > > +
> > > +     ret =3D kunit_add_action_or_reset(test,
> > > +                                     kunit_suppress_warning_cleanup,=
 w);
> > > +     if (ret)
> > > +             return NULL;
> > > +
> > > +     return w;
> > > +}
> > > +EXPORT_SYMBOL_GPL(kunit_start_suppress_warning);
> > > +
> > > +void kunit_end_suppress_warning(struct kunit *test,
> > > +                             struct kunit_suppressed_warning *w)
> > > +{
> > > +     if (!w)
> > > +             return;
> > > +     kunit_release_action(test, kunit_suppress_warning_cleanup, w);
> > > +}
> > > +EXPORT_SYMBOL_GPL(kunit_end_suppress_warning);
> > > +
> > > +void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning *=
*wp)
> > > +{
> > > +     if (*wp)
> > > +             kunit_end_suppress_warning((*wp)->test, *wp);
> > > +}
> > > +EXPORT_SYMBOL_GPL(__kunit_suppress_auto_cleanup);
> > > +
> > > +int kunit_suppressed_warning_count(struct kunit_suppressed_warning *=
w)
> > > +{
> > > +     return w ? w->counter : 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(kunit_suppressed_warning_count);
> > > +
> > > +bool __kunit_is_suppressed_warning_impl(bool count)
> > > +{
> > > +     struct kunit_suppressed_warning *w;
> > > +
> > > +     guard(rcu)();
> > > +     list_for_each_entry_rcu(w, &suppressed_warnings, node) {
> > > +             if (w->task =3D=3D current) {
> > > +                     if (count)
> > > +                             w->counter++;
> > > +                     return true;
> > > +             }
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
> > > index 4e71b2d0143ba..d8720f2616925 100644
> > > --- a/lib/kunit/hooks-impl.h
> > > +++ b/lib/kunit/hooks-impl.h
> > > @@ -19,6 +19,7 @@ void __printf(3, 4) __kunit_fail_current_test_impl(=
const char *file,
> > >                                                  int line,
> > >                                                  const char *fmt, ...=
);
> > >   void *__kunit_get_static_stub_address_impl(struct kunit *test, void=
 *real_fn_addr);
> > > +bool __kunit_is_suppressed_warning_impl(bool count);
> > >
> > >   /* Code to set all of the function pointers. */
> > >   static inline void kunit_install_hooks(void)
> > > @@ -26,6 +27,7 @@ static inline void kunit_install_hooks(void)
> > >       /* Install the KUnit hook functions. */
> > >       kunit_hooks.fail_current_test =3D __kunit_fail_current_test_imp=
l;
> > >       kunit_hooks.get_static_stub_address =3D __kunit_get_static_stub=
_address_impl;
> > > +     kunit_hooks.is_suppressed_warning =3D __kunit_is_suppressed_war=
ning_impl;
> > >   }
> > >
> > >   #endif /* _KUNIT_HOOKS_IMPL_H */
> > >
> >

