Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F639A818
	for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760182; cv=pass; b=MT989gkWD0k3jpbjh89kN4mAGztezJ0Z1riE84xGTl7ueJFpQqUtZOXBvsdKy/PC/o41QVs4F3s2xGHRnXCtdsNzpUaIPdd9kltSEZ8CgOQL3OW3Bjo5io+q0k/5uAdAUOUuwaLOzXaGmDSGDbe0/wQecbx9Co2DHmaTSlUGSfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760182; c=relaxed/simple;
	bh=VmCa0w61OkMEnKKTodFxVw5pyBCXmkzpXCWn+msH7do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQLmW5U3TH4bSCbA/HcuI05h0yaAZL2eqJh/5EiZflagoRyU0jOrqDdpIh8CTSLjQVoTFJqfZp72o/wv5Abqm0TcE6g7PrVhaPFu21+3HgBpsvuZDnoVkh0HAeSSvh1kNibqKEkCGKplsr203iUriN50z7P9I3YFErF/twC0NXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEwYb7FR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmPllE2y; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEwYb7FR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmPllE2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776760181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXqQRpSCqQOtcTUUEwDGStAcdXKp+wcloKA3SbgGZRA=;
	b=PEwYb7FRt+Q8v/hFrNuHOsHV/Hq4aucoemwFBGa41mrqSpKqVoG0OOdkn346cUosuaSejA
	7lxVSWvQD1aP6Huelgkc5QsjDOFNp55EsCfb+tohRLz7lrgsfFNWlYhQrhjKy/YnvFH/Q8
	e2Oj/8qLuVTFX08RmImpOTAaP2+apII=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-zZH1jm87NSKoRZom8tfZyg-1; Tue, 21 Apr 2026 04:29:37 -0400
X-MC-Unique: zZH1jm87NSKoRZom8tfZyg-1
X-Mimecast-MFC-AGG-ID: zZH1jm87NSKoRZom8tfZyg_1776760177
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7badeafe9d6so51814087b3.3
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2026 01:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776760177; cv=none;
        d=google.com; s=arc-20240605;
        b=IQXshyyzEF0ejBbcyKKwtaC3CdzYehwDVI0oPoJFHcUaOWoo4OcnBeKVE6FEPHQaGC
         kIrHPad2J7snRrTV+ET/MwxjHlb38Uu7qLtzKCT+IxPzuFjux3uQB+5NUL1p5qJyRnve
         is9nwKJ8Fkd20KfAiyhGx08HBtaT9SckkPytplcEHsZ7wNezit554WzCzDTVWvOWG1y5
         54DkU0CYuKFPrHKymntb6A0EvNyfgajkV1YAnQbaJ84XgUgIJv30Vu8Z+9nIpyi1zqS2
         bLj+XecPGLEoICkObJE3GKBvhGh0zjg72pNOE9SoDa+QV0yON+o5jfrGbvja2brioW5+
         Mdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXqQRpSCqQOtcTUUEwDGStAcdXKp+wcloKA3SbgGZRA=;
        fh=6qlG7oWCBnOfjKJGnQJJN7Usvup4Rh0xeoB+XpQHj7Y=;
        b=KKeBHygb24S4QDVL8OyZaBA8hyJ0a0nTKmQ5bkfbGejYs3ywBT51I3tZESNoTSGwOi
         YPr1ffHsY5OQukcw156QEYE+rElheC4/3uJOu30obxSaaARwEVPBfZ9cVAoltlVQfk6G
         e1/FJyXmpcSQYl2pFfgwCBs2MqUsSMYP70qW/6w91683A1h/mpNEhoy2ucl5SyotUifm
         G8NBxkpY6gaqypujNPxZfr1WPtsXw1Y8pXHdw1pEannSqKIbhWavIC6Z6R+G6jHHi+z8
         SCM+O21USiiAhH6U1+qudOv64+XhWW76BbRA1VfsFFmr4PsjDEFNPfFqlApkf7vQsB4c
         Mu/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776760177; x=1777364977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXqQRpSCqQOtcTUUEwDGStAcdXKp+wcloKA3SbgGZRA=;
        b=ZmPllE2yqOnE4NFZUcU5mCDLTCf9hJPPseg26gDq4NdTSCqBYnqxuoYrTotCpQc2fD
         Kkidt50vpDEGCDwWwr3wDU5q1aavZPXhlBul/EmqkQmJhnvbLBQsMiLrCyDtr4VR7IRn
         24LoiPP2tm5lfkD2r9jruQelTLhvcIKH6pxhtqIgi3vQbjIc7JYlroCPUyIEK69NU4Oj
         Oq3RxiKLTEFOH9pbNudLSYel1UdWoOORRPBdG1RYESQdoVAa7d6Q8+jpbqxyBQx2nEL4
         iHtu8+DQGaff3KQBNbrXnP+3m/Hf4YFIE+N7XTCkR3Kt96H2swj1z/9EMhHTKmYbNBu3
         ZkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776760177; x=1777364977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXqQRpSCqQOtcTUUEwDGStAcdXKp+wcloKA3SbgGZRA=;
        b=sG5/Q5NZS5mCTrL5GPmcXbxmxfe0wpKV8o+1AzM3sviYT+oZke0tDPZxNnK7oRN3+e
         Fs5fMaV+MDnPl6nFKY0KkFO7GI1iX8kexxP+n4fn07QTU4jNxbCIae72M7J+G/rBCTRT
         NqMll5bJZ+92Mk1jaij0Avd1QD3sPlcJgLyWaTo1ZYqtyBPwOzw+kfIR2JkzkL0T0e+S
         GhjjAgMEHbdZydCXMRRBUkAqXf3XhS4FEKQKaGjkX9PYKtKdhge55HW+T8Zi6iZ9edWc
         g0ugI5K+YY+f5e5lNV3McnH/UtQjcvuMUtP3JCCIyaX0VR7FdNSNTKR6joZR58330Orq
         C3YA==
X-Forwarded-Encrypted: i=1; AFNElJ8wKj433LXEqUpxawCnLE3KvtaajLGipkUC0F0TkcrPWqBNSW9JYTXRKgapAFI0fLu7vuNvolyfvSkb@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkd+z8f32DgksgZsDfh1xzBo6Ybu8sXXce6baJUnYES5ssmV0
	qWDVr9LGY52IOH33PO+sd2ehGz12BYFTV7sMsk0AwYFyhlAb8lTmaWSOlTt2eY697xHxZhWyM3V
	KUN/fnIMEcwb3w+J85T+YWtN3iV0p0xMF+y5VTH1jijS+Rm0oupgY/0DCrHUwLHgFp9KLfpKDno
	H55Z+5t6eFT85tfcVstjn5yATfbX/Hr8egnqn9TQ==
X-Gm-Gg: AeBDiesJByZGppP2ieXdkNgs+lY0LIz+CYcOsUSjv35JXXWdt8ikCb2T2XAE1VZ9oPg
	P2i2E2Je1FFP5P4mLhVunFs7jrSJ15TjYPqVcjThl9LXMbYmDH9s6d1XtVmqcV+mMU5CRd0p1RI
	a9LW7A82yAP7fYG4cOqtOmyiCljvNN3WgnnirfaeUITH52lvEXSlBTWkza2Zn2VwXkSQkxPZILn
	PFoc4qD1ttCjfyW
X-Received: by 2002:a05:690c:1a:b0:7b1:d1af:4b95 with SMTP id 00721157ae682-7b9ed03ea4amr180130567b3.45.1776760177023;
        Tue, 21 Apr 2026 01:29:37 -0700 (PDT)
X-Received: by 2002:a05:690c:1a:b0:7b1:d1af:4b95 with SMTP id
 00721157ae682-7b9ed03ea4amr180130217b3.45.1776760176561; Tue, 21 Apr 2026
 01:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com> <20260420144512.GL3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260420144512.GL3102624@noisy.programming.kicks-ass.net>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 21 Apr 2026 10:29:25 +0200
X-Gm-Features: AQROBzAEAbEFlPw_UOBBc9Hp9GuZ76mdLqLO_-KNOSIDgp6-Bgs3Cp1G00-BX1o
Message-ID: <CADSE00KyJhzf_p1Z9qZ-PRi5_9pEhSxHnP5wy+kdxexB2a2scw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	Alessandro Carminati <acarmina@redhat.com>, Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 4:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 20, 2026 at 02:28:03PM +0200, Albert Esteve wrote:
> > +bool __kunit_is_suppressed_warning(void)
> > +{
> > +     struct __suppressed_warning *warning;
> > +
> > +     rcu_read_lock();
>
>         guard(rcu)();

Nice. I saw plenty of examples using explicit calls, but I had missed
the guard. Thanks for pointing it out.

>
> > +     list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
> > +             if (warning->task =3D=3D current) {
> > +                     warning->counter++;
> > +                     rcu_read_unlock();
> > +                     return true;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return false;
> > +}
> > +
> > +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> >
> > --
> > 2.52.0
> >
>

