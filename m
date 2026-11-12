Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794496999;
	b=hwKPIotnI0icY0rKgddZ7MSvBtBpSgCh1nE129tjj2IG/G4iSwmi9MMC+TJbyMmVePxD
	 nLOliyf/bI7di/ClmW/hOHtA8JNTE4517kiFSyig2K4afKf8grKckxjzq4rDqNR37FIEc
	 U930ablg4qIclFF7wpTErKy9YWXYGvLC3B2k+AxM+LeGbI4VFUkeoLxmk8LxE3DE6srN4
	 dD6x6BScmAK8bKBUvgwIxSL9lXUddwwgRwK+L8XjEBBscwMiH9eminweSk4ngYq3CPXc1
	 q1Zg3YnLyd/DLIKUPz7jWl5wINHdPGiFG1Q6o4ZkpiRSntmWFfAIUxaBacYFQ7eZ69g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
	b=ysWmifIzjdr8dvig+240O+fhgxaxQfKu13SQLJ1Bd6P2VzwutDQWzFnFq8buMrnT534Y
	 3Neg8yvorDrhsVjBdibVucmmCKRg3rmljxPn2OHnuSbrVMMfXx+imWI+a7XzSPZJiHnyc
	 lnKvkwH/b6xxHBi8nMGHYjvrV7V66ssi7TCPulhRuTI4rx8SJ0cHHsLNeqHx7fsobO7w/
	 6t1kI7CYdzGuUrfLSLZOk7ZPtwhcD1anlasVrTtCmIq5ysbCATBRmbbwA/7Xl69LXMheR
	 fQZOPwIhIELJ7xWhu8Ml4nyEaNDt76irbn4Kl2SS62pdPnt3KfaYk1WkezB0yrdDzyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHySA5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608560A382B
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 15:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D608560A382B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xdHySA5y
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so48661605e9.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 07:23:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794496997; cv=none;
        d=google.com; s=arc-20260327;
        b=mermyYuukUOnCNzk5JeypgxuDfcjpPcHSODRRml7N2n9UWIwBUHdjEkuuLIvwZcq76
         CQ2CZoLi2/2k9RHpF71FBOrlNj9FQ3o340aO6WIY47puO6JzCQQlr6udDLeOSv2WT3BJ
         3gO5z40Y4jDOcuUErmTDjuzwXKV2WqjVzhrlNiQO8a51TA42oZ92Q7hseP/1mY9BZqpf
         5eXcPM2VGXtt/+aX188GdYgBLww8TzCWnfuueXq4wdhzFTKr/t3qZlh8hTQlgCLII+3O
         Cz0QY+L7+aSc3hgN2yslQjNjI0WndcMLg0hRGBM66ahwfCrVo3x3+kUuBPXK7R5YA6oy
         uatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
        fh=EwDyW1Q+jDyG4yaiY7CWrs1osMnP0jkMyEKtbFIoUc0=;
        b=g0fgVSU1SnR25Ei3dq9i+JFciYJEQiNhGGLlNWlRbT8HsImKi5BwG96jy6DDfcAoji
         5ttvANxxcvfpdu54er1ncNoOtlNbXM9ofqJpYfv74WNBeCZabLmhao90gbeKiHh5zPZ/
         Il5I6qWHPtYFPqI/eM1SfH6go77HPQk6Cs97K/UyrxE0Wp+Yu5XHSKLMxWzHqswu/nR5
         DOl7oFFyG/KHH96X0Yfu2V9F3tUu5HkMCf48Qu33skeH2NIrlqHFhOt+MAK1VMUvfFUJ
         IbQfoyGU9K1lsUxtsovIDDDvsu6tnue/RfAz5M7e7AT2FaChG9YdMqCpkLSXfBMzVxdD
         ps4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794496997; x=1795101797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
        b=xdHySA5yJr8R3v1bJTdVJvaIGdetLFfLzfjuM+o7syK/yGeAzwWzFMxbWd/Ct+6rMK
         MVANAOQwCJNG35jAUcUyz4qb96VvSdxfmtWqtOhL07JUGI5YDqKmQrWanxsYe0RUh4zA
         h/f/rDCpmTn4mbz57neFPhvuuBN/Tq6CJYzLaR1BKKzGinJoy41is6MxKy1i9f9xSrkJ
         Eh+N8FqElCwLLQdbDMED3VH/oMYEJIZfp3JDX38AozVHqv61qQEQ8tJnfedJbuyUQKf3
         2G72UmsyJWQGEErAwHvQG+tY7G0eeC/0puJ2E95E1nXfJyAsX9FNegJ6m2ZoHeIHGgXM
         AMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496997; x=1795101797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gWf9tRn8xdRTedV8zLP5Bk/WzXXZIsEniM+eU5R+pI=;
        b=yBQADd+RvXlDz/1lb8atGV4j17UgTMLFlSgMNBN4zjywPZtnBnMD/0yHMwr6sEJtTf
         1qhLxHIza/qI/qTkI+wuYMa5iAMl4oaGE3i2In8g/ML4T6C7HywzXO5gsXWXrKDoc2XH
         pLPGsKFbylkeHi6DPDYdxsHWFCQM6TZfLEjhAeigqyX3xJ8rghITKZJQM8l8ycyCQuFN
         1fgvMXcQOc13LKvvoisNN89q1lEd0tl7xtVK3k1T9VwzOQiZmLr/XXanLWW7O8kkHwVy
         CmZFdo3aDuSVPnapgLwhgqYwfPK8jS6bnpeSzMjx7d5wxUJQudmFSZ6/4jgfmKWVqZRX
         kJpA==
X-Forwarded-Encrypted: i=1; AL+hErHp8IRStZpptIhA+geO1TSV6hDBCX0AuiO8qWViDxfEWg8vnNEP3KbMP7UlFrwxXjmHUzE18Th1v7c6@vger.kernel.org
X-Gm-Message-State: APuU4Z8DRpvJCBPszHEN9srOqG8qdbDBPyyplhR5zHl0VRiwmLVXBdNZ
	gXb5/VJ+75uGtIcCcx2uMXOI9OURSdTOXts72a6vYTeWPDBX2Mpy9Kvxr1isKuqgPuE051SQJhe
	N+101VkDOZOMLMJG0Vzka8Qy2Qm79K6o=
X-Gm-Gg: AYBFou1Khd6ROfp+1lIA70vP09q/BwmZmayN4a3ZwCZPGp8SwSmldVS7P64h1r837jA
	DNBXW82w3kY+C/exndGIw4Pd41YkGklHI5DYURuRIO7/3h/YJ2QN59SMvTLsMofhaDYCMxJa5Fd
	AusSepbHxY9VyXejZs9sXDWoiRJ089upmB9aL3c8wFSib9aizb1fYu14SP+o8+QacgfaOuxySzB
	rhjcHwImyJ1XOHs4qtoxTplhRDgDwlCYP18aC+eou8A7zDgzqKGeoo1SjA68+77tHwlnp0Zx2td
	/O43Ei6mVRvT3p7l2h9p40ySxwpI2j8W3J/GRBmReWmkA/sQKK1/cV0GBRbmAAxtCmLTut9LNgm
	wkm9Qdqht5MyeSL43CEM2GJfdRgbTtvFTCyXX0DZO4NssHl4kljhDJ/LqVCyMVMRkhZZMHJeL6I
	6XTKsE50t7Z6e6kH0p
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ba0937a886mr110753845e9.17.1794496996738; Thu, 12 Nov 2026
 07:23:16 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-27-kunwu.chan@gmail.com> <444c9bb1-fccc-44ff-8bcb-a04dd36eeecb@paulmck-laptop>
In-Reply-To: <444c9bb1-fccc-44ff-8bcb-a04dd36eeecb@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 12 Nov 2026 23:23:05 +0800
X-Gm-Features: AclHuK-Vxw-TWlfdg2rnJncie6E1-Z5rOKezLCml8xvtMgG1OEVJSy5iWLiq3yg
Message-ID: <CAN_Opa8-macEL323Tw3JUai3ETmq0CCt93ddCZ+Xqd1RF1Q5nA@mail.gmail.com>
Subject: Re: [PATCH 26/28] hazptrtorture: Add torture_type=none clean skip for
 rcuscale coexistence
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:31=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:44AM +0800, Kunwu Chan wrote:
> > When both HAZPTR_TORTURE_TEST and RCU_SCALE_TEST are built into
> > the same kernel, hazptrtorture calls torture_init_begin() first
> > and rcuscale fails with -EBUSY.  torture_type=3Dnone makes
> > hazptrtorture return early without registering, allowing the
> > rcuscale hazptr scale type to run in the same boot.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>

 Thanks Paul for the detailed reply.

> You are only supposed to build one of them into the kernel at a time,
> so the intent of the torture_init_begin() failure paths is to enforce
> this rule.  If you want to run both in the same kernel, the way to do
> that is to build both as kernel modules, then do modprobe and then rmmod
> of the first one, followed by modprobe and rmmod of the second one.
>
> So please help me out here.  Why do we need to allow both rcuscale and
> hazptrtorture to be built into the same kernel?
>

You're right. I had incorrectly made rcuscale's hazptr scale ops
depend on CONFIG_HAZPTR_TORTURE_TEST.
That led me to enable both tests in the same kernel and add
torture_type=3Dnone to keep hazptrtorture from registering.

> If your desire is simply better handling of an error condition, an
> alternative is to force either a Kconfig or build failure when more than
> one of the modules invoking torture_init_begin() is built into the same
> kernel at the same time.
>

The hazptr core is available independently, so that dependency is
unnecessary. I'll remove the guard from patch 23, leave
HAZPTR_TORTURE_TEST disabled in the rcuscale configuration, and
drop the torture_type=3Dnone workaround.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > ---
> >  .../selftests/rcutorture/configs/rcuscale/HAZPTR    | 13 +++++++++++++
> >  .../rcutorture/configs/rcuscale/HAZPTR.boot         |  1 +
> >  2 files changed, 14 insertions(+)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale=
/HAZPTR
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale=
/HAZPTR.boot
> >
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR=
 b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
> > new file mode 100644
> > index 000000000000..c5e9cf0184ae
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
> > @@ -0,0 +1,13 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D128
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_TORTURE_TEST=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > +CONFIG_HAZPTR_STALL_DETECTOR=3Dy
> > +CONFIG_HAZPTR_STALL_TIMEOUT=3D1000
> > +CONFIG_HAZPTR_DRAIN_ASSIST=3Dy
> > +CONFIG_RCU_SCALE_TEST=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR=
.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> > new file mode 100644
> > index 000000000000..e9cca4cf453b
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.torture_type=3Dnone
> > --
> > 2.43.0
> >
