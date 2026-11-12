Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501640;
	b=3+QMoFvlxNpulVxghBV3QRdwQO8UHOOGvLIODpJobYVGtfDBpJz3g7WecHCmJCTyAtSt
	 cHWz70vQFrFxfUWJU88sBlE0V1UPhuAlAYLQ64/pWZO5lsQ2uh4Qv/L7F08qS4uc0wfJU
	 Ul8i1YH5u45QqZ/pT3YtBsECHkd8MsKssuFzUCVqMhOJFRwSaiGWFgpjaScrA2kC1qY/x
	 mgpjaPxVe0KFJVQ5yD7NU+Tuk+odPonNC3B39zy+/O69jcti95rSG3WSdCLyXE3N//N3T
	 4fayJgtkTAw/q8HG4EyzKMPm3TZzoI3FD7YI0tk7IIG9ROtgSja8J5i8wQrL/ZSp70Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
	b=tsV5BtCpA4lfq6AZO5ylP6QpPDvjeAxClsppg/fjRFcCGgHosCZtiK7mwskmlHej7Jrx
	 VbrLbW+ATpfHsGMIDvQHQTY1j/WdbzDVxx4mZT0UheNS7mPf8SUnOBGinVbfE3wZhxkRd
	 gp1ViVcGBh7863KRl22k4fEOS+0as4y/LjnQ66F+8UnPwn7VmaCxmWW2BBVLZ8ym1IKhC
	 Go3mqsPy/4RG2QtoJRIc4kx/AI+KYPM9qThEm/olBTAneZH0q+8hdLpMkdPDPk7PrpRbU
	 CjOoerUdScjsHqmgllWL7CzlZAp1TfEEtR8AKKv0r4TwN3v68IFl/aqv/Qm8d1mZjCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSTRe6bc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613B3606A337
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 16:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 613B3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zSTRe6bc
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso48426845e9.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 08:40:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501638; cv=none;
        d=google.com; s=arc-20260327;
        b=fnU05qchVkx39MvcRRC5ubIFXHEDcqL4LP1xCD07bdHx37esQVJfvENQ46COeqGeDX
         /cE3Osd2qk1dfjn99UmBm7Ug2HCjyl5picjZwtMG3XflhATyCkILq2hQiIHBgz5TmxmH
         PPf5b/ARNSG3BYqDQ7SiiBzEzrOLPUSK0YFoqdH48xiOqU76rlmng7BMEuytpHXeosaF
         fU9hv1W8fte7YX50O2pajhTJ8ZyABvN1Wjbu6j/j8C3MJ7zHe94gMLlNU8TTNhNPp+oQ
         yxn2R97kRZm9VUxD95D9EdvY+tHkkldC+30hjl1D2ZNx4khGVaEW7LC/j5E03m+ehbOH
         qbgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
        fh=pBphBT1MwSfyJFCDJVMD9b92g+n1j0SS7+2lOGhEf5Y=;
        b=AjGP/dofYSSPmjJvL10VillYrqxbMLnberUaRnB/jhNuZCex1qwfi4FsvENs3/UYy8
         DJLXxifIpqU4nUuD/VN7ZagEON2rNUc9cDsknWNOy8b8aY0ZGZtfQyRB1IwIQ7br++xb
         WvGcMFJLh4FMd3EK9vu5iqXyxscPdMXiGdDRam+x3kUH26CMvx7v+Nqg1YEFhA+EkkUO
         96lSf0V0LAerCBw6fq8VNQoKZ+RsY2Wzpg6ZsQgg28Q7Z8E38DeKb+WipdbN8jGQTzgQ
         hf5qsupZ0uqTVD93WccwbI3a9FW6gi23bQlk/6fS/A/JqwhR6fZ/zI3LAus3RhEoKtjy
         cfpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501638; x=1795106438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
        b=zSTRe6bcpEP0F6lRzme7StvyYeoHX4QkB0ipadH2vg/pjnjMLNyV84pDO0l2RsL4H3
         NiX5YYkTTQo/IbG4eKCM7ptmaQ7zGd87omyitWEWk9Uc22tWQeokvwrzEQNpPng/1/q7
         6dCDIJplhjRVyLU1DCWjS7MRw508izhA0NS80M8HAyxabXNSFR8WN7lUgm3kFRC8+KaD
         1XhAMA9Ko6pvCIAMy3pI/Up75av8t8te2PBEBGEp81c2fFIvgWYmvp0hmfWL1IjpwGdM
         B9+VZv/tm6Qk1JOFPsr5Ff1pp1Irdji+Tv8WvUcoiFhNurMwnW+zyuHax8WBwILRnr8K
         jDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501638; x=1795106438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDFWnnkId3dZbfuzfoQ+57D2DdgEpJLTTPrFOrVSKi8=;
        b=ME1HaVxtvBqJ6hi7T1mq9EJg069SJ4sxGXwOziE9+COOK/zzTwLuFrTcWiZx7Bcoaf
         9iSr6dQDcfbx+nSHdfq+sRC9HpIB0MlbIxhnuH9hPT27GxwTzcVpSh0AUWzs8Iz6domz
         yU57tbd7hu8JBa8ScO3Qa5UHLLzGLP1QCaMFSno8nkMYtBqlCGVHBdMsquRcJjP0Kzst
         uxeHEtt/nie3Og2p8ZvQGbfShRDXQu343mEPIpTm/p/otUq5GFZenhKbogKeCcdcrEL+
         MUp1Q1ofqnLrXDt6oaZoSc72l/qjlnpV6z03/92Srj5jO97DkF6tmK8X832RfPegHGmy
         MgTQ==
X-Forwarded-Encrypted: i=1; AL+hErEXCYMDCVm1VCEDbup3Irz4FOIUtQoLLa50YnX6tw/HSe5KGULoIBD4tMTKnv5UlC7L7NEkLTFiHYj5@vger.kernel.org
X-Gm-Message-State: APuU4Z9hauIJbFT3kWozixsGozDcgnbqOEABVJS1JLttQ+7qgR6SNCo1
	6MOAaGZAnQ/nIABGb7oVbAmysBYVmDgFyvCJI40J7NW58omBP1cU0zOQLYdlwOiFRje4ZLKdaO9
	lu4LtWOiksrcJq2ig7DtCb1K9sguuRqw=
X-Gm-Gg: AYBFou1t0comXqXhSQKQORiR/tE3lh8LTtCb25q6OxjbNnzXyAQbcq203RW1PTSRMRf
	FC6h6oQrNfF1AlTN55a4BRImbQS/2fXDhb0ip2a7eJhTvgp4QlrY4kFVZY5DBl4VJJETzbsp+wd
	dDOxx6kqAoFIpvqxyGY/WC+iE2y294E2l/FjJwVLN7nu3xAaGfDP7CSbcTrh4sAmA3UWjONF80r
	jUsELXM99HIEJ1JsIwjBd1ZC3+qvRI3GY0nyBMDYloz+/MyT7pyosE10KSdypyvJxbdPRuuFzum
	pCpMFrVB2V7S0O5T4vSon5i5hfz+ad+SfGY65l47Grq7rCvNlZJ7fyYrd9YiPqn88/aoBDeD6kB
	si1SONR9NNUvUimS6ItOs8cnIpRUgYDOB4HwG/p4t2UDMg4dtNkk8pu0r2WOV65MP8l6bEQ==
X-Received: by 2002:a05:600c:354a:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4ba0939cc9cmr116023935e9.6.1794501637516; Thu, 12 Nov 2026
 08:40:37 -0800 (PST)
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
 <20261104165504.2430480-24-kunwu.chan@gmail.com> <c4f84631-5805-4750-a7bb-3fd5a24bbb62@paulmck-laptop>
In-Reply-To: <c4f84631-5805-4750-a7bb-3fd5a24bbb62@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:40:24 +0800
X-Gm-Features: AclHuK9v_Y77arVgZcVVGwgCPDnh2ZgjQdSu0zI-cG-aALJ_JZ_d5zP_ayWkNKk
Message-ID: <CAN_Opa-z5mmmw-OB7bU3xuKJAHp0L4Tp8a9A7tjqiaY4s9V5+A@mail.gmail.com>
Subject: Re: [PATCH 23/28] rcuscale: Add hazptr scale type
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

On Wed, Nov 11, 2026 at 5:45=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:41AM +0800, Kunwu Chan wrote:
> > Add a hazptr scale type for per-writer hazptr_synchronize()
> > cost and per-reader hazptr_acquire()/hazptr_release() overhead.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/rcu/rcuscale.c | 67 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 5659eaebc5c0..6e3e3f296f85 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/rcupdate_trace.h>
> >  #include <linux/sched/debug.h>
> > +#include <linux/hazptr.h>
> >
> >  #include "rcu.h"
> >
> > @@ -460,6 +461,71 @@ static struct rcu_scale_ops tasks_tracing_ops =3D =
{
> >
> >  #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
> >
> > +#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
>
> Ah, maybe this is why you want hazptrtorture and rcuscale to be built
> into the same kernel.
>
> But what you really want is hazard pointers to be built in, right?
> As opposed to the torture test?  But this patch will be on top of the
> patches providing unconditional hazard-pointer support in the kernel,
> so you can just omit the above #ifdef.
>
> The reason for the CONFIG_HAZPTR_TORTURE_TEST #ifdef is that it is
> possible to build kernels that do not support Tasks Trace RCU.
>

Hi Paul,

Yes, that guard is what led me to enable hazptrtorture for the
rcuscale runs in patch 26. rcuscale only needs the hazptr core,
which is available unconditionally at this point in the series.

I'll remove the guard and add &hazptr_scale_ops directly to
scale_ops[]. This also removes the need for the torture_type=3Dnone
workaround.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > +#define HAZPTR_SCALE_NR_OBJS 8
> > +static int hazptr_scale_obj[HAZPTR_SCALE_NR_OBJS];
> > +static atomic_t hazptr_scale_sync_idx =3D ATOMIC_INIT(0);
> > +
> > +struct hazptr_scale_state {
> > +     struct hazptr_ctx ctx;
> > +     void *addr;
> > +};
> > +static DEFINE_PER_CPU(struct hazptr_scale_state, hazptr_scale_state);
> > +
> > +static int hazptr_scale_read_lock(void)
> > +{
> > +     struct hazptr_scale_state *state =3D this_cpu_ptr(&hazptr_scale_s=
tate);
> > +     int idx =3D smp_processor_id() % HAZPTR_SCALE_NR_OBJS;
> > +     void *ptr =3D &hazptr_scale_obj[idx];
> > +
> > +     state->addr =3D hazptr_acquire(&state->ctx, &ptr);
> > +     return 0;
> > +}
> > +
> > +static void hazptr_scale_read_unlock(int idx)
> > +{
> > +     struct hazptr_scale_state *state =3D this_cpu_ptr(&hazptr_scale_s=
tate);
> > +
> > +     hazptr_release(&state->ctx, state->addr);
> > +}
> > +
> > +static unsigned long hazptr_scale_completed(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void hazptr_scale_sync(void)
> > +{
> > +     int idx =3D atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCA=
LE_NR_OBJS;
> > +
> > +     hazptr_synchronize(&hazptr_scale_obj[idx]);
> > +}
> > +
> > +static void hazptr_scale_sync_exp(void)
> > +{
> > +     int idx =3D atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCA=
LE_NR_OBJS;
> > +
> > +     hazptr_synchronize(&hazptr_scale_obj[idx]);
> > +}
> > +
> > +static struct rcu_scale_ops hazptr_scale_ops =3D {
> > +     .ptype          =3D 0,
> > +     .readlock       =3D hazptr_scale_read_lock,
> > +     .readunlock     =3D hazptr_scale_read_unlock,
> > +     .get_gp_seq     =3D hazptr_scale_completed,
> > +     .gp_diff        =3D NULL,
> > +     .exp_completed  =3D hazptr_scale_completed,
> > +     .sync           =3D hazptr_scale_sync,
> > +     .exp_sync       =3D hazptr_scale_sync_exp,
> > +     .name           =3D "hazptr",
> > +};
> > +
> > +#define HAZPTR_SCALE_OPS &hazptr_scale_ops,
> > +#else
> > +#define HAZPTR_SCALE_OPS
> > +#endif
> > +
> >  static unsigned long rcuscale_seq_diff(unsigned long new, unsigned lon=
g old)
> >  {
> >       if (!cur_ops->gp_diff)
> > @@ -1140,6 +1206,7 @@ rcu_scale_init(void)
> >       static struct rcu_scale_ops *scale_ops[] =3D {
> >               &rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
> >               TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> > +             HAZPTR_SCALE_OPS
> >       };
> >
> >       if (!torture_init_begin(scale_type, verbose))
> > --
> > 2.43.0
> >
