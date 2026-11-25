Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599663;
	b=DgrasGSLR2sl0TxBgT4Cd2GyGJQtU/jkG/Zhb1u6eRJTfhqtBuumgFzTl5ZuV0r86CTi
	 w56eSpOgMFzc6855PU/CBqMoO4XE7y2kcN8Ktl/nAyI//gZMsy3xDAnJox3H45/xwGBT6
	 AQLfNTCzrPwNsqIEpOXFwfjqwgwSh/ksGPM+BP3135g4s6JkVtYTNtWjVbA52SdYmBSfR
	 p+Lt6WgS+zyUQIRbjKYKSQWH8SgcU04gGylPaaqBud92lcE9puhWOJQ5ss0TXfNy4ngci
	 e+iHcfkyEmIdx7PtqLYuZgyE8EVFuA+UvJ4IHPjIifBfHAQJr3hyUuvG5tE1oYUmNjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a+QvvX1J/45GVD+nOsmA65+xntAc6mMZyDzh90koLlc=;
	b=KGHzkLL6vf2CjPj07UczcQbKSFlHQbOWfnjQZPh6nNer3M1n1SOLAj+sc/dj/slnswnQ
	 wUV3x6qrr0EwJl9oCo5yPMCQT/C64T8qYSvZKAp43W3oF4xtEMKu1W9lZ5lIKYBNCxAPW
	 jyY3bvyZb6TKAYA0H07RiiEtRc5QqryO6mZslzmImX7+M1paQL5Jx7ORGIV66fXyjRD1V
	 /19vUcZxyoFBkulzWhlBSMRce7LghUljeV7Xhn/tWzPJtO6ULqBKcv9xBSv1MZFRgGcV4
	 zASZr857yuYJlV0vv/pVuVcFyiYtJQDjBNg9BXvLa71EgaVlKUF6QMVsxHa+kj9pm8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GJ1QD+oF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E82606A331
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63E82606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GJ1QD+oF
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so56525025e9.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 01:41:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795599661; cv=none;
        d=google.com; s=arc-20260327;
        b=AcPSF5KSFsVJ+5LOE5j11AUlJlHIoFwvP9W4blyvBtlshobqUX70Cmk+/QAoi5YJyi
         4HqJMbvLPpAnXxNQu1veElHpGygkjCcfAS9BhBBiwNfyusnWLq3iaelazFIOTN/KrV5q
         qAzz4W3CpdSbXm/p+jy38emiiLCO9ZKb5yNcYMLx5KAH/hu0o/GtUb2RHy5tGC+dg5E4
         GLd80gJ0pK3zgnKHdfFWf8Tj/XZlDSREIrlsNSRZnAQZM0oC1/APoK9ElR449JD33E45
         0ihSv30oFMRCXTIXrnN1k2eGXICGBYquF/67vFT++gEtgetA0J31u2Un5h4SQzAXIVqS
         NaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a+QvvX1J/45GVD+nOsmA65+xntAc6mMZyDzh90koLlc=;
        fh=UiYKoyAQKx5MxDSQohdxkn6zCLz2wLzFTKDIe7LKKNc=;
        b=S8fc8nUHNW5FJPHsB0MfIwqokwam7Os+OTmkmb0LNn7FDryYh66F6bnXN0Otmoqn0X
         cN8bWK+CzDHUTVEMRXcb1HOotNns0eMLXGBU4uE8iNUFidfdBYHuD5s+fZQRV4YORnLX
         Ce01egBwQ1/0Kg7IbTWU8biMDqeREhZBLwQSITt6r1wOnrgQDcU6AfLn3S+bj9b1jVbT
         4NyNAUyGktovMWTsbUOnBNuiDq29S4Y5F/przVTFuYdtWjSIa3mGjF6xxBv94jsYZhYx
         t0AUqA+JU5xufGm8pRcxoqiCwk7OHq6rHIk3lnLAmyrqIdFAJRUeE7zjxZgboUofXyMg
         WnWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795599661; x=1796204461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+QvvX1J/45GVD+nOsmA65+xntAc6mMZyDzh90koLlc=;
        b=GJ1QD+oFh8SkRWfo+pbs/f9JnMVUt+HdqnKSkFRyIzWSczlekD3SaAbGo7PxJtz2Zw
         0zBG98WZKe3bglm2YxEz6NCauA607kV+qhgjcQJFsswK3Hy6A+7gaOYUp5AwwpROsdZC
         KD9cXtu69YEr16otz5uxYwX01E5QMuZNmC1iey3momSm4cGJI5lPn9Z65P+Vca314Z4Z
         5K4anX9tuiYqEYe7sUd/BIhipvDK3rzqevSKjheTko8ZIQf7ETsbBL+LCV8kWJY6wiwc
         /K2YWBuAQ6DawVVZhDpqkfiKXre5+EcUP2W+HsWf9YSp6qHrSF/cBvAJWQgF4MhY0RSw
         bf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599661; x=1796204461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+QvvX1J/45GVD+nOsmA65+xntAc6mMZyDzh90koLlc=;
        b=gaN08eC1oGJ4+A/nkijVvq6yA+7Y9GlX7+yaaLQMKrrs1tRKx17KawV7BOXvL2APVP
         xXQxw5Gqvrou/hXAg8Ek9JbUa2QYTo2WVx/CzSZiA2Xvpb9sfknL/MHSh1+aPkr10IKS
         tWeVRFHTDC53TXXTLP1IiRV31KOkQaX/Dn1Hm5aa1Bi64w7wmQ5n3MQ9hNbh8jkMMzfv
         0lx9s00pIP+s7FXE+xeYvXqTeNoMLo4RVkLuKNnFdwDhD1v6vrDZOvAHDraLBZqvjlBQ
         Ffy8FuSr6f+g5wth9gaZ4Nw1Wp8hR/9s51aue7a1uZmQFILLMtXhtTON8eSyGJsJooks
         i7bg==
X-Forwarded-Encrypted: i=1; AL+hErFK/U1FvWNoeyhNH/ZZH97U2F7O8/PunzDindWmjWWCPnWY/IFkI5AZMDIw58kqg3qau5u/BP+Kh5rG@vger.kernel.org
X-Gm-Message-State: APuU4Z/OIH8sZiYXy+7RMNHCJ7Kv7Wr6xCukqCI5PUvRsQW25pSY/kF3
	YJ34a2vOQm4JKkCicuKg3N2z0Zh90I3WHuRRwxLnwiJt4PD2xLcvDSugrHhUx7xf01ItI2VFmjB
	qr+cyZMG4XCZu8D/WVPcDSA4R0JJktE0=
X-Gm-Gg: AZFdTZd8ov+Q6jSszVgEEoE4IjoMlriw5ZHBcIrPIss86puMAI1VmJAkYCP6L6qWDf2
	qeYp1F6tUX+gjdHQQsBi9IC8QrV3TVa7J1asVF99P0xnDKcVwezvvD7neKms3u4XMVWbmV0uUxY
	Yb/jq04jfMxu0FrHyT/tbLH4VebwIIv2DEP+e5tGlQj/AssciqhSMWItexwwuU5et35Uolz5nlC
	3QvoujtfpiYPEIhiFeayN289LDk9wgeHnIYLCOPkexZSpuI8vS6+MZZ7iQEjsgdLy8hNU0d47fT
	Vt7ZUpLtLMZFOXmJKVdXrvch3q95J/vABj1y0g+kvCV2dBaxd2QVoKBTjz2D+pFAIuoISYbkiU2
	sciAWrIA9srpWkHmuB6TgW75RSygGlpW6kFukaiO+p1w6ujwvIWuDLZvfGZamx2lmc+74aXzvIF
	U2W/ktPBH3ljcF5qk=
X-Received: by 2002:a05:600c:4584:b0:4bb:6c71:b269 with SMTP id
 5b1f17b1804b1-4bb8881fbd2mr341861005e9.28.1795599660916; Wed, 25 Nov 2026
 01:41:00 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123135148.1146372-1-elver@google.com> <CAN_Opa_TKjDAWz8EQaw6ro=joymwurpcy-k_x=q4E6TLt6ZpUQ@mail.gmail.com>
 <CANpmjNNOVD3KVrau5KD4WzqxoMkZZoJCfdPzvjLmZsGy9zXBug@mail.gmail.com>
In-Reply-To: <CANpmjNNOVD3KVrau5KD4WzqxoMkZZoJCfdPzvjLmZsGy9zXBug@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 25 Nov 2026 17:40:49 +0800
X-Gm-Features: Aa3M54oTDKYDq6kmOJwEfEHGGc7qMp6rlREKg1yxsT880KhszTaPaWfsNoxdMeI
Message-ID: <CAN_Opa9zKzSptpNOnCzaW_EK0oT=HDDVoJxy5Q0crM+6b9bR_g@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
To: Marco Elver <elver@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 6:24=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Tue, 24 Nov 2026 at 10:54, KunWu Chan <kunwu.chan@gmail.com> wrote:
> >
> > On Mon, Nov 23, 2026 at 9:51=E2=80=AFPM Marco Elver <elver@google.com> =
wrote:
> > >
> > > READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() identify accesses to
> > > per-CPU data that are intended to race only with other contexts on th=
e
> > > same CPU. So far they are plain READ_ONCE() and WRITE_ONCE(): no mark=
ed
> > > accesses involving them are reported, incl. from other CPUs.
> > >
> > > Make the new accessors assert exclusivity but ignore same-CPU accesse=
s:
> > > READ_ONCE_THIS_CPU() asserts no concurrent writers,
> > > WRITE_ONCE_THIS_CPU() asserts no concurrent accesses.
> > >
> > > For KCSAN to ignore racing accesses from other contexts on the same C=
PU,
> > > introduce KCSAN_ACCESS_THIS_CPU, which makes KCSAN keep interrupts
> > > disabled while the watchpoint is set up.
> > >
> > > With that, any racing accesses (incl. marked ones) from other CPUs
> > > involving READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() will be
> > > reported as "KCSAN: assert: race ...".
> > >
> > > Suggested-by: KunWu Chan <kunwu.chan@gmail.com>
> > > Cc: Thomas Gleixner <tglx@kernel.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/asm-generic/rwonce.h | 22 +++++++--
> > >  include/linux/kcsan-checks.h |  1 +
> > >  kernel/kcsan/core.c          |  6 ++-
> > >  kernel/kcsan/kcsan_test.c    | 90 ++++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 114 insertions(+), 5 deletions(-)
> [...]
> > I tested the patch on next-20261123. A 60-second rcutorture run
> > with strict KCSAN and interruptible watchers completed successfully.
> > I saw no reports involving got_idle_tick or tick_nohz_handler.
> > There was one report involving move_linked_works / queue_work_on.
> >
> > The latest KUnit run with kunit.filter_glob=3Dkcsan.test_this_cpu_* gav=
e:
> >
> >   local_noreport: 7/7 passed
> >   remote_write:   6/7 passed; threads=3D2 failed setup with -EBUSY
> >                   ("rcu running")
> >   remote_read:    5/7 passed; threads=3D16 and 32 failed
> >
> > The -EBUSY log shows that rcutorture was already running. The
> > remote_read failure at 32 threads occurred in both runs. I'll
> > rerun the KUnit cases with rcutorture disabled and check the
> > console for the failed cases.
>
> Thanks!
>
> > One test question: should local_noreport skip when interruptible
> > watchers are disabled? In that setup the ordinary watchpoint
> > path already masks local IRQs, so a pass wouldn't exercise the
> > new THIS_CPU behavior.
>
> The test will pass in both configurations, so a regression in either
> would be caught. Disabling is not necessary. More coverage is always
> better, even if it may not seem useful today.
>
> Thanks,
> -- Marco

Hi Marco,

Makes sense to keep the test in both configurations.

I reran the three new KUnit cases on next-20261123 with rcutorture
disabled, using the same image with interruptible watchers on and
off.  Both runs passed all three cases at all seven thread counts
(21/21 per run, no skips).

With watchers on, I checked the console reports for both remote
cases.  The two accesses were on different CPUs in each report.
The earlier -EBUSY and remote_read failures did not reproduce.
The separate 60-second rcutorture run also completed without any
reports involving got_idle_tick or tick_nohz_handler.

One question about the IRQ-off path.  A local NMI can still write
to the watched address while its KCSAN checks are disabled.  If
that changes the sampled value and no other access hits the
watchpoint, is an unknown-origin report expected for THIS_CPU?

Tested-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu
