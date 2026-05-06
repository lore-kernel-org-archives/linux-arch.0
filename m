Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDD3E1CF8
	for <linux-arch@vger.kernel.org>; Wed,  6 May 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056675; cv=pass; b=rOAe66UBKa+8BO3csJveL+k6TLRvjwC+gKBLfVfrQnJ6JTL3GpzbYaQ+IOXUAGmUCk0jGAssp2FC38MtmM2u8x4w27Unw+UA80id9uBzJpgnVtzp0rvkZ1GMKy9300DGL6g2A3GgSAopsI1gZMwGcb28Bxd1NmeDyywg/MCrSdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056675; c=relaxed/simple;
	bh=BQ/L1Adqk6o4OdG6nxv5nzheitk/VkCmyj3eyJlGF/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gyf/DSY23mhJa6ia3mCFlxESBVCE6lk0ZaZeUx+p4xF5H3gFhFhzL2+tprURMZlE1EuN3V5ahBylK/oZ6jSHelOySE+/JLLEfmDnmkrxA/UX/N3TS1tqB9qTJqVpcdDHnHg0aBYy+hta+4Ds7qOucw4i9JE4RDcWHvIBRf2q0c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUCtbXAI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TD9P15l1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUCtbXAI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TD9P15l1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778056672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMA+C0TJi4LM3UTvwkCroeu4Tv8AgJe8bHK3v1p/l2E=;
	b=OUCtbXAIom0lydhN+lO9z+XtYHlZR6wu9cdq5HmSfK7CnJmXsciTN8Z3v02qLumj4DI2id
	OFfliZaXwRqboOidSL8DG8FSq3zIeVC+zGqsDIcr5AbjoaZn8D+b1L/0E0TUJhM4l78YbY
	/rSWyMCExd/9MblSpzuuY17E1n7ino4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-7eB-1XtuM_aOGKjhbU1pdw-1; Wed, 06 May 2026 04:37:51 -0400
X-MC-Unique: 7eB-1XtuM_aOGKjhbU1pdw-1
X-Mimecast-MFC-AGG-ID: 7eB-1XtuM_aOGKjhbU1pdw_1778056670
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bddefed204so30984647b3.0
        for <linux-arch@vger.kernel.org>; Wed, 06 May 2026 01:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778056670; cv=none;
        d=google.com; s=arc-20240605;
        b=coekFeMkiCkJW//+jl1QZzgniEE+DuYqvfhvjGiBZ8nftNblYl4tGMhWbwme29u8y+
         ViFqqeFqOvNh8wP+vdu0ycwEaXa3v8N+1CTF2y04wT3TJPezN89AS/WJ7WDjNMFsmf4+
         3L9RM4vTnEiQ0msnkjqAx/jtR4iZXjz0PmG2JwJ9osg4AMOsT0cjo6272sJF/1clMZk0
         l22VjYkYBOZoP0vveHYN+Ie4NF9snDvFeGuTIl4sHHw4iSsWjx/pXjjvSNvFhBNEQY4J
         H32v9eC593gL4IDopPtY2nLeLJWx+Hz5SBQd2pNGsmrUqZs2vZh1vJjaB6rqc/Sw3Iwu
         wbaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMA+C0TJi4LM3UTvwkCroeu4Tv8AgJe8bHK3v1p/l2E=;
        fh=gmUufC7cmvvva4YaoS7AoGmCya1oLWzX3FpbZa7d7ak=;
        b=h2KRdi6Ie69hmIYVBZxibbdKc+1/0xv02RfykMo5nLrl3JWP75cR7g+yAXx/cNZGSc
         DwQw7qlmeNUkrTtYsApdFwy4qRDGFLUDrJdv/toumv4l3NyLSLp58HWWMPCVF7GBk5HL
         enOCQTEzo3tR2dDH22tsI7lXSaBPgmk7FUV/h2ABaCOdLnLZAdCvo5YCTSjx81OSuKVp
         j5jsk88RjgS2GACrnq/VkOUB519j4hrCU/s8loafRqPgmVBHzsW7ucFFxv7yveWiNp1k
         9DdAM19U4YUdTHYia/WvtnG8kbiL9iak9rksK3hLBPvsfpqH9NDV+zuolKQuf3KIXK1S
         fwEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778056670; x=1778661470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMA+C0TJi4LM3UTvwkCroeu4Tv8AgJe8bHK3v1p/l2E=;
        b=TD9P15l1ROTyURydBJ4R92GsG2crGWwJkzYBvRLVACF97Sj+m07fa4Pl/NxCUZM32A
         ov40m9JuAbs7Di15LYBMUkbnliutrgieUbhml1Hg7wT9UUunJ9Sv2FXpI8/kUjMVJmwd
         H2lccH89lvr9s0lAvpwbf2bNr1xd7JHanh87sJkGHNxLggZ3PBy3ZqQAOFtH03wcyuBR
         G38KItKk8HZx/AaJmO44lIz27gpLAIqRscjkIz/vxyhKdpnUWnosqovbs2A38vPjNYDY
         d04jYGQIXc5zkpCbT38ugrPmoZZ/joGkjvKM+Sgg1Z9PdXJcdcmPtRPDF6Bz6SLMvoCL
         l+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778056670; x=1778661470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMA+C0TJi4LM3UTvwkCroeu4Tv8AgJe8bHK3v1p/l2E=;
        b=JXXxjRM035fIQQqLgk139XJKw1esVd5CMOp29h4VpbXTooZnooZqPvpYwiIiZ4jiHf
         kgg/Sa1KO2m0ryI0P0z2LuGUa0fPBUjg7kLTrpk87RSz0xG4oobufJomt7nD/kcZALoK
         vjP2kkLUW7S/SD5XGjK6yjCXKE9uVP1oPwP6HjBrcRVbTRY4eLjqFxmUJJaX302elez9
         DEPY82JV1xdB1br1IImJWMVNXoo7e6WZtoMTvO0wamA8g9XtCifylQ+8mkCkWaBmwlLt
         KLG+H45eFtYQrrRGTFJeIZ+NDLfyuVq6PArLzwX4/llEezNu9s0w9Xe+d8si5cJH3OqC
         FOuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g5A86JA62TlsybEzVKuw/LzuEccoJBBu7fRdP2sRBPIwze8TUae35eoFnEFvuZoVqETUUcFVVA3YA@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHJfdIc3Ecv9PFL+2B1dflQwVUwhra7QderbYETthNHpphbl5
	i1aco/Z0B0Xa/CdRpVGz6EmD0/Ai1TqsLpit9qaVuX9ah4p2sJh2cNz8VWo2WDaDK2WcLcUhssT
	mRBDcBLE4OWPNq8oQeBML5L6gBY86bEyzdgQIbLf7387apTRQvYqirFo8AJEnb3GkUbpHMHwdhF
	PbtZJaF8R6F6TXiVdfwYugO5EgNTb3d/Hs57X5Mw==
X-Gm-Gg: AeBDieuhZaD5yD/DeN//Gg5TB6Dzn4noZ2VKibKQRwqpva7s4CtnwQ4CqHbpOwiDqjA
	6c6bzSZycX5ztMmvX3HmFJgN/5+uanOme/295oJr/13U7oJaMmvvfzxCsM/lfBtqIA0AvOhQFD0
	px2zniXclV7aGeYMFX4owGLMN17XdhElOD/4JCLtSCAiE9b/PLMm71Kf82fI19F9gRyVZnOfQag
	p4bgXoEABg3QPyo
X-Received: by 2002:a05:690c:60c3:b0:7bd:696d:5137 with SMTP id 00721157ae682-7bdf5eb872emr28069867b3.41.1778056670474;
        Wed, 06 May 2026 01:37:50 -0700 (PDT)
X-Received: by 2002:a05:690c:60c3:b0:7bd:696d:5137 with SMTP id
 00721157ae682-7bdf5eb872emr28069617b3.41.1778056670063; Wed, 06 May 2026
 01:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-3-3e5957cdd235@redhat.com> <20260504-tentacled-free-lobster-38d8d9@houat>
In-Reply-To: <20260504-tentacled-free-lobster-38d8d9@houat>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 6 May 2026 10:37:39 +0200
X-Gm-Features: AVHnY4LGPM5httthyZYEMeSVpsAZZGIetxyr0Irj5BEH6JEFnHV4PP6tgxL43VM
Message-ID: <CADSE00+TPGWPjD7DGHy5f+=QzwUqYHc=X-G1sEER8=NS5VvV-Q@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] drm: Suppress intentional warning backtraces in
 scaling unit tests
To: Maxime Ripard <mripard@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Alessandro Carminati <acarmina@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 12:04=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Mon, May 04, 2026 at 09:41:27AM +0200, Albert Esteve wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit tests
> > intentionally trigger warning backtraces by providing bad parameters to
> > the tested functions. What is tested is the return value, not the exist=
ence
> > of a warning backtrace. Suppress the backtraces to avoid clogging the
> > kernel log and distraction from real problems.
> >
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Acked-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Acked-by: David Gow <david@davidgow.net>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  drivers/gpu/drm/tests/drm_rect_test.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/drm/te=
sts/drm_rect_test.c
> > index 17e1f34b76101..818e16e80c8f9 100644
> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
> > @@ -409,8 +409,16 @@ static void drm_test_rect_calc_hscale(struct kunit=
 *test)
> >       const struct drm_rect_scale_case *params =3D test->param_value;
> >       int scaling_factor;
> >
> > -     scaling_factor =3D drm_rect_calc_hscale(&params->src, &params->ds=
t,
> > -                                           params->min_range, params->=
max_range);
> > +     /*
> > +      * drm_rect_calc_hscale() generates a warning backtrace whenever =
bad
> > +      * parameters are passed to it. This affects all unit tests with =
an
> > +      * error code in expected_scaling_factor.
> > +      */
> > +     kunit_warning_suppress(test) {
> > +             scaling_factor =3D drm_rect_calc_hscale(&params->src, &pa=
rams->dst,
> > +                                                   params->min_range,
> > +                                                   params->max_range);
> > +     }
> >
> >       KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_fa=
ctor);
> >  }
> > @@ -420,8 +428,15 @@ static void drm_test_rect_calc_vscale(struct kunit=
 *test)
> >       const struct drm_rect_scale_case *params =3D test->param_value;
> >       int scaling_factor;
> >
> > -     scaling_factor =3D drm_rect_calc_vscale(&params->src, &params->ds=
t,
> > -                                           params->min_range, params->=
max_range);
> > +     /*
> > +      * drm_rect_calc_vscale() generates a warning backtrace whenever =
bad
> > +      * parameters are passed to it. This affects all unit tests with =
an
> > +      * error code in expected_scaling_factor.
> > +      */
> > +     kunit_warning_suppress(test) {
> > +             scaling_factor =3D drm_rect_calc_vscale(&params->src, &pa=
rams->dst,
> > +                                                   params->min_range, =
params->max_range);
> > +     }
> >
> >       KUNIT_EXPECT_EQ(test, scaling_factor, params->expected_scaling_fa=
ctor);
> >  }
>
> For both I think we should add KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT call=
s, no?

Hi Maxime,

It may indeed add verification value by ensuring the call actually
generates the expected warning.

The original patch did not include count checks on the version I
inherited it from (i.e.,
https://lore.kernel.org/all/20250526132755.166150-5-acarmina@redhat.com/),
so I kept the same approach while adapting to the API changes. That
said, the check is simple to add, so I could include it in the next
version.

BR,
Albert

>
> Maxime

