Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0D35E923
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777015052; cv=pass; b=ONWQJLTE3YcTdbrPD9g5fruVv8pTvv0RbOakW6pQUsfhBsejXD4AP5ILSc8pA0H/4WkGHSeRbBV4+mNB+K+1RPmktmy4SKoD4zzxHV3iuEbn2ITMfo4GTnYo/Eec3POYyX7oBz3p+ij1EWCyody0LckPYwR4sZXvYtQDyTBBkm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777015052; c=relaxed/simple;
	bh=yClHRF8OjhIxck88Jx+vYcQmNKKejUFC6AKG1u3nJUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFAVwEoQtg1LfwqUEhEsHcU5PRDtfgyqqYSQg/Q046o02Oz5dtTuuxF8E9Od6o3G/SNj5Q/BCb+LqkQmthSPs8GCAsWWaTwmnbsyEnaktlw6sMzL+db805pE52RvYkUdPxjgVPcEOwrGbdqFBGKelWITHr4W1HzVY8Fe6Xp86No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amSw304y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYGFxIrY; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amSw304y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYGFxIrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777015049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocRQwsGxmUd24plQscvID6P4Yrryzt44ghQQY2RzSsk=;
	b=amSw304ygccY9CZo70L1UIvHGLU/otpKqcR6SW0AM/8TIg2EYwqMmn4higD7fspAmbCv3g
	T36RVZxXoj0QuFHP3dgs4XYx+8IfxcdfyBMpMo28Ew8jgVGdJz5aBuiDpOAKMp0WpFpxb6
	eBieLw7bogtqFlbCk+GfcxTEQkoTt9g=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-yh71luQgMXO9xXeqf6iLcg-1; Fri, 24 Apr 2026 03:17:18 -0400
X-MC-Unique: yh71luQgMXO9xXeqf6iLcg-1
X-Mimecast-MFC-AGG-ID: yh71luQgMXO9xXeqf6iLcg_1777015038
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7b6fea89dd7so93204357b3.1
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 00:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777015038; cv=none;
        d=google.com; s=arc-20240605;
        b=bmPLbopusXUAPHva9+1jfAVSJjNQ49p0JhNEBX6sdfGrxKZdoQtOOqaiiPtC31ep96
         7yETNAY9VNuWAWl5zLd6DcmYJRM4tzxEk92O1ZyYxpYMzEngpon+8qABMvEAc4+X6B9p
         c/uRh2RB9vHH7qnOSQB5VV3wX0yG29soEL+VfDljrpEaCG/0B4LRAChOAaf8o4elLJRN
         j7nv/fvH8X58fJZbpumUVLsejjZceIwJ+lybUk0zRirIG9MbB5PgFprfiY+AhzCW5o1+
         oylshYq/lP+1/41vC97vMwvlc/4UA6IrgN06ZrmS++8CTguJ4l5FX9EegKSrrkvMMWiQ
         D9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ocRQwsGxmUd24plQscvID6P4Yrryzt44ghQQY2RzSsk=;
        fh=xFo1nui+RnXbcoU/DNqnMT37VsExkMMkwtxPtRzf2Ug=;
        b=Q9FmaqJ1RRNzi1Q81svKfBhomK17lYuiuhCSjxj0vybwhd7oWqsviSpuk3ZVpSshP0
         UjMyHi+ahb1v95n2Kz7qsxDrVyrhjJCWtKhtQOMzNP+stnJIDu8tH/Ut+IOMubxdaCpz
         xDXzYVr6o3jIjO9OuE5HYwNXb3xdVjqX6GcGsYhipAGqKynxoYeuquuvofk8Lr8HuSn9
         gPvSU7Kfvx+H8qFbaa8VbWai4cWlgOCv2mrC0Rh3o8XZL3DHrJfVnbcnqJFJxyYS77E4
         tB4hAMB68MrRtAqVMCGKwuhQAljsu81Kp8GnFKGb0f7/VLgtAKEkbW8aplDe08AUdWmS
         jDEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777015038; x=1777619838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocRQwsGxmUd24plQscvID6P4Yrryzt44ghQQY2RzSsk=;
        b=RYGFxIrYmkdPH5H6sCnbRVAiE21g7fScoKvsLDZjrODthL/MNFbzmR0zDYAz4D0JEU
         3VF8Ypl6Xua84ndVEP9DtGOKMuIDvDY+BgSIX7cB/ExtidMYVDyzplilORHQreGfdIoG
         uprang6fhniPd7CGuEpa+tcq8zU42mmV7eQMpQZEaZM6yBkUBjb+svkh8Zlyu5XtjJiE
         RXhVE+99TjOvYdQ5QTZgyUM8S2G/e4kVe6PPDB/ny0/QMLfjGC4CqGGqPNGbDR2hQsns
         DQaBpYjDwFDqhp80jX4gI58zrf250ID6XU3o/mULjqqz3JZ8Cjn/3fXNBHDrW7wmyRvx
         vv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777015038; x=1777619838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ocRQwsGxmUd24plQscvID6P4Yrryzt44ghQQY2RzSsk=;
        b=f6A1m0ivalhwnf1z7lb5xBKwxO7XuZdDg7JzzD9rNdybjS1Hx6S4QvpgnOCd/ycinX
         njhpDHdftpKmoRjY6IDBUrgT4phiL03xAvkAmw006jIAKKoyN5S8t78pBoA2ua5wSP0F
         meLInc04Xaj+dhiAARKJQf3zYRxruczBG8S3jOuSPy/G3gugCc17Fo+01Ts6cyQr8nxn
         OvvqjKy2U7pyfnDAAYIdb2CpNiMXDr9LNZzolUph+AmxDqS48x63Nq3hBivEthK9t2+K
         6ARZBY0lwSwGkzg7eMVa9oZEi3s0RSjTyvO9e0CHWZaIbYrGSzGAyw15sE2Mq7P13V4b
         Mo5A==
X-Forwarded-Encrypted: i=1; AFNElJ820A6WBvGnjV6EXx88yP6w9cij13RgaCo7hQ3KHuzlg3MQlzCs8/HAN5PwQEFgbaqQ+3tGLHjMfWyT@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCb2iperBgxIur68UUjlcYTcW93JUktWYKrZe+9/GKqee0ihY
	WzLfCEZ1+40LmrcVliuWeK6D2lgUdBi/gcxC2isOOR2rjfRjoUtk0e+O7G+pD7ZB1NTfy18E6vp
	rL/DdQnoL7RSjVcUxqEPHxZPtZWvQ/E3rZyHHqjFu5re4rWnQTd5Hb1pgxk9T6QAXr3G/DgIQGp
	5nZdMbznwAv+8wad1WHEhqbZF/pfaEoARMNRE7Ig==
X-Gm-Gg: AeBDieu2bUOD26jFZDlDlUrkadiFKuQqHoWZbBfyoiLPe8oCKsfMt+oinov+7gNpDVO
	wPWL0UuJiGTfrzMhBJUqn6SHFycWJO1W+Hdmj1Blr05BW9ZAP5Dp6iPS8ovbNmjLd9iONsKRiuO
	vaHqbkO2Y681NzwlGwxytU62vMsKYrOAY7KsGMp82hfSGmRJYX/f0cDXsWQMOdVAehpJ8cU/nN+
	0KhGwpzQ8BGuz/p
X-Received: by 2002:a05:690c:2701:b0:79b:cf31:9767 with SMTP id 00721157ae682-7b9ece638bbmr313691437b3.3.1777015037630;
        Fri, 24 Apr 2026 00:17:17 -0700 (PDT)
X-Received: by 2002:a05:690c:2701:b0:79b:cf31:9767 with SMTP id
 00721157ae682-7b9ece638bbmr313691117b3.3.1777015037197; Fri, 24 Apr 2026
 00:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com> <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
 <CADSE00JJq6fsYbkFN5hBD=-ZWsFG9p4_C55fp3MupMJQj0QCUQ@mail.gmail.com> <8a9c125c08206296d698c79c3d3dd6aea36a7e3b@intel.com>
In-Reply-To: <8a9c125c08206296d698c79c3d3dd6aea36a7e3b@intel.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 09:17:05 +0200
X-Gm-Features: AQROBzD6yZWbejVMF7ldH8G24-m4djSD1N4zfjIlQ_Qh0r0EH3w2r9AAFZGj5x0
Message-ID: <CADSE00+b-8moX5FkLjLs+wzyaW5dtJDMxvTT6Gu-QmDoDxJdVA@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Jani Nikula <jani.nikula@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Alessandro Carminati <acarmina@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 1:51=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Tue, 21 Apr 2026, Albert Esteve <aesteve@redhat.com> wrote:
> > On Mon, Apr 20, 2026 at 4:47=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Mon, Apr 20, 2026 at 02:28:06PM +0200, Albert Esteve wrote:
> >> > From: Guenter Roeck <linux@roeck-us.net>
> >> >
> >> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tes=
ts
> >> > intentionally trigger warning backtraces by providing bad parameters=
 to
> >> > the tested functions. What is tested is the return value, not the ex=
istence
> >> > of a warning backtrace. Suppress the backtraces to avoid clogging th=
e
> >> > kernel log and distraction from real problems.
> >> >
> >> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> > Acked-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >> > Cc: David Airlie <airlied@gmail.com>
> >> > Cc: Daniel Vetter <daniel@ffwll.ch>
> >> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> >> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >> > ---
> >> >  drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
> >> >  1 file changed, 14 insertions(+)
> >> >
> >> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm=
/tests/drm_rect_test.c
> >> > index 17e1f34b76101..1dd7d819165e7 100644
> >> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
> >> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> >> > @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct ku=
nit *test)
> >> >       const struct drm_rect_scale_case *params =3D test->param_value=
;
> >> >       int scaling_factor;
> >> >
> >> > +     /*
> >> > +      * drm_rect_calc_hscale() generates a warning backtrace whenev=
er bad
> >> > +      * parameters are passed to it. This affects all unit tests wi=
th an
> >> > +      * error code in expected_scaling_factor.
> >> > +      */
> >> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> >> >       scaling_factor =3D drm_rect_calc_hscale(&params->src, &params-=
>dst,
> >> >                                             params->min_range, param=
s->max_range);
> >> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> >>
> >> Would not something like:
> >>
> >>         scoped_kunit_suppress() {
> >>                 scaling_factor =3D drm_rect_calc_hscale(&params->src, =
&params->dst,
> >>                                                       params->min_rang=
e, params->max_range);
> >>         }
> >>
> >> be better?
> >
> > Since KUnit already has a few macros in its API it didn't occur to me.
> > Good idea, I like it. And I guess the scope approach matches well with
> > your __cleanup comment in the first patch. If no one opposes, I will
> > work toward that pattern for the next version.
>
> There's a catch with kunit and __cleanup and thus (scoped) guards. Kunit
> runs in ktreads, asserts lead to kthread_exit() and the __cleanup won't
> be called.

Hi Jani,

Good point. In this specific case, the actual cleanup is handled by
kunit_add_action_or_reset(), so __cleanup not firing on assert is
harmless.

>
> Warning suppression being part of kunit infrastructure, asserts can and
> should end the suppression too. But setting the example (scoped) guards
> are safe in kunit tests in general feels like a trap waiting to happen.
>

... but I agree it sets a misleading precedent. I'll stick with the
explicit start/end API, then? Or maybe we can clearly document why the
scoped approach is safe in this case and use it.

>
> BR,
> Jani.
>
>
> >
> >>
> >> Also, how can you stand all this screaming in the code?
> >>
> >
> > Again, KUnit already contains many macros, so this use didn't register
> > as such. Now I will not be able to unsee it.
> >
> >
>
> --
> Jani Nikula, Intel
>

