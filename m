Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD71E5B70
	for <linux-arch@vger.kernel.org>; Wed,  7 Oct 2026 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791339484; cv=pass; b=mDorDaiWPXO5N3+NNrcqzt+4EzrYeIPNvBDnbnheEtqIpKTW3j8b3YNpK5c44RGR493f99pxiEmXTjqbldGBMBrJu6d/1LDRrlPI73VRc295X6Dc63B7QEM6Z32uR1mbH3MSN9gs3sU97lfROZrt7Dv8jYu6JxDp2qvVeZyfsTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791339484; c=relaxed/simple;
	bh=VIu9IqjAGNeJ5CxJ1aJYgp/RLiXbBj4etI3szwtdgyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAtdPu1HL2cH9KfPHUplvGbqdsqM5RngAy0FC+33DVToXpDxtp5Q6rh2a4NzOEQ0RIR64c3hPVxzkzxxV0220yY4LkqqWHe8yuc0RKg1QDz2BDPdJk2JWYxpC5yKHivDYJCT4TmhpniVjOKaPUADROBvaHjFB7jsnmYZs6Ml2ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VofLcoyb; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VofLcoyb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a168355946so11903275e9.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2026 19:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791339480; cv=none;
        d=google.com; s=arc-20260327;
        b=LC5o5YdOASz6OI4FFe8lMZpXikEqaWlzzAu7+KmCgSCKeY2rbuj1+Cg1JZVi0LBcQ9
         ZRc/jCed3fkMN5HRmL6R8DHYJaxk2Swi9uI7F1mfax/rTq73XNnOvqx8+Q/x1K+sRHtv
         /QfTVxOLC1PFVSWTUz9M/C09ARpvKUiGJfUIE4kkZYVpwVumU+IYZeba226a7oYmHNWv
         SskpZtz9LEWwxbSYshptmU4ScvbV9PQQ2zWvfJ9RgWJUDgcjmYtxxh7SAcmpZMthaV3Y
         AH7hBIWX04/8wr1SQ9o9g4hkIaTdk3ENAlm4c4zGPbTLZSfKrZOR/UeLN4LUOEmdWhvN
         QcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXQll5yKwAszJJzdt/Gj5gkr0StYojizfaIPuW3tx5I=;
        fh=uuA4LcjbzB+uSxwbHajQwP/mb7GaX4g00AmGKl8RSMQ=;
        b=W5XDVUtCdfH6NyEmH+u/KvNny5w0hhcu/LOaaLV3ky6z/mdduEQdIruiNUvp9qndO4
         uX6v+3HCfMFllnk/TnIofPqLAqjJIsNtD+7s/3JdCP08v2yHCPCRR72WtXkAAyPknV+/
         9pEQiqHg++EYhr4DVWFMeRrFxdsw6evW8yZQQNtDVOQd7v2dU+q862S27jQKs0gPnMZY
         eieOdFUbd79kF4dKG+b9RoJQ0N3EmggReExDilkt++AvXqFkmtcjkrfr8s2qyC27LEW7
         W2A8JA6OdS7PdpWI2xkqOt3xlvxOmDdJFbtVjp2sQFKCpHW7M5m+tvSoiXJoMWnwuHzE
         0Hlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791339480; x=1791944280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GXQll5yKwAszJJzdt/Gj5gkr0StYojizfaIPuW3tx5I=;
        b=VofLcoybAjP8tljDjf4cOLqPDw3Olb8lls7AxLzkbmAmq337C0Fwn3glCmVFCxV/R2
         2O5HkTC6wWAto/92mXbeagm0Mxe+0YQqkof2eLKij0s4I7S3Na5ramc/JJ0PC8/14hvb
         9eXVuTYtDSFsh+0cz7zVyrpXwaYgkVN5n4nW20TOi9NqcYLtDPxJjeMdgMa65KaSWbPX
         OuH66l3liaHcoUJK65tjyym43pFC27su8itKQx3iLA2920d7DveZ6Iw9XY9eyAbNNqhu
         LG1vpIVy4Wk11rZvoCM+iLWIKGPdS1a1ck927312PFY/a/FZCZfN4cYRhMqHpD+nmCOF
         Pq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791339480; x=1791944280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GXQll5yKwAszJJzdt/Gj5gkr0StYojizfaIPuW3tx5I=;
        b=2jeiWns+GoA6ppRbhsyscgvJYTE3IZpgAWTLj41n0PzarTY1B+yX+ZnZrJO+t3NYUr
         F0Yt6IKX/1kdDuaUMA3dl6o2ffUdGWkBA3brwWC0jYeq3LhUu5NA6n5sR3vvQORtfhr/
         1EyewxK0IQ7sx2yn9a+2UUmrLTuRNVj96J0rG9fLRUnkKyHgrbAWaI+VhP3N9ztL+ljc
         CNcD+3z2W9lR/v7Vngkk9r14U9+bwaOM1tKuOJkA1TpC9+hkBPQYkHcGjjykMaU/St27
         4IJqSsUmDzYIS/an5Wk9vIkMl2bZkH1QUONA0xLYR6vMGtImX0wvlHRDZc6PF2180S4N
         3MoA==
X-Forwarded-Encrypted: i=1; AKwUvBzl3bmjUDSpdK/7RdzW2xV0KfqalISKqPPUnf5AOaj+8KsXHOLA53PcWo26MtNJihieGURDCNGRsBPy@vger.kernel.org
X-Gm-Message-State: AFuF++nyZO3/XIIsnQYu/iefvyYr0KNzH3LrmMetFZ4Ovtn7RBcBcgyp
	d/n3V22m0wN65bL9jGnH1xBLkU5E39iTkFK0Fos9kPIP2fthm4vN2R/qNXAglgo37od/GsUg46F
	BrePhxMwJFXHuAoozWbbcaQ0XJt0hEDw=
X-Gm-Gg: AYBFou14brZvxzECtx6pMJgaW3XtTh2AoSD8dBoj9QuNvD9XkO30l39wFMGHR/FyOoO
	IMOIziNHFxmvOxwp9yUqddkMgrOjmGyZTT/snJDJtGL0yAkJRPuDbFEGP3fnvYAUUrlfPq1i5c/
	TbkPHRcbF1ke0EKl3YP1Uhf1qHd/ScXeCQeoZoFT+Nid9TywDHdj4eQyu9vMyptThyTFw42ImZM
	YYYFu1Ydb4u9hbQwd1n/RSZcH15FwjFAd3GEZC+5dqptwBFUDxocA0VOjMTinknfbmnRYFntpZP
	5uAbGCbwTcijwrYmqOhy5H1HxiXMSsZXMl1K8D54k5tFGebM4QTBYV322Q==
X-Received: by 2002:a05:600c:19cd:b0:4a0:62d:4424 with SMTP id
 5b1f17b1804b1-4a180311245mr8251415e9.8.1791339479862; Tue, 06 Oct 2026
 19:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002151757.3605081-1-kunwu.chan@gmail.com>
 <20261002151757.3605081-2-kunwu.chan@gmail.com> <asO4ey3X6JK0IzlY@localhost.localdomain>
In-Reply-To: <asO4ey3X6JK0IzlY@localhost.localdomain>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 7 Oct 2026 10:17:48 +0800
X-Gm-Features: AclHuK-tHY6YeG6Ua4SUi-gCDEbMeVVo3yQ2NB_FnxZ7-i_GlcPQuqP0AElsGHs
Message-ID: <CAN_Opa8NjWEpz1wbsBEmyCQ=q3nqrUaYiVa-nbsiOEXPdAwWRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rwonce: Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: arnd@arndb.de, anna-maria@linutronix.de, mingo@kernel.org, tglx@kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 10:47=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Fri, Oct 02, 2026 at 11:17:55PM +0800, Kunwu Chan a =C3=A9crit :
> > Per-CPU variables are sometimes accessed from different execution
> > contexts on the same CPU, typically task context and an interrupt or
> > NMI handler.
> >
> > A plain READ_ONCE() or WRITE_ONCE() marks such an access as an
> > intentional race but does not express where the racing accesses are
> > expected to come from. This distinction allows concurrency tools such
> > as KCSAN to tell an intentional same-CPU context race apart from an
> > access that may race across CPUs.
> >
> > Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() to identify accesses
> > to a per-CPU variable which are intended to race only with accesses
> > from other execution contexts on the same CPU. For now, they are
> > simple wrappers around READ_ONCE() and WRITE_ONCE(), so generated code
> > and tool behaviour are unchanged.
>
> But there is a plan to handle that with KSCAN, right?
>
> If so:
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>

Hi Frederic,

Yes, that's the plan. Thanks for the Ack!

Best,
Kunwu

> Thanks.
>
>
> >
> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  include/asm-generic/rwonce.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.=
h
> > index 52b969c7cef9..4d4e009a4489 100644
> > --- a/include/asm-generic/rwonce.h
> > +++ b/include/asm-generic/rwonce.h
> > @@ -61,6 +61,17 @@ do {                                                =
                       \
> >       __WRITE_ONCE(x, val);                                           \
> >  } while (0)
> >
> > +/*
> > + * {READ,WRITE}_ONCE_THIS_CPU() identify accesses to a per-CPU variabl=
e
> > + * which are intended to race only with accesses from other execution
> > + * contexts on the same CPU, e.g. task and interrupt context.
> > + *
> > + * For now, these are simple wrappers around READ_ONCE() and
> > + * WRITE_ONCE().
> > + */
> > +#define READ_ONCE_THIS_CPU(x)                READ_ONCE(x)
> > +#define WRITE_ONCE_THIS_CPU(x, val)  WRITE_ONCE(x, val)
> > +
> >  static __no_sanitize_or_inline
> >  unsigned long __read_once_word_nocheck(const void *addr)
> >  {
> > --
> > 2.43.0
> >
>
> --
> Frederic Weisbecker
> SUSE Labs
