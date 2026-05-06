Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0B13F23CF
	for <linux-arch@vger.kernel.org>; Wed,  6 May 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062300; cv=pass; b=Fu0nRE/Ti2PNdYiqZ20F8GsGJNY9CMjSTj1DpDWmTt3Hu/K/zaQCMbs/UPrHVZ14Q3KYLRTQe/OGHpAgc/hSDuhWjxayf4T6veZwGr0OS9qG5XIljxoT/pFwq3p5OMtcIiRIprV/OxdSwot9jpZOGjDzUR1FvlcdiBZhXi6i+SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062300; c=relaxed/simple;
	bh=a/5XJxr1ODPYKyZVulCiykJHcCyto7lGgNQMSw4UiVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRAyI17FfxJ3EUFJc35d+RvWmOMXVdt9pKaBXNIbkoRpzGTSBKkO2pPj/j8gjqX0kkBSDpVzLc7Vai54Se5BKKc+WjZqCCAEIsxSkWcQxSRL2GoNGEdFBEmmu6ANOR6qnUhSUVKpDgLOnFU0ZOR3D+wwmnFbdiRCcG1SLZ6eIdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J/of8IAg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f164vPwp; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/of8IAg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f164vPwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778062297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsOvavuz84uExD4iLxYbhKIOMoMGoa/ix3DcjgpaQNQ=;
	b=J/of8IAgq+vqQcqq8dJe4q0/nOOZmGEE1T3b3vxbvTSGaOU4Sll95Trez7cpxbrLVDgaMw
	hIU1bOvxq7XVMV0k0swQNMgG0u9lvLkM+KbkQC9jVX+pCD3l2M/9ejYkRs73pQ8x8AZcRm
	5JLP2Ug+kNg9S0ZpPvteCD0z2TlKW84=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-22qXxX_YOue-C_dweJ40Rg-1; Wed, 06 May 2026 06:11:34 -0400
X-MC-Unique: 22qXxX_YOue-C_dweJ40Rg-1
X-Mimecast-MFC-AGG-ID: 22qXxX_YOue-C_dweJ40Rg_1778062293
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c67faba33so4353694d50.3
        for <linux-arch@vger.kernel.org>; Wed, 06 May 2026 03:11:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778062293; cv=none;
        d=google.com; s=arc-20240605;
        b=UWdW3kPeGK2nDYuBwZzaUXYDahQSXP/juRTOKHflrmQLEaLQxdfq17Sfp/Z/U5Tt9D
         6tDWMptHSwPJf8vx+W0oR0EuQrHsuspEYaaFfw3niDHcTlDuxpQVUf6b8ABZyDNKkTuS
         Xa4PW0EHpEQ6w45KaTHIxo/phkRfiJ3dLseqW44+vdgPkysXkzZus+XFUyys0kiQrEzY
         iHa6ZTidY5hCNtc5+JyV07PABdMx8HMAcqsZ/EFMMZyh09XOB6HlANdvCBnqoLlZpWqy
         ItunQbksAQGYkcA8MCR5w5A3MfB/kc0K++5uh80zV9IWhUEPe9Yilgy5zDAsSV5wcMvk
         yOKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MsOvavuz84uExD4iLxYbhKIOMoMGoa/ix3DcjgpaQNQ=;
        fh=QLiDg/64D9MklsQdMdh++B0RlmnGyIbCHQ5FRwyhHE8=;
        b=k7gKruZOAeSXkphY5Rcuyvck8cPTSjc6eyXW1rDy6fCcc5XmP2kvhufCVXmzyjf0sI
         0egzZOzc2wNkbZjgyBKg7BbfJuxxY81DmNDvo8OBBErrpQyQ4TLYaarTAinqOQJUzxDc
         qCl/qKFmYTwQq9+BPsst8Y2U8MQY28fEPG3kSGrVvFMil5Pfypc8ty/5eG1b5vGh1Gj6
         7L1P2weYrRCW7evNgd75pV+rNMJgwVLsS33IJPHZ9vcckm+IzXVCdXrE0G0noJlYPFVg
         a8lo0QHhRUYOXr2j/59r5j8FYVh+H/00Vetq9s+Bk4LICvZf+UNzBo2J/SI6XHQUHZQG
         DuJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778062293; x=1778667093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsOvavuz84uExD4iLxYbhKIOMoMGoa/ix3DcjgpaQNQ=;
        b=f164vPwpkzZVFbygOz2Y0PJQN3OkKbxvjqz9Ol00Cumt1eTh7QC7Wms9r8wTewBOI1
         SjmWWYa0eoF7U1LdTHGr3AjTS1qR3GBXxtmMEGBqp2ImnhAhbzNcaGJg5f90WDzFuWXP
         RdV1js2a+zBL39bCj1xlNcHw/2vR1+zo/Lo3VEKSvf8+EY7rZ0QrLXNMe4qyHXlMskr7
         8YCYr5jT6TaKKhSRqf9STdTiwQxZV2YuxSSTkzMblYt0Re/Em5/baWWOrHC8vaM9perh
         y6sjLKptesOLQKni8quFce+pnktmS67EObObcsfSjbZX2Eagz0fifM7LbwTGgkYOv7xW
         XIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062293; x=1778667093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MsOvavuz84uExD4iLxYbhKIOMoMGoa/ix3DcjgpaQNQ=;
        b=NVNvc8kvXAAU8R1+Ql3HH/zp8aqOITkjvm4VK1SWrytjx011AWNzS/WZgeMPRuNdl0
         YZFxnelstbV+4NigizQi+58Kvmr82p7/mzA+/rr9M2tAdScBG1cbd915WN6CwNNRO5Ub
         JaXNKr24LXc1Ic4gqmmLyovxlEFLx9Tq+uefykTcgkJ4/C2t1Slpl9bOVB5zzR7p/lyp
         tOEbgXKC6Yd8dcHowVqD8sb3zfp8CbG48y1arJvJgsQD2/HC0fykHLf6sMLJx2jH+3bh
         9qGoQOkEcaPyKL8DJ5tuqW10iu3x3uHt3LL9nfEbSHrYeDNDqzJNsNUAgQBKv2Hc3XEI
         7vgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UX8QCbGDGhmL6NiRyn1KdePVQvbylEiHXlxEnY74lgzHrtPXt1Ly6wNktRboaxsfYJpbt698gftGp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7agjHqWG3HD1fk+EC5FFDnn6jtrJwYSAXIBUqGzlQVhl9xLmg
	Mj5sAsIAR2QqcQRh0s3Rilx1D8erAoZxD46HwJFKBdwP1Vq6Ddblq/NdHmZJ2Rc8dTxNoaBGQUP
	rER/5EgLNFZ6Pt2xA8h//uwl0h4jUdVTaIw6tXlg+V1+ONSZYnF5pTewsu5Mp1Nw3MCRxYR8YXE
	ozGYZPMg7ZMW057oCFDgZqxAo8CsC/0YhnRxpAlw==
X-Gm-Gg: AeBDieuMRg82m17KLAgmripvGYhwblyOr02NLkdmp5kBLs59ThRHYLEOL3s3bp5SkA3
	mMuCyMo0N7xUx9IoZqBj5ZRNBCP6WLzPoWmIF/MNZgDQCTPEgj4EA8eJVlHXEHGNW1TlB/3cewW
	CKksMvlSyWO8+LcvjJhpOTxQc/tYjFh11y8PCp+QVqOD2GUWoTcGhudJcsFFveaffB0emv4toyQ
	wZLsykvjKS52XDy
X-Received: by 2002:a05:690e:1481:b0:650:17fe:1a9c with SMTP id 956f58d0204a3-65c799b2a80mr3072211d50.33.1778062293279;
        Wed, 06 May 2026 03:11:33 -0700 (PDT)
X-Received: by 2002:a05:690e:1481:b0:650:17fe:1a9c with SMTP id
 956f58d0204a3-65c799b2a80mr3072180d50.33.1778062292622; Wed, 06 May 2026
 03:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-1-3e5957cdd235@redhat.com> <c5c28f16-3940-4960-84e6-33f5479a5450@davidgow.net>
In-Reply-To: <c5c28f16-3940-4960-84e6-33f5479a5450@davidgow.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 May 2026 12:11:21 +0200
X-Gm-Features: AVHnY4Imsl4W_J-H_4zB9-E8cFlW4-V2-ioi85GEvrQpNjDRg5Q8jH9CAHJamU0
Message-ID: <CADSE00KLhyUpRD031-YveOv+o71jJ-NojX6VteSyF+SqxG0n4g@mail.gmail.com>
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

On Wed, May 6, 2026 at 11:40=E2=80=AFAM David Gow <david@davidgow.net> wrot=
e:
>
> Le 04/05/2026 =C3=A0 3:41 PM, Albert Esteve a =C3=A9crit :
> > From: Alessandro Carminati <acarmina@redhat.com>
> >
> > Some unit tests intentionally trigger warning backtraces by passing bad
> > parameters to kernel API functions. Such unit tests typically check the
> > return value from such calls, not the existence of the warning backtrac=
e.
> >
> > Such intentionally generated warning backtraces are neither desirable
> > nor useful for a number of reasons:
> > - They can result in overlooked real problems.
> > - A warning that suddenly starts to show up in unit tests needs to be
> >    investigated and has to be marked to be ignored, for example by
> >    adjusting filter scripts. Such filters are ad hoc because there is
> >    no real standard format for warnings. On top of that, such filter
> >    scripts would require constant maintenance.
> >
> > Solve the problem by providing a means to suppress warning backtraces
> > originating from the current kthread while executing test code. Since
> > each KUnit test runs in its own kthread, this effectively scopes
> > suppression to the test that enabled it. Limit changes to generic code
> > to the absolute minimum.
> >
> > Implementation details:
> > Suppression is integrated into the existing KUnit hooks infrastructure
> > in test-bug.h, reusing the kunit_running static branch for zero
> > overhead when no tests are running.
> >
> > Suppression is checked at three points in the warning path:
> > - In warn_slowpath_fmt(), the check runs before any output, fully
> >    suppressing both message and backtrace. This covers architectures
> >    without __WARN_FLAGS.
> > - In __warn_printk(), the check suppresses the warning message text.
> >    This covers architectures that define __WARN_FLAGS but not their own
> >    __WARN_printf (arm64, loongarch, parisc, powerpc, riscv, sh), where
> >    the message is printed before the trap enters __report_bug().
> > - In __report_bug(), the check runs before __warn() is called,
> >    suppressing the backtrace and stack dump.
> >
> > To avoid double-counting on architectures where both __warn_printk()
> > and __report_bug() run for the same warning, kunit_is_suppressed_warnin=
g()
> > takes a bool parameter: true to increment the suppression counter
> > (used in warn_slowpath_fmt and __report_bug), false to check only
> > (used in __warn_printk).
> >
> > The suppression state is dynamically allocated via kunit_kzalloc() and
> > tied to the KUnit test lifecycle via kunit_add_action(), ensuring
> > automatic cleanup at test exit. Writer-side access to the global
> > suppression list is serialized with a spinlock; readers use RCU.
> >
> > Three API forms are provided:
> > - kunit_warning_suppress(test) { ... }: scoped, uses __cleanup for
> >    automatic teardown on scope exit, kunit_add_action() as safety net
> >    for abnormal exits (e.g. kthread_exit from failed assertions).
> >    Suppression handle is only accessible inside the block.
> > - KUNIT_START/END_SUPPRESSED_WARNING(test): manual macros for larger
> >    blocks or when warning counts need to be checked after suppression
> >    ends. Limited to one pair per scope.
> > - kunit_start/end_suppress_warning(test): direct functions returning
> >    an explicit handle, for retaining the handle within the test,
> >    or for cross-function usage.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> This looks pretty good to me, thanks.
>
> Reviewed-by: David Gow <david@davidgow.net>
>
> It's maybe slightly over-the-top to now have three different ways of
> enabling warning suppression: I'd probably personally get rid of
> KUNIT_START/END_SUPPRESSED_WARNING() if we had to lose one. But if
> there's a real reason to prefer keeping all three, it's not actually a
> problem to do so.

Thanks for the review!

I think the three forms earn their keep: the scoped form is the go-to
for most cases, but the macros avoid indentation without requiring
users to manage a raw pointer. I initially removed the macros and
added them back later. Direct calls to the functions will be less
frequent, used only when you need the handle.

That said, if it becomes a maintenance burden, the macros are the
easiest to drop since they're thin wrappers. Let me know if you prefer
them to be dropped, and I will send a v9 with that and the
`KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT` additions to the drm test
patch.

BR,
Albert.

>
> Regardless, this series is looking pretty ready to me. Let me know if
> you're planning a v9, otherwise we'll take this when you're ready.
>
> Cheers,
> -- David
>
> >   include/kunit/test-bug.h |  25 +++++++++
> >   include/kunit/test.h     | 138 ++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   kernel/panic.c           |  15 +++++-
> >   lib/bug.c                |  10 ++++
> >   lib/kunit/Makefile       |   3 +-
> >   lib/kunit/bug.c          | 115 ++++++++++++++++++++++++++++++++++++++=
+
> >   lib/kunit/hooks-impl.h   |   2 +
> >   7 files changed, 305 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> > index 47aa8f21ccce8..6237e48ceadfd 100644
> > --- a/include/kunit/test-bug.h
> > +++ b/include/kunit/test-bug.h
> > @@ -23,6 +23,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
> >   extern struct kunit_hooks_table {
> >       __printf(3, 4) void (*fail_current_test)(const char*, int, const =
char*, ...);
> >       void *(*get_static_stub_address)(struct kunit *test, void *real_f=
n_addr);
> > +     bool (*is_suppressed_warning)(bool count);
> >   } kunit_hooks;
> >
> >   /**
> > @@ -60,9 +61,33 @@ static inline struct kunit *kunit_get_current_test(v=
oid)
> >               }                                                        =
       \
> >       } while (0)
> >
> > +/**
> > + * kunit_is_suppressed_warning() - Check if warnings are being suppres=
sed
> > + *                                 by the current KUnit test.
> > + * @count: if true, increment the suppression counter on match.
> > + *
> > + * Returns true if the current task has active warning suppression.
> > + * Uses the kunit_running static branch for zero overhead when no test=
s run.
> > + *
> > + * A single WARN*() may traverse multiple call sites in the warning pa=
th
> > + * (e.g., __warn_printk() and __report_bug()). Pass @count =3D true at=
 the
> > + * primary suppression point to count each warning exactly once, and
> > + * @count =3D false at secondary points to suppress output without
> > + * inflating the count.
> > + */
> > +static inline bool kunit_is_suppressed_warning(bool count)
> > +{
> > +     if (!static_branch_unlikely(&kunit_running))
> > +             return false;
> > +
> > +     return kunit_hooks.is_suppressed_warning &&
> > +            kunit_hooks.is_suppressed_warning(count);
> > +}
> > +
> >   #else
> >
> >   static inline struct kunit *kunit_get_current_test(void) { return NUL=
L; }
> > +static inline bool kunit_is_suppressed_warning(bool count) { return fa=
lse; }
> >
> >   #define kunit_fail_current_test(fmt, ...) do {} while (0)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index 9cd1594ab697d..f278ec028019c 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -1795,4 +1795,142 @@ do {                                           =
                              \
> >   // include resource.h themselves if they need it.
> >   #include <kunit/resource.h>
> >
> > +/*
> > + * Warning backtrace suppression API.
> > + *
> > + * Suppresses WARN*() backtraces on the current task while active. Thr=
ee forms
> > + * are provided, in order of convenience:
> > + *
> > + * - Scoped: kunit_warning_suppress(test) { ... }
> > + *   Suppression is active for the duration of the block. On normal ex=
it,
> > + *   the for-loop increment deactivates suppression. On early exit (br=
eak,
> > + *   return, goto), the __cleanup attribute fires. On kthread_exit() (=
e.g.,
> > + *   a failed KUnit assertion), kunit_add_action() cleans up at test
> > + *   teardown. The suppression handle is only accessible inside the bl=
ock,
> > + *   so warning counts must be checked before the block exits.
> > + *
> > + * - Manual macros: KUNIT_[START|END]_SUPPRESSED_WARNING(test)
> > + *   Suppression spans an explicit range in the same scope. kunit_add_=
action()
> > + *   guarantees cleanup even if KUNIT_END_SUPPRESSED_WARNING() is not =
reached.
> > + *   Prefer this form when suppressing warnings across a large block w=
here
> > + *   extra indentation is undesirable, or when the warning count needs=
 to be
> > + *   checked after suppression ends. Limited to one pair per scope.
> > + *
> > + * - Direct: kunit_start_suppress_warning() / kunit_end_suppress_warni=
ng()
> > + *   The underlying functions, returning an explicit handle pointer. U=
se
> > + *   when the handle needs to be retained (e.g., for post-suppression
> > + *   count checks) or passed across helper functions.
> > + */
> > +struct kunit_suppressed_warning;
> > +
> > +struct kunit_suppressed_warning *
> > +kunit_start_suppress_warning(struct kunit *test);
> > +void kunit_end_suppress_warning(struct kunit *test,
> > +                             struct kunit_suppressed_warning *w);
> > +int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w)=
;
> > +void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **w=
p);
> > +bool kunit_has_active_suppress_warning(void);
> > +
> > +/**
> > + * kunit_warning_suppress() - Suppress WARN*() backtraces for the dura=
tion
> > + *                            of a block.
> > + * @test: The test context object.
> > + *
> > + * Scoped form of the suppression API. Suppression starts when the blo=
ck is
> > + * entered and ends automatically when the block exits through any pat=
h. See
> > + * the section comment above for the cleanup guarantees on each exit p=
ath.
> > + * Fails the test if suppression is already active; nesting is not sup=
ported.
> > + *
> > + * The warning count can be checked inside the block via
> > + * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(). The handle is not accessib=
le
> > + * after the block exits.
> > + *
> > + * Example::
> > + *
> > + *   kunit_warning_suppress(test) {
> > + *       trigger_warning();
> > + *       KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> > + *   }
> > + */
> > +#define kunit_warning_suppress(test)                                 \
> > +     for (struct kunit_suppressed_warning *__kunit_suppress          \
> > +          __cleanup(__kunit_suppress_auto_cleanup) =3D                =
 \
> > +          kunit_start_suppress_warning(test);                        \
> > +          __kunit_suppress;                                          \
> > +          kunit_end_suppress_warning(test, __kunit_suppress),        \
> > +          __kunit_suppress =3D NULL)
> > +
> > +/**
> > + * KUNIT_START_SUPPRESSED_WARNING() - Begin suppressing WARN*() backtr=
aces.
> > + * @test: The test context object.
> > + *
> > + * Manual form of the suppression API. Must be paired with
> > + * KUNIT_END_SUPPRESSED_WARNING() in the same scope. See the section c=
omment
> > + * above for cleanup guarantees. Fails the test if suppression is alre=
ady
> > + * active; nesting is not supported. Limited to one pair per scope; us=
e
> > + * sequential kunit_warning_suppress() blocks or the direct function A=
PI
> > + * when more than one suppression region is needed.
> > + *
> > + * Example::
> > + *
> > + *   KUNIT_START_SUPPRESSED_WARNING(test);
> > + *   trigger_code_that_should_warn_once();
> > + *   KUNIT_END_SUPPRESSED_WARNING(test);
> > + *   KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> > + */
> > +#define KUNIT_START_SUPPRESSED_WARNING(test)                         \
> > +     struct kunit_suppressed_warning *__kunit_suppress =3D            =
 \
> > +             kunit_start_suppress_warning(test)
> > +
> > +/**
> > + * KUNIT_END_SUPPRESSED_WARNING() - End suppressing WARN*() backtraces=
.
> > + * @test: The test context object.
> > + *
> > + * Deactivates suppression started by KUNIT_START_SUPPRESSED_WARNING()=
.
> > + * The warning count remains readable via KUNIT_SUPPRESSED_WARNING_COU=
NT()
> > + * after this call.
> > + */
> > +#define KUNIT_END_SUPPRESSED_WARNING(test)                           \
> > +     kunit_end_suppress_warning(test, __kunit_suppress)
> > +
> > +/**
> > + * KUNIT_SUPPRESSED_WARNING_COUNT() - Returns the suppressed warning c=
ount.
> > + *
> > + * Returns the number of WARN*() calls suppressed since the current
> > + * suppression block started, or 0 if the handle is NULL. Usable insid=
e a
> > + * kunit_warning_suppress() block or after KUNIT_END_SUPPRESSED_WARNIN=
G().
> > + */
> > +#define KUNIT_SUPPRESSED_WARNING_COUNT() \
> > +     kunit_suppressed_warning_count(__kunit_suppress)
> > +
> > +/**
> > + * KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT() - Sets an expectation that =
the
> > + *                                           suppressed warning count =
equals
> > + *                                           @expected.
> > + * @test: The test context object.
> > + * @expected: an expression that evaluates to the expected warning cou=
nt.
> > + *
> > + * Sets an expectation that the number of suppressed WARN*() calls equ=
als
> > + * @expected. This is semantically equivalent to
> > + * KUNIT_EXPECT_EQ(@test, KUNIT_SUPPRESSED_WARNING_COUNT(), @expected)=
.
> > + * See KUNIT_EXPECT_EQ() for more information.
> > + */
> > +#define KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, expected) \
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
> > +
> > +/**
> > + * KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT() - Sets an assertion that th=
e
> > + *                                           suppressed warning count =
equals
> > + *                                           @expected.
> > + * @test: The test context object.
> > + * @expected: an expression that evaluates to the expected warning cou=
nt.
> > + *
> > + * Sets an assertion that the number of suppressed WARN*() calls equal=
s
> > + * @expected. This is the same as KUNIT_EXPECT_SUPPRESSED_WARNING_COUN=
T(),
> > + * except it causes an assertion failure (see KUNIT_ASSERT_TRUE()) whe=
n the
> > + * assertion is not met.
> > + */
> > +#define KUNIT_ASSERT_SUPPRESSED_WARNING_COUNT(test, expected) \
> > +     KUNIT_ASSERT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), expected)
> > +
> >   #endif /* _KUNIT_TEST_H */
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index c78600212b6c1..697d8ca054bef 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/sys_info.h>
> >   #include <trace/events/error_report.h>
> >   #include <asm/sections.h>
> > +#include <kunit/test-bug.h>
> >
> >   #define PANIC_TIMER_STEP 100
> >   #define PANIC_BLINK_SPD 18
> > @@ -1080,9 +1081,14 @@ void __warn(const char *file, int line, void *ca=
ller, unsigned taint,
> >   void warn_slowpath_fmt(const char *file, int line, unsigned taint,
> >                      const char *fmt, ...)
> >   {
> > -     bool rcu =3D warn_rcu_enter();
> > +     bool rcu;
> >       struct warn_args args;
> >
> > +     if (kunit_is_suppressed_warning(true))
> > +             return;
> > +
> > +     rcu =3D warn_rcu_enter();
> > +
> >       pr_warn(CUT_HERE);
> >
> >       if (!fmt) {
> > @@ -1102,9 +1108,14 @@ EXPORT_SYMBOL(warn_slowpath_fmt);
> >   #else
> >   void __warn_printk(const char *fmt, ...)
> >   {
> > -     bool rcu =3D warn_rcu_enter();
> > +     bool rcu;
> >       va_list args;
> >
> > +     if (kunit_is_suppressed_warning(false))
> > +             return;
> > +
> > +     rcu =3D warn_rcu_enter();
> > +
> >       pr_warn(CUT_HERE);
> >
> >       va_start(args, fmt);
> > diff --git a/lib/bug.c b/lib/bug.c
> > index 623c467a8b76c..a5cebde554ed8 100644
> > --- a/lib/bug.c
> > +++ b/lib/bug.c
> > @@ -48,6 +48,7 @@
> >   #include <linux/rculist.h>
> >   #include <linux/ftrace.h>
> >   #include <linux/context_tracking.h>
> > +#include <kunit/test-bug.h>
> >
> >   extern struct bug_entry __start___bug_table[], __stop___bug_table[];
> >
> > @@ -223,6 +224,15 @@ static enum bug_trap_type __report_bug(struct bug_=
entry *bug, unsigned long buga
> >       no_cut   =3D bug->flags & BUGFLAG_NO_CUT_HERE;
> >       has_args =3D bug->flags & BUGFLAG_ARGS;
> >
> > +#ifdef CONFIG_KUNIT
> > +     /*
> > +      * Before the once logic so suppressed warnings do not consume
> > +      * the single-fire budget of WARN_ON_ONCE().
> > +      */
> > +     if (warning && kunit_is_suppressed_warning(true))
> > +             return BUG_TRAP_TYPE_WARN;
> > +#endif
> > +
> >       if (warning && once) {
> >               if (done)
> >                       return BUG_TRAP_TYPE_WARN;
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index 656f1fa35abcc..4592f9d0aa8dd 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -10,7 +10,8 @@ kunit-objs +=3D                               test.o =
\
> >                                       executor.o \
> >                                       attributes.o \
> >                                       device.o \
> > -                                     platform.o
> > +                                     platform.o \
> > +                                     bug.o
> >
> >   ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
> >   kunit-objs +=3D                               debugfs.o
> > diff --git a/lib/kunit/bug.c b/lib/kunit/bug.c
> > new file mode 100644
> > index 0000000000000..b0b6778d7399a
> > --- /dev/null
> > +++ b/lib/kunit/bug.c
> > @@ -0,0 +1,115 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit helpers for backtrace suppression
> > + *
> > + * Copyright (C) 2025 Alessandro Carminati <acarmina@redhat.com>
> > + * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
> > + */
> > +
> > +#include <kunit/resource.h>
> > +#include <linux/export.h>
> > +#include <linux/rculist.h>
> > +#include <linux/sched.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "hooks-impl.h"
> > +
> > +struct kunit_suppressed_warning {
> > +     struct list_head node;
> > +     struct task_struct *task;
> > +     struct kunit *test;
> > +     int counter;
> > +};
> > +
> > +static LIST_HEAD(suppressed_warnings);
> > +static DEFINE_SPINLOCK(suppressed_warnings_lock);
> > +
> > +static void kunit_suppress_warning_remove(struct kunit_suppressed_warn=
ing *w)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&suppressed_warnings_lock, flags);
> > +     list_del_rcu(&w->node);
> > +     spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
> > +     synchronize_rcu(); /* Wait for readers to finish */
> > +}
> > +
> > +KUNIT_DEFINE_ACTION_WRAPPER(kunit_suppress_warning_cleanup,
> > +                         kunit_suppress_warning_remove,
> > +                         struct kunit_suppressed_warning *);
> > +
> > +bool kunit_has_active_suppress_warning(void)
> > +{
> > +     return __kunit_is_suppressed_warning_impl(false);
> > +}
> > +EXPORT_SYMBOL_GPL(kunit_has_active_suppress_warning);
> > +
> > +struct kunit_suppressed_warning *
> > +kunit_start_suppress_warning(struct kunit *test)
> > +{
> > +     struct kunit_suppressed_warning *w;
> > +     unsigned long flags;
> > +     int ret;
> > +
> > +     if (kunit_has_active_suppress_warning()) {
> > +             KUNIT_FAIL(test, "Another suppression block is already ac=
tive");
> > +             return NULL;
> > +     }
> > +
> > +     w =3D kunit_kzalloc(test, sizeof(*w), GFP_KERNEL);
> > +     if (!w)
> > +             return NULL;
> > +
> > +     w->task =3D current;
> > +     w->test =3D test;
> > +
> > +     spin_lock_irqsave(&suppressed_warnings_lock, flags);
> > +     list_add_rcu(&w->node, &suppressed_warnings);
> > +     spin_unlock_irqrestore(&suppressed_warnings_lock, flags);
> > +
> > +     ret =3D kunit_add_action_or_reset(test,
> > +                                     kunit_suppress_warning_cleanup, w=
);
> > +     if (ret)
> > +             return NULL;
> > +
> > +     return w;
> > +}
> > +EXPORT_SYMBOL_GPL(kunit_start_suppress_warning);
> > +
> > +void kunit_end_suppress_warning(struct kunit *test,
> > +                             struct kunit_suppressed_warning *w)
> > +{
> > +     if (!w)
> > +             return;
> > +     kunit_release_action(test, kunit_suppress_warning_cleanup, w);
> > +}
> > +EXPORT_SYMBOL_GPL(kunit_end_suppress_warning);
> > +
> > +void __kunit_suppress_auto_cleanup(struct kunit_suppressed_warning **w=
p)
> > +{
> > +     if (*wp)
> > +             kunit_end_suppress_warning((*wp)->test, *wp);
> > +}
> > +EXPORT_SYMBOL_GPL(__kunit_suppress_auto_cleanup);
> > +
> > +int kunit_suppressed_warning_count(struct kunit_suppressed_warning *w)
> > +{
> > +     return w ? w->counter : 0;
> > +}
> > +EXPORT_SYMBOL_GPL(kunit_suppressed_warning_count);
> > +
> > +bool __kunit_is_suppressed_warning_impl(bool count)
> > +{
> > +     struct kunit_suppressed_warning *w;
> > +
> > +     guard(rcu)();
> > +     list_for_each_entry_rcu(w, &suppressed_warnings, node) {
> > +             if (w->task =3D=3D current) {
> > +                     if (count)
> > +                             w->counter++;
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > diff --git a/lib/kunit/hooks-impl.h b/lib/kunit/hooks-impl.h
> > index 4e71b2d0143ba..d8720f2616925 100644
> > --- a/lib/kunit/hooks-impl.h
> > +++ b/lib/kunit/hooks-impl.h
> > @@ -19,6 +19,7 @@ void __printf(3, 4) __kunit_fail_current_test_impl(co=
nst char *file,
> >                                                  int line,
> >                                                  const char *fmt, ...);
> >   void *__kunit_get_static_stub_address_impl(struct kunit *test, void *=
real_fn_addr);
> > +bool __kunit_is_suppressed_warning_impl(bool count);
> >
> >   /* Code to set all of the function pointers. */
> >   static inline void kunit_install_hooks(void)
> > @@ -26,6 +27,7 @@ static inline void kunit_install_hooks(void)
> >       /* Install the KUnit hook functions. */
> >       kunit_hooks.fail_current_test =3D __kunit_fail_current_test_impl;
> >       kunit_hooks.get_static_stub_address =3D __kunit_get_static_stub_a=
ddress_impl;
> > +     kunit_hooks.is_suppressed_warning =3D __kunit_is_suppressed_warni=
ng_impl;
> >   }
> >
> >   #endif /* _KUNIT_HOOKS_IMPL_H */
> >
>

