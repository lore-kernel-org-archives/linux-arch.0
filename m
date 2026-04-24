Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF5C332604
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019151; cv=pass; b=Jo7l3EzvLZaW9VvPIS98TJioWp9lctnTS9jj6bkTs1elx38BUuV3hnjKyuj+xwREtx8U1CVtzC17OVSM6/fhxunINfoPP26qm1AFP/icXEGcKXwudMQzsbLlj7Ojl1ND+Ie5NKFMQYSPMtVb3XpbnLsKDMyR9V2skm2OQL4IzTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019151; c=relaxed/simple;
	bh=ziZKgHefNOY3Gp3E8pQl4CZg9AJ+Uc27sgzHHIO//Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keUn1KBHi1Fyn3eBDBST2/Ugi48Id/aFns4HYohmfAXvmT3ePBAUcI+5Jad2sY0Schp7YYgbcfGHOTqwx/bcQysAwhLaixcX6OSYlV1lki8M4mNUrYLUK3aG6wmCZVtGxdncH4KiyStWj2vyeLCuS4bw0xpXdutL6G9Fj6/4MGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+QfYMoZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=deBWnpGx; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+QfYMoZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="deBWnpGx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777019148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iddsQLueoQEOIJwe4Gfj6if9K+aRVWtEbx6BS4m334s=;
	b=F+QfYMoZTU7XcBwnUkuHimuQSmNk1cmsOvh+MiKcv3t0KpN0UAMF65B1qSun+ok+gF7PTF
	0bVDrcfMbVtz8sDVd72ySJKn0a+xfCmQzLOT2wNHZMugfINuNX4FuSfUHOnRE10PzSJ6Lj
	1a42bfHE9mZWpY3m1dv8Y5ZM0hohUW8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-dCA_JDhbPNKiZupxJ2dCpw-1; Fri, 24 Apr 2026 04:25:47 -0400
X-MC-Unique: dCA_JDhbPNKiZupxJ2dCpw-1
X-Mimecast-MFC-AGG-ID: dCA_JDhbPNKiZupxJ2dCpw_1777019147
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7982c466ee1so171991547b3.2
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 01:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777019147; cv=none;
        d=google.com; s=arc-20240605;
        b=NIx0UXHS846fFmSYKt5dhDLfe68yTiFBPlWryqeBVaYU7Ln0y2441pRvo3NsunAJjc
         5ajZ2D1PjBtNrTR9Owr74elvn3j9+Ui4sjGOGUq3UdOZlcPh83oZP7ObTcyeRsTNFpCi
         j8BC9z3oAuwf93Moq13M4YhrzumIBz4BHTCJ3yL5oTC6lBCQ6HGjmaNpiKbJyTAxVK6J
         Xr6qYWJujW+E0TGtlj8lW7bRd+Vt4uv6KyZHsuJ9HKwbf5WiVaVkQBQdD3Vz5VrPnyUI
         3+BOqmK1ZvbnyL5Vb2XJucmUQlEBnXGyvfkRBWR8IKCR7FLnPsfBC88RIwQ5suPglaiC
         zENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iddsQLueoQEOIJwe4Gfj6if9K+aRVWtEbx6BS4m334s=;
        fh=v21Sm5em+RXfvfibX5l8MAlpH+UJl9T3f5sjjYBBVuU=;
        b=jkpzyU6sNZg0HLUzdxs5VYrwu5t/3No9v82cncIv6NPwSDnH3GNtoyoZpZeYjHG5wn
         tv8CeahJWcrsKqMCMluil0R926b81HaQ99GCV4TkshTCD1GBqmJSPZs88TiveJaXWwdE
         LA432nvQx8X3h2rlG+LZLo1e4N2jSudjJfSrDAxmk4ksKec4kzvJiDcXry+N1jF4WFLm
         1cO6C6N1OfVgkvgoAZydnliloah5X5y3LZOy8TXUBlHXBBQkXXHdxrUPxn+5GMUWY0bz
         HQTvF68tql1W8lYtGEpQI92dVgw42g0zzZkzRoM5TxOoxEr6G64ltWXlj9VDjn+VQQMK
         kd9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777019147; x=1777623947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iddsQLueoQEOIJwe4Gfj6if9K+aRVWtEbx6BS4m334s=;
        b=deBWnpGx0TzWfxlS8DSa91QH8S002DvmPYTP0iJYDiNByDbx7SN1KA7NCE8TtUiJuQ
         jWa/njAZ6Cua/1VNAH+/mo5bzRF2aKtjwR00HqMvys81byY7UpI2i7KPN0RivXyMVjuG
         sOpvDj8tpT/Ji2qd/mIWBq2OnPhf1T/OBciNk7rTVO0r3dWluVColRAmYl3JtWS9SZkg
         V5va8JYh6qhsB6ohCv99Amo+iQxrbEZdBM9U2zngncnDNEHlTqwOpd6CBOzqun9wiULT
         jMqc+gf+wtIRRjKRluwRPZYvjZT0zvnt67t30aM8p6C0SCukoein+tby1bnr/s41JB2K
         qxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019147; x=1777623947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iddsQLueoQEOIJwe4Gfj6if9K+aRVWtEbx6BS4m334s=;
        b=E5Dk9N1lEVgbsTQOUSfqQJuD/KhGj/cqEvulaJ9Xz+PIB0mMVmrgKVb1OfCMrO6hdS
         TkJIY3FdCAKmC/L8fCDHl9PlXYkgcXioO+a7UU907UrJoMzTBiy0uVs+wF4JZBDLLwZJ
         u8BWagwctvldpdOGaDQ3Pssa2TYylzf6m67ttSJYNT5bTmT5ssgPgsSgU1qV4h5oU7f1
         bhvTe3ywggQyE3gDwI4NBqqntHdtRihxW0F5rxsOmQlP/3IbAKwNig8dAsTqEdTfjzdG
         yMgX8Qt5W5l1326X0Ywi57QZzu+Dq1IviNbaM/OxmMFoPOs/YLR0J7Wik+uJGqNd2/sT
         c3eg==
X-Forwarded-Encrypted: i=1; AFNElJ9+QpV351EdRm2Rrl6Or5w9GPMKGybMytPIY1Y8uYmN/znuaQ/+56540yfMu/2fASnDpoysZe/kx3v8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YZcFIYTRxoCeeC0YgLzDzA4Ou+/24gZYE0B0aQzF0yf5kO9W
	z28SZrwJBWNA+samM9dM977l8frC0MbyvqJzSzVVaK2sB7BkNxjeAHnOG9cNgC4zP4OJS9BvwNu
	i2JR+K90auGcYgWBuFPQfEss7JlvMkndqxMv5CbHz59XfR4gGrl2qwyXnYPvtZ5CIyBLvPrxLxR
	YzsQn3rjgJoeFNqX+PFrRUFTRYlZSqVXOSWdmWDQ==
X-Gm-Gg: AeBDieslUGUo3EddT8rYe2la4M+FXXjfYhgLhSjrk338xoHZ7HcfjatOiIoMca3SJjp
	uiBhIlK3sHlsjauEyc4lm3NH8FYfokpJYl+SajvOQOZLS1J6cgHyzK1Ypr5702SFXbufYMJlkkf
	TYfEdV9eJeaFTtbhiu5m6OPD6wxGmvSGm+g/n8EeS24xRtOYp9Bvsdu9sispHXru3x96L41rQrH
	KTF/9TP6W/7YWBI
X-Received: by 2002:a05:690c:9:b0:7bb:712:a74f with SMTP id 00721157ae682-7bb0712abfdmr142445347b3.17.1777019147033;
        Fri, 24 Apr 2026 01:25:47 -0700 (PDT)
X-Received: by 2002:a05:690c:9:b0:7bb:712:a74f with SMTP id
 00721157ae682-7bb0712abfdmr142445227b3.17.1777019146632; Fri, 24 Apr 2026
 01:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-3-e8bc6e0f70de@redhat.com> <6209f24e-750d-4a7d-ad63-1695f5fd1caa@davidgow.net>
In-Reply-To: <6209f24e-750d-4a7d-ad63-1695f5fd1caa@davidgow.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 24 Apr 2026 10:25:35 +0200
X-Gm-Features: AQROBzC8_2POWCOFYR1L1LoP_YwcAOa38lshWUv2qs6X6k9mWiut3V_iTEcCLAA
Message-ID: <CADSE00+Ch2QtfsjOcKRNXY9Au8sv5E7Jdd8Rhb2dA6ODu+EDOw@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] kunit: Add backtrace suppression self-tests
To: David Gow <david@davidgow.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, peterz@infradead.org, 
	Guenter Roeck <linux@roeck-us.net>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Alessandro Carminati <acarmina@redhat.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 2:22=E2=80=AFPM David Gow <david@davidgow.net> wrot=
e:
>
> Le 20/04/2026 =C3=A0 8:28 PM, Albert Esteve a =C3=A9crit :
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > Add unit tests to verify that warning backtrace suppression works,
> > covering WARN() and WARN_ON() with direct calls, indirect calls
> > through helper functions, and multiple warnings in a single window.
> >
> > If backtrace suppression does _not_ work, the unit tests will likely
> > trigger unsuppressed backtraces, which should actually help to get
> > the affected architectures / platforms fixed.
> >
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
>
> Thanks very much for including tests!
>
> Maybe it'd be nice to test that the suppression is disabled after
> KUNIT_END_SUPPRESSED_WARNING(). Of course, then triggering an actual
> stacktrace would be a pain, but maybe we could check that
> __kunit_is_suppressed_warning() returns false? If you wanted to be
> really fancy, you could test that it returns false on another kthread
> even while the suppression is active, too, but I won't hold you to it.
> Equally, you could try setting up a fake test context and ensuring the
> cleanup is called correctly, but I think that's mostly covered by the
> existing KUnit resource tests.

 Good suggestions. I'll add a test for __kunit_is_suppressed_warning()
returning false after END. The cross-kthread test is a nice idea too.
I'll see if I can fit it in without overcomplicating things.

>
> Otherwise, looking good. A couple of other minor suggestions below,
> which may require some reworking of the __kunit_suppress scope, but all
> optional suggestions.
>
> Reviewed-by: David Gow <david@davidgow.net>

Thanks for the review!

>
> >   lib/kunit/Makefile                     |  3 ++
> >   lib/kunit/backtrace-suppression-test.c | 90 +++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 93 insertions(+)
> >
> > diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
> > index fe177ff3ebdef..b2f2b8ada7b71 100644
> > --- a/lib/kunit/Makefile
> > +++ b/lib/kunit/Makefile
> > @@ -23,6 +23,9 @@ obj-$(if $(CONFIG_KUNIT),y) +=3D              hooks.o=
 \
> >
> >   obj-$(CONFIG_KUNIT_TEST) +=3D         kunit-test.o
> >   obj-$(CONFIG_KUNIT_TEST) +=3D         platform-test.o
> > +ifeq ($(CONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
> > +obj-$(CONFIG_KUNIT_TEST) +=3D          backtrace-suppression-test.o
> > +endif
> >
> >   # string-stream-test compiles built-in only.
> >   ifeq ($(CONFIG_KUNIT_TEST),y)
> > diff --git a/lib/kunit/backtrace-suppression-test.c b/lib/kunit/backtra=
ce-suppression-test.c
> > new file mode 100644
> > index 0000000000000..2ba5dcb5fef35
> > --- /dev/null
> > +++ b/lib/kunit/backtrace-suppression-test.c
> > @@ -0,0 +1,90 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test for suppressing warning tracebacks.
> > + *
> > + * Copyright (C) 2024, Guenter Roeck
> > + * Author: Guenter Roeck <linux@roeck-us.net>
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/bug.h>
> > +
> > +static void backtrace_suppression_test_warn_direct(struct kunit *test)
> > +{
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     WARN(1, "This backtrace should be suppressed");
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static void trigger_backtrace_warn(void)
> > +{
> > +     WARN(1, "This backtrace should be suppressed");
> > +}
> > +
> > +static void backtrace_suppression_test_warn_indirect(struct kunit *tes=
t)
> > +{
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     trigger_backtrace_warn();
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static void backtrace_suppression_test_warn_multi(struct kunit *test)
> > +{
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     WARN(1, "This backtrace should be suppressed");
> > +     trigger_backtrace_warn();
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 2);
>
> Would it make sense to test KUNIT_SUPPRESSED_WARNING_COUNT() more
> thoroughly here by checking that it's 0 before any warnings, and
> checking that it's 1 in-between the two warnings?
>
> Of course, the first case doesn't work due to __kunit_suppress not being
> defined, but if the implementation changes to support this, let's add it
> to the test, too.

I thought this was a test gap when you commented the limitation in
patch #1, so I agree to add more granular COUNT checks once the API
supports it (which it should after the rework to expose the pointer).
Thanks!

>
> > +}
> > +
> > +static void backtrace_suppression_test_warn_on_direct(struct kunit *te=
st)
> > +{
> > +     if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE) && !IS_ENABLED(CONFIG_KA=
LLSYMS))
> > +             kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE or CON=
FIG_KALLSYMS");
> > +
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     WARN_ON(1);
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static void trigger_backtrace_warn_on(void)
> > +{
> > +     WARN_ON(1);
> > +}
> > +
> > +static void backtrace_suppression_test_warn_on_indirect(struct kunit *=
test)
> > +{
> > +     if (!IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE))
> > +             kunit_skip(test, "requires CONFIG_DEBUG_BUGVERBOSE");
> > +
> > +     KUNIT_START_SUPPRESSED_WARNING(test);
> > +     trigger_backtrace_warn_on();
> > +     KUNIT_END_SUPPRESSED_WARNING(test);
> > +
> > +     KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);
> > +}
> > +
> > +static struct kunit_case backtrace_suppression_test_cases[] =3D {
> > +     KUNIT_CASE(backtrace_suppression_test_warn_direct),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_indirect),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_multi),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_on_direct),
> > +     KUNIT_CASE(backtrace_suppression_test_warn_on_indirect),
> > +     {}
> > +};
> > +
> > +static struct kunit_suite backtrace_suppression_test_suite =3D {
> > +     .name =3D "backtrace-suppression-test",
> > +     .test_cases =3D backtrace_suppression_test_cases,
> > +};
> > +kunit_test_suites(&backtrace_suppression_test_suite);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("KUnit test to verify warning backtrace suppression=
");
> >
>

