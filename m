Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515849;
	b=CV4z/u8+pMlkHeIyhe31m8DGV/Uo29ULU31lU1mGczG9/PnfBnxpqlqx9RZOe+mQ76O8
	 m7YNt1nfjQiVUiNmDgC4KaZWtFD8lBxGcJl/+S84+0YTsub3QdC5DH/dV0QyCWQgR+VQy
	 wtgJD3BlPldMPrvguy73Ahn/gNi/DxYUJJj+6fMzsi2fi+oZvxD/ULFSIRY5AwrDI2ajB
	 nxO5yooFuK77ege+ZZkZaAwhPwxrsRnQO299tHJ7KDlJ3kPwSJHB22Iyzg6ZieMGOPTPR
	 zmJ1Q+dsP5xr+k1wwOHVC67sH2+tJMYGqscaexSO+Xh88i2Wi2Z6q0q3uziOwURShcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PJKRSvMnrFSC8ixG6G1IhbXM8Xj88fCQ1tCS7WTK6aI=;
	b=NmSf4mMSd1HhCipb0T0jKvkd9usjk5xS70o1MqV7r7jJq1flJc7YSamX4hMOTYcLrvqY
	 3Eoqv11si3TtuLSCHV4xh1zkkoyE0wGMUV8eSVLqMWNLd30bMzMdWCY6b49vjoVpyMo45
	 W80co33XLvvi9OT/i8xfCprN5cOTydJb6jgx6pOIVTOZDnGxIGPQvXLyWz/CuBa28edYA
	 V3yYUAeoXaeFPQpJmfLk0PHsldFxEWvxo02dvI8XIcJcQVttPkInRgT4cNXrCSKL+ijcq
	 bc8Wag6lOdjNWCtDP7WyEUY3AnG3RTHC736hWA7MKQTKRBpjpQoODRNwfdYMhqRKUPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IUIHzJET;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423B606A321
	for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 10:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9423B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IUIHzJET
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so4242021c88.1
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 02:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515848; cv=none;
        d=google.com; s=arc-20260327;
        b=YqIHas2nG1G8rx3iXqHbrFNyX6/lHcaTP0IH0GjnKhPoCMSt2Vu0aJIvZaVfJeeZb5
         UMGeXnwcWK/H/3lSP+YEll56kYIgIdtzfEuk+9DwP/NmtyWZAbdX3azoroaq6rxoKcyq
         87bFHuKEftmgKli68+r+5MSAdHOxQu4FmExY3O1fdTT6kJJAKbeiudLZzR9bjTxxYBrK
         MKiYc8dchcY7G7aqVEpZOWGPkzuI5wZSlEiMbaFzSducYfIXIAxYDQJzKIA8ijXNlcmX
         KV5KHUQqiJ/mpXZoIBLiHbE33t+KCGA7gu53MxsQxHT/fk/z8mTgAJxu4Mgfwo8l9O3r
         bUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PJKRSvMnrFSC8ixG6G1IhbXM8Xj88fCQ1tCS7WTK6aI=;
        fh=bBuuYESvcuz4xpFU3oYiqoV/juOAD4hwdh2Rc1bs5RQ=;
        b=pyQAVmXElTyFY8aeEMOjixOMN1dyWqxgrenrnjj4Hzt3CviTXcR9k6eRhFCjJhkpFT
         MQWGKGuh1QFjhdysAZ9My33rvLD/UB7z+ltxJ8338xGPxruZnWfLoay5nZqWAIP5cl0h
         5tlAjscm4xUGNBflH+TI8IjFJvTxUuQJWXLktEovqHaCDjt4/bIb26FSe7EXtpVyAXK6
         aMUGrrT4UJwYzvtWGuBV/5g1nglHnMwmET+Jk0bvLN+6YFSbnQIZgQhu1P9SMcya7HX6
         ABKKuOznyEzYwBReY4tNCz56+REqBpjSvBBID0SCIxQ0mtj6phBOOXrV9OI+kDuqsNh8
         RJTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795515848; x=1796120648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJKRSvMnrFSC8ixG6G1IhbXM8Xj88fCQ1tCS7WTK6aI=;
        b=IUIHzJETvxapEbZnOJjbvWOlSl/mMqMKTND+qGcwUipwpcGMiSeA9hZqWKANrtoiq2
         30XSbjEZbSUvgF9fa+CCEg6B5iKfKyvUHcw5ZH1AV7GDbY0i+hxYmMNl3E26WluMXJ1U
         QnzuCwh7ltM6nxsDU3pSma7lDrMlsCftfuxUc1C2CTWOv7QEc7O0RuRPhUlSICHs+R1x
         OSEopBAvHrcNTVIBTKUUQUbHBbPorklz1cJHN8udEHLu+IsGgDRwRsnBIhkdB5f2aCTM
         8HnN+TigTNJ7vXPb7i1g1v2wsTxRXxY3FeLzMH0SD4m581OYPkvDtf428apCFFGX+w9k
         qXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515848; x=1796120648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJKRSvMnrFSC8ixG6G1IhbXM8Xj88fCQ1tCS7WTK6aI=;
        b=MSyMenc5PgpeVBInUingbrGf29CeLc5IdAty7zOI2EYotThCheEMT59qrDY5v5ulY8
         VX7Cn9G1MVhko4hIuHooN7vGeqKEK1QLTtrF52xeWiAulTPdyxrU4POfJ++K77zjVW/h
         3wDF6EIz1XDOvSap4TZZbNMpw438qKPJzlgpPCjSj5ul32sw/jjS/IQQFTFc+pVmNTsY
         gHAtcNNPQTIjTm+EDDmS7X/F1z7QN03JLhMzn/v0WK5gVXt8IHujTNeXQK9KEA1V42zu
         q3ogfdNVY7MHdXrQrBYvOo1ZmZcEIyfq/GirzOm20XRobi8UbWBx6huTw0Bq6EV/nmi5
         wduA==
X-Forwarded-Encrypted: i=1; AL+hErHvQD9gK3ai0r/fE2GzrVB3PNovzmyzWEeumW5HV5YjsSdrf+7F//DFfsFfRRB57DOlSc4IkOUi4f/W@vger.kernel.org
X-Gm-Message-State: APuU4Z+dputWZ55zAefleQ4jJiO9rSm8B9LYoiWoH4OJto+i4VvhXSjj
	r2seCVIfo7PUFx/Dz5xmrN9DEqu+i7kaSr7GQcFHj5XjvnOV4ffulMTcsCFh+Yqu7sPVzrQ5wcR
	cpn9Xa5VHJXnszdKf/YjzHYa4gzxSHPtKF80UpP59
X-Gm-Gg: AZFdTZeZJPcsBl7i4rnJyjCaPZwecb9Hr2kDnUzaEkXriKoJy7oDzxt43dv3028evaC
	BmH1RDCNJ3+MT10Qxx6r4ZQ0jUrk9MFhrvrwfN70qQ0pZufnacg5mFOR8fDOPvLj3AYHtntGada
	c0TJ9FnYYW6uRubp2RJCwDPbRUcCvTuEwHyxTwYkchRd8QwYX2pIe0piQZk6HWQx8mX5Sa2o8Ch
	QBKNJ3wevuiUw17cFCtW+eGn38FVXAd19bLMHqq0R2iaSA9/DojCdlkLUYdCc33qebvOQ3IGH7P
	g/8ehUm2lbMbJPIBzMIwgHZQ9ufqOai86sa7Rl4PmzbxHg2jN110//ISuN6XPT9nioU1mtWz3K7
	pMTN4iheD/EJRioo1BDijWD2KFDwl/A3lVeUziTBzo1r7Mgh9NUZU/KZoxtaNQ9e1qujZ
X-Received: by 2002:a05:701b:4584:b0:1ac:9da7:e86e with SMTP id
 a92af1059eb24-1b556908c17mr14577708c88.30.1795515846955; Tue, 24 Nov 2026
 02:24:06 -0800 (PST)
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
In-Reply-To: <CAN_Opa_TKjDAWz8EQaw6ro=joymwurpcy-k_x=q4E6TLt6ZpUQ@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 24 Nov 2026 11:23:30 +0100
X-Gm-Features: Aa3M54rX7NhMvWiNHR-Tlf4y9Dtfxu9Xuj2WtFxJ7RzPEamu0euXSCR2FjPDTw4
Message-ID: <CANpmjNNOVD3KVrau5KD4WzqxoMkZZoJCfdPzvjLmZsGy9zXBug@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Detect cross-CPU races on {READ,WRITE}_ONCE_THIS_CPU()
To: KunWu Chan <kunwu.chan@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-arch@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Nov 2026 at 10:54, KunWu Chan <kunwu.chan@gmail.com> wrote:
>
> On Mon, Nov 23, 2026 at 9:51=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() identify accesses to
> > per-CPU data that are intended to race only with other contexts on the
> > same CPU. So far they are plain READ_ONCE() and WRITE_ONCE(): no marked
> > accesses involving them are reported, incl. from other CPUs.
> >
> > Make the new accessors assert exclusivity but ignore same-CPU accesses:
> > READ_ONCE_THIS_CPU() asserts no concurrent writers,
> > WRITE_ONCE_THIS_CPU() asserts no concurrent accesses.
> >
> > For KCSAN to ignore racing accesses from other contexts on the same CPU=
,
> > introduce KCSAN_ACCESS_THIS_CPU, which makes KCSAN keep interrupts
> > disabled while the watchpoint is set up.
> >
> > With that, any racing accesses (incl. marked ones) from other CPUs
> > involving READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() will be
> > reported as "KCSAN: assert: race ...".
> >
> > Suggested-by: KunWu Chan <kunwu.chan@gmail.com>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/asm-generic/rwonce.h | 22 +++++++--
> >  include/linux/kcsan-checks.h |  1 +
> >  kernel/kcsan/core.c          |  6 ++-
> >  kernel/kcsan/kcsan_test.c    | 90 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 114 insertions(+), 5 deletions(-)
[...]
> I tested the patch on next-20261123. A 60-second rcutorture run
> with strict KCSAN and interruptible watchers completed successfully.
> I saw no reports involving got_idle_tick or tick_nohz_handler.
> There was one report involving move_linked_works / queue_work_on.
>
> The latest KUnit run with kunit.filter_glob=3Dkcsan.test_this_cpu_* gave:
>
>   local_noreport: 7/7 passed
>   remote_write:   6/7 passed; threads=3D2 failed setup with -EBUSY
>                   ("rcu running")
>   remote_read:    5/7 passed; threads=3D16 and 32 failed
>
> The -EBUSY log shows that rcutorture was already running. The
> remote_read failure at 32 threads occurred in both runs. I'll
> rerun the KUnit cases with rcutorture disabled and check the
> console for the failed cases.

Thanks!

> One test question: should local_noreport skip when interruptible
> watchers are disabled? In that setup the ordinary watchpoint
> path already masks local IRQs, so a pass wouldn't exercise the
> new THIS_CPU behavior.

The test will pass in both configurations, so a regression in either
would be caught. Disabling is not necessary. More coverage is always
better, even if it may not seem useful today.

Thanks,
-- Marco
