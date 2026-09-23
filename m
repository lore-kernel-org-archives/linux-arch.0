Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204438F922
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138443; cv=pass; b=Ycpln7HOdrE5s5os62NJ+FEsjztRNxHRCxOea10foAS3ox6r+Tz7gYxXQgtmIs6WO5SE/ePwQwVvFe+sRvKp0qDsDpMUVFSKrks/mkncWAa68pt9nfDS26OpJoel6X9XYwZeMN/Ssev+/jzJPBbQ4CKwoi+rwLK3UlFpykUFOM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138443; c=relaxed/simple;
	bh=DfwslUgXH9iUiGASTRA0OnW94V4DmVUUOxWiW01jeOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfjXzQOJ9w6W/7MaNqYAzaaIY63e86JSml/4xHg6F5CLRp/OtYByYUQJL1W9JSchv7N1/uT8aTgtAE/0v5F6ouBNVIM5MTe0K92U4KpRhDFx3kfV8LSa7DR1QJfIvezfGo14yV5h8AxJvCSCPjM9XcYY45opMCGatpCtKwKwH/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma+vLV0T; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma+vLV0T"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so2196805e9.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 21:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790138439; cv=none;
        d=google.com; s=arc-20260327;
        b=j+fE92Zix8ICNhk6aBB8w5A2DOt/CnvIptGExRMouKBb9d5QBbkZoT8BGrHqz4YMxd
         GCuQCgi7Ibv61sZxEuh4Vxd3KW/cqKybrOdT+syMBAcX2XcRzAdk7hYONwmVXeryZ1RQ
         n2F7mu7CwJjOYAGo9B7jw5v0Uq1Q8SqZ9bKBK08WtswwyhjYH9/+iFAjpVofhve5EqOH
         hvfNMRjCx0zO1xdOSX/TwadSJf8vkmHRoR0Gx+3SJ7FSgCVtKCtdeB0JcNakLcbRe4tZ
         xJvg9V0aiLrdPHl1VsF3Cv46OSp7tYod+Tb2iEjv1tTgWe3FxmDQQ12eRMFna0jd1vzN
         SdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3v8KouzydVZ2wFebRu1KMgQMureFqXEgF0puCqWitK4=;
        fh=BjKkJ+cTbOQMPAzM75v1qaCsFUw5rvnEuwH6IqLY00Q=;
        b=UgrS5TFMVq8AWJSCQRxW5PFhVYEjSBKcTdyVJ3sH6pD5sm6lmPlkNm98qdIxg6XyuP
         KzrIP+g9Bt0yymVugBHqiD1lf2gHCoZCzGJsYUMpJevlXBFFN7O5NyzRO6o1ZIWvIozq
         d1KTUtB/GV/chAjgTGH3SMEKcK61DW7q3aYxI7PZC1ZDPy2r7WAPjrc93uYlkh3dfk4n
         1TK4X9yhmprBM3Y/J7yIB6tiHTm2IiBwIqY+UeSrscbEy+Ot6BFA1dRGBmNtyJNsJ3JU
         Q2bC4gk2v4id35cqwdhDhcNbm+NNvUajhu8t7TntxjsKBfgb4NV0Ayti+YKUGXUczWJy
         KUzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790138439; x=1790743239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3v8KouzydVZ2wFebRu1KMgQMureFqXEgF0puCqWitK4=;
        b=Ma+vLV0TuoWry0i8mVdWA/tHf/iTFMMvvQ65wn42+GXlWOaW3kiRewWZJI0+gCJmoR
         7ylHevOKLYA43YeWy0g0/aEVf4736xnOq8jaC+wZVYIMUEpBuj/+8iBrU9FtHY417/S/
         MRgg0lnYdhon4C4ifCuAg/+2fNUaLlEImSFehh7DIzkLRr4RxKcVV2psBC1ZZuidSl4d
         4iH9CKwN/LKTccY84U4aRcBKMwAWy4lovF2p8sFn1PnDn23TPd3RJD0GJAr6lMHYcO5a
         oPj8skzoX27FghRV154G8/B9eq2YR0fs0RzNRnLmRbztsaTrcqPaS93WifyheEiLAWWU
         TZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790138439; x=1790743239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3v8KouzydVZ2wFebRu1KMgQMureFqXEgF0puCqWitK4=;
        b=21/AQoMCPAMgGDt1mpEvW0sEwW0qP4GS3bjpHlCdR8gSM7Bg9ZdWNdRROvIADqsh0b
         /0XrYZIeNE4PflqYcp4Ey2SxCAdTlinYNE2nZFS9APnjskACidQfX0c65q9U48WNgIJI
         sA5e93WC0kxHVnEzBTg10Og4rRRiHoezjvBztXABueXnhXp4zf3IozOFBu4bUHF2cnpl
         92QrV/Yai2Rl286mr2er2NG4rx8kpT10i9m2VLuBabF/EeSdfn7tb+P16U/lD+SRkyHp
         f4IXO3uhRkfoilTMYe0lZeNRSiEB/V9++/JdYcfBzwG3plrkdmxM9IptsO3o3xZdqWr8
         M4ww==
X-Forwarded-Encrypted: i=1; AKwUvBwy4/polUjcBU9GOb+zIw/UcR3D2k9KrTHS/+/WcT70NgqT33oaXg4ilw3GinwBK4fbmcdIVfh1J3TT@vger.kernel.org
X-Gm-Message-State: AFuF++lRnaFMUtjI8qkxY/EtYan4eJVP/x+7khsGvkcoLXwexfQNN0i0
	lid8tqaPWOYLfFwbNRTrUOUhAfTOg7QlrA4WsL+nhas8O9MFDSVWMwkRmOzkBp0xuN8sInlV6Ls
	6YukSmjHl6mZvrnMf1k2HJ1d8rJ+qZe8=
X-Gm-Gg: AYBFou2DQuDxcHG0ifi2zaSIbW/w65DOzjhgIQ6zSODDe5AYm0qCdcT5yC2I0iR1A0E
	e0Av/xpn7Z81EC+vU7EuXLLclGbLur8RfSYUlrn88/NBRifSLMzngMhrc9DSFxZ3Bkw2mQzbk2C
	mztEowarLKCpK8yHpW7sZ2byYGkexhVhSZwGWZ3pcEuoV4+3xKuG+J7xdWVa0Mvst6X1ZM5L/00
	BV8dUUeJ1WzuYxth/sJhZapDck7xMmnR2gXzkGQQKLUIWMSxaE43js4B2RDNgJ2FYtU/TpHGfnc
	HANn972haFNm16OYECpmYTRI9+sXj8JT5f8881iyUK1WVeBiBQQRN0zT1KMBsbBDpWZqI8Odu4E
	QDWLJfuy9bH7MjQ==
X-Received: by 2002:a05:600c:4704:b0:49e:799e:c1c3 with SMTP id
 5b1f17b1804b1-49fdf12d3dbmr12321785e9.17.1790138438843; Tue, 22 Sep 2026
 21:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
 <20260922070950.4173245-4-kunwu.chan@gmail.com> <arI0bexTH7CL66Dc@MacBook-0RXW5>
In-Reply-To: <arI0bexTH7CL66Dc@MacBook-0RXW5>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 23 Sep 2026 12:40:27 +0800
X-Gm-Features: AclHuK_6rmoBk0Xrp8rz2DECfqwOHj3oChdP_Pi51R31FmxB0rmW3v9rvLOe0xk
Message-ID: <CAN_Opa-B+ipfSyvzBCtJf7jbiKjBFT1i=-8y9LCj+dCiRh=Z_w@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 3/4] rcuscale: add hazptr scale type
To: Boqun Feng <boqun@kernel.org>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, 
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, 
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org, 
	corbet@lwn.net, mingo@redhat.com, dave@stgolabs.net, josh@joshtriplett.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, urezki@gmail.com, 
	akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, longman@redhat.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, include@grrlz.net, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:55=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Tue, Sep 22, 2026 at 03:09:49PM +0800, Kunwu Chan wrote:
> > Add hazptr reader and synchronize operations so that synchronize
> > latency can be measured alongside RCU and SRCU.
> >
> > The read side acquires the hazard pointer in readlock() and holds
> > it until readunlock(), matching the RCU/SRCU reader model.  The
> > address of a static object serves as the synchronize target, which
> > is stable and never reclaimed.  Both normal and expedited sync map
> > to hazptr_synchronize(), since hazptr has no expedited concept.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/rcu/rcuscale.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 64 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 1097ec15879c..072ddf9526c3 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/torture.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/rcupdate_trace.h>
> > +#include <linux/hazptr.h>
> >  #include <linux/sched/debug.h>
> >
> >  #include "rcu.h"
> > @@ -418,6 +419,66 @@ static struct rcu_scale_ops tasks_tracing_ops =3D =
{
> >
> >  #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
> >
> > +#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
> > +
> > +static int hazptr_scale_obj; /* Stable, non-NULL, never reclaimed. */
>
> You can probaly make hazptr_scale_obj an arrary, and let an updater
> either randomly or round-robin select an object to wait, it'll reflect
> better to a real world workload.
>
> > +static void *hazptr_scale_ptr =3D &hazptr_scale_obj;
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
> > +
> > +     preempt_disable();
>
> I think you can drop the preempt_disable() and preempt_enable() below,
> since the new hazptr_acquire()/hazptr_release() work without them (i.e.
> the hazptr acquisition no longer requires preemption disable).

Thanks, Boqun. Both points make sense.

I'll drop the explicit preempt_disable()/preempt_enable() and use an array =
of
objects with round-robin selection on the updater side.

Thanks,
Kunwu

>
> Regards,
> Boqun
>
> > +     state->addr =3D hazptr_acquire(&state->ctx, &hazptr_scale_ptr);
> > +     return 0;
> > +}
> > +
> > +static void hazptr_scale_read_unlock(int idx)
> > +{
> > +     struct hazptr_scale_state *state =3D this_cpu_ptr(&hazptr_scale_s=
tate);
> > +
> > +     udelay(10);
> > +     hazptr_release(&state->ctx, state->addr);
> > +     preempt_enable();
> > +}
> > +
> > +static unsigned long hazptr_scale_completed(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void hazptr_scale_sync(void)
> > +{
> > +     hazptr_synchronize(hazptr_scale_ptr);
> > +}
> > +
> > +static void hazptr_scale_sync_exp(void)
> > +{
> > +     hazptr_synchronize(hazptr_scale_ptr);
> > +}
> > +
> > +static struct rcu_scale_ops hazptr_scale_ops =3D {
> > +     .ptype          =3D 0,
> > +     .readlock       =3D hazptr_scale_read_lock,
> > +     .readunlock     =3D hazptr_scale_read_unlock,
> > +     .get_gp_seq     =3D hazptr_scale_completed,
> > +     .gp_diff        =3D NULL,
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
> > @@ -1110,7 +1171,9 @@ rcu_scale_init(void)
> >       long i;
> >       long j;
> >       static struct rcu_scale_ops *scale_ops[] =3D {
> > -             &rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS=
 TASKS_TRACING_OPS
> > +             &rcu_ops, &srcu_ops, &srcud_ops,
> > +             TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> > +             HAZPTR_SCALE_OPS
> >       };
> >
> >       if (!torture_init_begin(scale_type, verbose))
> > --
> > 2.43.0
> >
