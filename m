Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795784991;
	b=sHYMVkFSQU0OPsvm7XoRrhM4ozvD0IAwTAs5nPjIDbJncmbGkk2a7pmIDnbt/QuRYN0p
	 nAPF4/jwhqgYVLUXDBDzwBaHDYBgF+T4xF9GvsCOQoBA6BYVc/7IRJORZFevgIo4eYIL3
	 FRayEifxdNiR0eqe7Rbpczy6/cVL52r/fOc6L/0vbbgzZPzDV1nBPoc2wZrt7Yh1iWpxp
	 IlC3PabELvzM6di8N/6wvk3IFm7QkCM93Q+FHJrk5Lhm1kEWzSsTQOxagg1JBx/3DmIhl
	 c1UcJG6/p1OP8HGhvSKYC/br3/9iBhCQpLen8/2Y0BaByvIA4xL+i0aVSMEl+d9z2hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Eogd8k2r4l6L3snwOgsY9XYxjjhni7gOzREbmp7dwa8=;
	b=lYjc/i22YAUyym3G4nNILesLQIqvdIj/KLgq5AAQb4blmtX4wLXzoDeSWjU5QFNyfevo
	 RBUITKkrk3ru2BlueNH8qqf3wtBbsz3M9XV0H8dcBcu7Ht/26GLG3sbfVEzkmVPLi+Sl2
	 Ip4y9zrucBS2xnR674gnxk7O2lMwn257ZVNdBofvjeKJR/GIUErlGUtndaROiqB5kvkQ2
	 hWcDCRwT7nm9wt2vhjL136wnA6/HqMQJB/te9vfA6s4WB07h0XK0FE5d9Iy7dTsh6uziJ
	 96VB+bpjcs8sMotRmBansFq4S7ozXbtyKWhQBZa7Fw/Ib1DDm+eJsmQtvK1NgmSco+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GBJbHn8R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B4606A324
	for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 13:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 335B4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GBJbHn8R
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1aefd1bf74aso4487700c88.1
        for <linux-arch@vger.kernel.org>; Fri, 27 Nov 2026 05:09:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795784990; cv=none;
        d=google.com; s=arc-20260327;
        b=ms2YuVHGHQ7LJQk3Aa2IRK1afE5Lh1WV5Wy2gCOOEGd0ZrGWb17hw57Qh3paCdAktP
         YAIvMeWZPgdYEWUsdMOA6KcaHeH6pn+uzlTBwP9TITNUHCzR5LgsxIiBw0jewbgmGK34
         GUKHFDUdE+SsQqeEio73YZhMidNSJfrTjpwhM2LKbh4vWYmaINCp35hjcvM/GdgWmw4a
         7+MGZdeg9zRrlqAwQLoxCPIV6b3FgWR/XI7fW0HPfJVASu30hRisQ8rhlxxRrT+GkzwZ
         TTKvhSJxr8rNDBuio+6MGQnXXYcGfJ0hl4sNJm1b2moJgrLd2eT+8AwbcsKdgUhjYoP4
         N7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eogd8k2r4l6L3snwOgsY9XYxjjhni7gOzREbmp7dwa8=;
        fh=wdlUZX9h6FUFYskEmopOPw6sOTzSKEP1bngZ6uZbPyM=;
        b=AvYrf8SNI56ElnA4Qn5B3NHcdKbeHTXY6+qWOv2xhwL2md4Mz49ag+czFZHxA2WAD0
         MfeReAucAG5xB2y6s97nzu2qPcH0hXYcLzU4Wqdwz6DsasaFKquYGPUXPAVrLowIVgx9
         /sVY09vacqyQUp8rtvRHYjChr3YKiw987RpZwT2OaCdIhw5pMddYFQ+86nxVoYklAgh6
         ITRhEohdMePZxh3Y4z/Jex4G7jsuPpx6JGjbLvakzLZe4N2BRHJRqVdn4Jy29efx6Csk
         xr5ik0+n0QlrQ4lAr+Nplxmdg3a8D6OqI1IijIz7pv2hx4dfvzuFn5HmL6K5g+7cHNcP
         ws9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795784990; x=1796389790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eogd8k2r4l6L3snwOgsY9XYxjjhni7gOzREbmp7dwa8=;
        b=GBJbHn8RdXvQfEikYX0cu96q5pD3BFvyfAK9ZLeUZlxwEgYREy+0BkHCeZ6LZkSmkx
         DEetXf1aLYS8Q1NkEb+RRUJYpK0ER3y6LH3vOrUQasfq+w1hwo8v7g/0qOsUPL8yXjoY
         8I7Y1ZFftzussraXglAKs4IVYT9IL86KM8PdjRPM/o4my/vnd2vLMxdKdJiu8akZu7il
         sWNgg6enFUVsuM7hZUGJ+4Ooegmt1ze9/VhVeZ3oPI2FzQuUTXie06VXUsqMa1m4XRHB
         A3PdTf0AeoE4rVWktzdjMowW96BruaV+Il1oMj4s9YURp0yzquvnq7m4gW0LHt5f3NNh
         1cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795784990; x=1796389790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eogd8k2r4l6L3snwOgsY9XYxjjhni7gOzREbmp7dwa8=;
        b=oyup+LtKZS4GpwO6q4wqreg4fQox7pH7E/nxGpyZRnsB3HBltINcq2/1B9pqtLBZj2
         hOBhN2Jp7ssJLygC1GW/n4L7FBdmV2OHb1VY1a2Km1Zm9lFhZ+BKkbjhVBwdKv5w2Mx+
         EB6YY82mjgRyh/O/pb+yLxqypsdmHccW8r9Z517Ocd8jNUTcCt4bvBvfey7KKjq0TiRZ
         3pzu60Mn3XsLS1tA8GuLRIWFsWV49HXMVxcUGMHu7mxLFngqTaHUbsRrv8oSN11nLtHK
         1SC14VEkHF1ayQRu7bfO50FQ34BMJJ8o0mUyjl3W17uJYjVSw5+GjQeckkNZdcKLgmi1
         WcGw==
X-Forwarded-Encrypted: i=1; AL+hErHxQN4HeTquc0rVWPfM/1Bw45BcE2VDExgMMeaLuYzfDzfybhGcWfJjtO4BHjQYh++egl+dR4s4l+C+@vger.kernel.org
X-Gm-Message-State: APuU4Z9sU+ttqxemZvL1lo5YK7dnrDmk7+p0O7FDArc15P6SHB8RPMdX
	xEFasEA47JsiGDoOaQntwx/OGiuE67ZI5xtoM5KnISmcyGHaVwrkxXARl6ARQuhjhxTdAk2g0Ys
	yJoAJC7gEWHfryBDJ3vf7L34pwQHVyHbNqCGQ/B+y
X-Gm-Gg: AZFdTZf1umadeBxITbq6MT0Xa6QlK9Hyn2WX5mZpWF1u2P/erAFObllKobnaS+mBUIx
	r7a8db0w2YLvFX7nfGghV2CPyPMiCAZLQnT8k+uICDokA4DkauotpE0Fxo5/p505YqM8DyhwI3Z
	o2DV98bnowYSa+3SxZT23FfvE6T9ymn95WnE3+vwt2BC5QfmMS6rzhaHc77PolSxEFrDcLJfKFu
	TnTKS0Q+OJ0XiMKfv6GqTMFhgUk3/6MRY8piRjQ/4hPn3D3UrGmBX+2jrPB5d6XR4c8T5lJSCyr
	Swj2df/pWhU37hDjg0rntFX0I98OIguxP1D+FFOEluPOfIRw3DSVAF3UbfWt1i+t007bzV4GaXl
	ZGmGMxFEKi1J0gUzxN7/C0j8l7RjGNo7PC/7h2pjOFWB7U9bWKmRyxnTyW024z103v2E=
X-Received: by 2002:a05:701b:2319:b0:1b3:a8fc:6306 with SMTP id
 a92af1059eb24-1b55247e725mr21740730c88.6.1795784989485; Fri, 27 Nov 2026
 05:09:49 -0800 (PST)
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
 <CAN_Opa9zKzSptpNOnCzaW_EK0oT=HDDVoJxy5Q0crM+6b9bR_g@mail.gmail.com>
 <awdlqAbyRyJdSVeG@elver.google.com> <CAN_Opa-Oa1-NiR9bHLkT-Z1pb+JDTj+oTKv_phVitVtwsV1EDA@mail.gmail.com>
In-Reply-To: <CAN_Opa-Oa1-NiR9bHLkT-Z1pb+JDTj+oTKv_phVitVtwsV1EDA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 27 Nov 2026 14:09:12 +0100
X-Gm-Features: Aa3M54pF_A1KGvCJJkG_GXguTjQxf-CL1zJXjvDc3sDy-3xEWmjZAMm3r1RTYSY
Message-ID: <CANpmjNPdrfXokReaOubYZB9+Q9tgemirCikP068Spn3rj1ACrw@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Nov 2026 at 03:58, KunWu Chan <kunwu.chan@gmail.com> wrote:
> On Thu, Nov 26, 2026 at 6:48=E2=80=AFAM Marco Elver <elver@google.com> wr=
ote:
> > On Wed, Nov 25, 2026 at 05:40PM +0800, KunWu Chan wrote:
> > [...]
> > > Makes sense to keep the test in both configurations.
> > >
> > > I reran the three new KUnit cases on next-20261123 with rcutorture
> > > disabled, using the same image with interruptible watchers on and
> > > off.  Both runs passed all three cases at all seven thread counts
> > > (21/21 per run, no skips).
> > >
> > > With watchers on, I checked the console reports for both remote
> > > cases.  The two accesses were on different CPUs in each report.
> > > The earlier -EBUSY and remote_read failures did not reproduce.
> > > The separate 60-second rcutorture run also completed without any
> > > reports involving got_idle_tick or tick_nohz_handler.
> > >
> > > One question about the IRQ-off path.  A local NMI can still write
> > > to the watched address while its KCSAN checks are disabled.  If
> > > that changes the sampled value and no other access hits the
> > > watchpoint, is an unknown-origin report expected for THIS_CPU?
> >
> > Yeah, but we can suppress it:
>
> Thanks, that addresses my NMI concern. The trade-off makes sense
> to me.
>
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 51340bf1d4a3..b3e0c2627712 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -689,7 +689,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, si=
ze_t size, int type, unsigned
> >                 kcsan_report_known_origin(ptr, size, type, ip,
> >                                           value_change, watchpoint - wa=
tchpoints,
> >                                           old, new, access_mask);
> > -       } else if (value_change =3D=3D KCSAN_VALUE_CHANGE_TRUE) {
> > +       } else if (value_change =3D=3D KCSAN_VALUE_CHANGE_TRUE &&
> > +                  /* May be due to a permitted write from NMI on this =
CPU. */
> > +                  !(type & KCSAN_ACCESS_THIS_CPU)) {
> >                 /* Inferring a race, since the value should not have ch=
anged. */
> >
> >                 atomic_long_inc(&kcsan_counters[KCSAN_COUNTER_RACES_UNK=
NOWN_ORIGIN]);
> >
> >
> > The downside is not detecting races with uninstrumented code, but usage
> > of *_ONCE_THIS_CPU() is still rare, and if someone wants that coverage
> > back, we can think of something better. In general, I find the unknown-
> > origin reports not all that helpful in many cases, so my preference is
> > to just ignore those.
> >
> > > Tested-by: Kunwu Chan <kunwu.chan@gmail.com>
> >
> > Below is the complete v2 patch with the unknown-origin suppression.
>
> I tested v2 on next-20261123. A 60-second rcutorture run with
> strict KCSAN completed without any reports involving got_idle_tick
> or tick_nohz_handler.
>
> With rcutorture disabled, I ran the three new KUnit cases twice
> with interruptible watchers on and twice with them off.
> remote_write and local_noreport passed at all seven thread counts
> in all four runs. The remote_read results were:
>
>   watchers on:  one run passed; threads=3D5 failed in the other
>   watchers off: threads=3D4 failed in one run; threads=3D5 and 8
>                 failed in the other
>
> I also saw intermittent remote_read failures on v1 with
> rcutorture enabled. Have you seen this in your runs?

I haven't. I suspect it's a flaky test because writers are also racing
among each other.

> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

I'll send a final v2 with the fixes incl. to make test more robust.

Thanks,
-- Marco
