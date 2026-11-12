Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499534;
	b=sZ8JoK9FHfYthJ47jIr4r5kmn/MHALwCLJm6rHL5355tqSSv7gI+waMYnF38AlQFKobg
	 9DN9pXh+2kGSSw72M0Fd0WAPPmsbFLmbdC5owtbsIy6VhpwJBl4nitx3SWoGiQUkxxNoj
	 4mcTgMjJY9z65f8UzZ+AKc4h+50stH3ejtAA1MjrVH2mB3vTQgfh0UZv4pIp5fPKGh4Te
	 U+BLleSVk8QQ3WGeJxZMgVgRNqxMzqSI2g0kRbfVamVi5BT7G5CG2pv7cC0JOCgYD4mi3
	 0l58BZ7DhTKzgI4VkGxS8rsxGF7nt8kY8YLCt8HxzS1MPPsy83laCUdMmmWXOtso2AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Im1WacHSUV4tAGVpgqmNrHFk27h4swfyz0z4hfrjjiM=;
	b=jB5y2+fGacLQyhC6IREPL7k9ihgBPX77U2d+4yt2muWioulIc0x/pL7j7CCnuQstVCRK
	 yREA4cp/QxFMhTbPzqXQkf4D1+6txo6PjxItuPs4nmd/1O66N0z+MaXJ5F4/ERIS8OdWY
	 yr7Q37jgFvdtug7eHMd5r3Lsu1SzbnJw42WfxSm3XRKlT5+lXuZsoYWqA4Wp9ZpgkHGm7
	 wkp5VEa06IhndqJ/wHsqFSz57RwKwLLkLae3mhWeZolu1OonpUF3qW8hK6NyhewZdFY9b
	 5ON4CozvpZZS1LLHuWGVunXD2tXXxS35FbQgNE/0LYy9PoGlFrvWTzOkguhbBUVy7fA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TY3Km2W2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06069606A323
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 16:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06069606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TY3Km2W2
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so41832885e9.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 08:05:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499532; cv=none;
        d=google.com; s=arc-20260327;
        b=QbAU+PYiFknl616olN6UwEI/Lw4WUBY87tVyZx/bgRVTZHNSXAmB+t2nsGOBhIbvv1
         jm/gXESC5688zDz5t3fcIyaz0rIEgQpq/UySF4LlrOXLtdMx5dGGcDmrBv9sCknQ58nJ
         WT5iN8R36g04b6gtQ0d71obHpY5v6f165OuRaE1xrjPaUS8n7Ls6eVk7NtWOVumVkxSR
         HrIFZY0uNZvhfqV0dhcjR2nx1Q/y7+B4zFnaUYhqvBoCqUNV6d/+1JD6ZfeU/kXcsASE
         TfYr+xTHgQFYhEtC4yuvUUpm6gK/CtWvMFwAi3iBT8CP0U20EPkRIy6k1dDSaFHb6xFL
         RkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Im1WacHSUV4tAGVpgqmNrHFk27h4swfyz0z4hfrjjiM=;
        fh=UN0jjQbzpQjVIZOejkOV8iNuIUYIjeCxZXlYJnkDtwI=;
        b=OGqtxyP5/hGrC12G8z43jGxOnW3DYzr03Cy97pqB3vXDmIvKSlurHD9tjTRyl2rmUd
         m1i1DZD92AauL7qDXsGcZ1JXydFDcyjbiBAxkVfYMBejPKTF+YlSDka709wNHPcBwH62
         4Blrb1bxAv6dpoiwTfHMlW8shgYAQX96vyjJG4EyxofgsJvC62xHXb2IODd0bq4gwn/6
         +z0nRTOR+Vqapzy7leW+8yI6gscpSbDXInhJbjH0H8Q2mk1PUsblEuzXOGGcWultLUs9
         QlX5ro23VKcWcYJLanw/8KPUd9aeT3rfLUW27lmj0ofwjwiZiMIxztsMd9mtclpWhYJX
         bR0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499532; x=1795104332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Im1WacHSUV4tAGVpgqmNrHFk27h4swfyz0z4hfrjjiM=;
        b=TY3Km2W25/azQ3zti6acRLhwYI4LNSpChmboJAj4won/2PRfYJkSS298uN7jkmEzLd
         sZh0Rb2XB76z+MSJRenuDYozQMSfwA9xZf8V0UKU8W+LbpMGKNPzkhZtL6u5bxl/m1Q6
         xzc0uDhAbfJG7cu47VFGDaotIlQ0rFPfMRIrg6g81ZOTmeFdX4tjcfrHkoR/TfGH/lCa
         /1TatjvkK0q5GsCf9IPGbaDNJeQ17YE4Edo9b0ulJekkTp1ZcFTB9hpCcNxshleKGw5u
         o3CCMDi9Wx3nQKKf43CGKUy6JzgZpCxvbyj+7iGI0JaKnK8jewQGmpPZOYz6qS0K4dFU
         ivoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499532; x=1795104332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Im1WacHSUV4tAGVpgqmNrHFk27h4swfyz0z4hfrjjiM=;
        b=iYmen5ufV3qJd2F547J9jT6UZomje1+GbCwTbDescYAWJodDdZ+PmwL/AbRJIL3vf0
         rfwuuXo8tpxAgnWgCSCSOI9ZWWOV5f2mF/Een8pSSw/p5M7b1uVAK59+oFLzfWKLwC5c
         tEuQC+M280rmrfSl3vma7lhzCArEohWjP4Mgbrskaax218SUia40cnK1jOkM+vO4IZeP
         bwiWig36VMKBcc3BpNAF7ChKnoOwAGElY/lEr0JNa5h/FIWH2TOumi/1/SWvDksx6VlF
         1AGkkw8BFl8z7i34tBvgdAbwmJokSi+MiCKj5PomEd0Hlaeewg+coGVs9iYV04soFInm
         mqNA==
X-Forwarded-Encrypted: i=1; AL+hErEYIndW7I1149lmOx2/bNDtYBXBD/erzkTqxLV8OP5MplF0ri8JEe9byX3AUFpVa8aXHxj5KtCPjzKg@vger.kernel.org
X-Gm-Message-State: APuU4Z8bMTvVcG0c1srY3AUdnOZbyNWWG1jjhh0d1XmT+hIicROADMno
	Y1yubKWaJiJpjt3UZ+KaMcAwavFOo581H81s44mWLpKouutp/ACY60OZptrUcCrzVZEFZJDHjtP
	REl3X3Q9THLtoFI+0xKOKEvPIFm9FsOg=
X-Gm-Gg: AYBFou31/BM0fzuUgEpHWPAbldGDLxQmWrJkS2wrw/hysmepgFDtFEhC55YXOxDYSf2
	KGbOKbEuvI9xNcnLwN96oOMpPKGXIbH1QE851XPuXjW/wVXB/XECHyBhMaP9ywxgFrwh1rBdDL0
	SAkPHZgUtVJYTz12kRbwXPcs6Io/nm+fVH0aws0JpCc6IJUkVc5moMQuY+SMTC9HFmvJZ7zqZWq
	+hEA98TuTHaF36dXtK2vpnCg7b2SL4OdjrMlMqG486sOm+dQf/G2V7aGy57VgP4iiFOh2WS1czQ
	tQN/ysMUc/WjkP5c70aBLnkEruyqphevazaIIPDBp8FeOjPj3AQvxBFKqxgYEvI8KNXF8PkfkJS
	dbGJp+4Y1WLndLAn/aySEdwlaRnpqSQKswBop9Py5c/h+JZLL+Y0RP/dKmk3tNC97Hw8T2Q==
X-Received: by 2002:a05:600c:3144:b0:4a1:a45a:88f with SMTP id
 5b1f17b1804b1-4ba0939ccc5mr113980935e9.20.1794499532112; Thu, 12 Nov 2026
 08:05:32 -0800 (PST)
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
 <20261104165504.2430480-9-kunwu.chan@gmail.com> <3433f88a-027a-4f70-be5b-2c35f9318fd4@paulmck-laptop>
In-Reply-To: <3433f88a-027a-4f70-be5b-2c35f9318fd4@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:05:20 +0800
X-Gm-Features: AclHuK8xdCr_GIOWnwsADKv_-qsCDHnNK6PLsB5r8AjwlSaUjiXIHJvwzGzBDkI
Message-ID: <CAN_Opa_SW3_2uMYudKJcJpeMHaitpvZPnyqxoQTmajx6aW6Q7Q@mail.gmail.com>
Subject: Re: [PATCH 08/28] hazptrtorture: Add slowpath and lockdep scenarios
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

On Wed, Nov 11, 2026 at 5:41=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:26AM +0800, Kunwu Chan wrote:
> > Add SLOWPATH and LOCKDEP configs: SLOWPATH enables
> > CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH for slow-path stress; LOCKDEP
> > combines PROVE_LOCKING with wq_churn=3D1 so each alloc_workqueue/
> > destroy_workqueue pair exercises the lockdep hazptr paths.
> >
> > Suggested-by: Boqun Feng <boqun@kernel.org>
>
> Could the --kconfigs and --bootargs kvm.sh parameters be used here
> as well?  My concern is the proliferation of almost-identical scenario
> files.

Hi Paul,

Agreed. I added the configs to keep the forced-slowpath and
lockdep-churn cases explicit and repeatable. I'll drop the
separate scenario files and retain both as scripted PREEMPT runs
using --kconfig and --bootargs.

The wq_churn workload itself will remain in this patch.

Thanks,
Kunwu

>
>                                                         Thanx, Paul
>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/rcu/hazptrtorture.c                    | 48 ++++++++++++++++++-
> >  .../rcutorture/configs/hazptr/LOCKDEP         | 16 +++++++
> >  .../rcutorture/configs/hazptr/LOCKDEP.boot    |  1 +
> >  .../rcutorture/configs/hazptr/SLOWPATH        | 16 +++++++
> >  4 files changed, 79 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/L=
OCKDEP
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/L=
OCKDEP.boot
> >  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/S=
LOWPATH
> >
> > diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> > index c8b7c208775b..fe09280d063c 100644
> > --- a/kernel/rcu/hazptrtorture.c
> > +++ b/kernel/rcu/hazptrtorture.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/torture.h>
> >  #include <linux/hazptr.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/workqueue.h>
> >
> >  #include "rcu.h"
> >
> > @@ -51,6 +52,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (=
s), <=3D zero to disable.");
> >  torture_param(int, stat_interval, 60, "Number of seconds between stats=
 printk()s");
> >  torture_param(int, stutter, 5, "Number of seconds to run/halt test");
> >  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
> > +torture_param(bool, wq_churn, false,
> > +           "Churn workqueues to exercise lockdep dynamic keys");
> >
> >  static char *torture_type =3D "hazptr";
> >  module_param(torture_type, charp, 0444);
> > @@ -62,6 +65,7 @@ static struct task_struct *preempt_task;
> >  static struct task_struct **reader_tasks;
> >  static struct task_struct *do_pending_task;
> >  static struct task_struct *stats_task;
> > +static struct task_struct *wq_churn_task;
> >
> >  #define HAZPTR_TORTURE_PIPE_LEN 10
> >
> > @@ -83,6 +87,7 @@ static atomic_t n_hazptr_torture_alloc;
> >  static atomic_t n_hazptr_torture_alloc_fail;
> >  static atomic_t n_hazptr_torture_free;
> >  static atomic_t n_hazptr_torture_error;
> > +static atomic_t n_hazptr_torture_wq_churn;
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases);
> >  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires_irq);
> > @@ -668,13 +673,14 @@ hazptr_torture_stats_print(void)
> >               atomic_read(&n_hazptr_torture_alloc_fail),
> >               atomic_read(&n_hazptr_torture_free));
> >       torture_onoff_stats();
> > -     pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: =
%lld relundefer %lld\n",
> > +     pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: =
%lld relundefer %lld wqchurn: %d\n",
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_acquires),
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_releases),
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_acquires_irq=
),
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_releases_irq=
),
> >               torture_sum_pcpu_atomic_long(&hazptr_torture_releases_def=
er),
> > -             torture_sum_pcpu_atomic_long(&hazptr_torture_releases_und=
efer));
> > +             torture_sum_pcpu_atomic_long(&hazptr_torture_releases_und=
efer),
> > +             atomic_read(&n_hazptr_torture_wq_churn));
> >
> >       pr_alert("%s%s ", torture_type, TORTURE_FLAG);
> >       if (i > 1) {
> > @@ -788,6 +794,38 @@ static int hazptr_torture_preempt(void *unused)
> >       return 0;
> >  }
> >
> > +static void hazptr_torture_wq_churn_fn(struct work_struct *work)
> > +{
> > +}
> > +
> > +/*
> > + * Repeatedly create and destroy workqueues.  Each workqueue creation
> > + * registers a lockdep dynamic key and each destruction unregisters it=
,
> > + * which exercises both is_dynamic_key() and lockdep_unregister_key().
> > + */
> > +static int hazptr_torture_wq_churn(void *unused)
> > +{
> > +     VERBOSE_TOROUT_STRING("hazptr_torture_wq_churn task started");
> > +     do {
> > +             struct workqueue_struct *wq;
> > +             struct work_struct churn_work;
> > +
> > +             wq =3D alloc_workqueue("hazptr-torture-churn", WQ_PERCPU,=
 1);
> > +             if (!wq) {
> > +                     torture_hrtimeout_ms(10, 10, NULL);
> > +                     continue;
> > +             }
> > +             INIT_WORK(&churn_work, hazptr_torture_wq_churn_fn);
> > +             queue_work(wq, &churn_work);
> > +             flush_work(&churn_work);
> > +             destroy_workqueue(wq);
> > +             atomic_inc(&n_hazptr_torture_wq_churn);
> > +             stutter_wait("hazptr_torture_wq_churn");
> > +     } while (!torture_must_stop());
> > +     torture_kthread_stopping("hazptr_torture_wq_churn");
> > +     return 0;
> > +}
> > +
> >  static void
> >  hazptr_torture_cleanup(void)
> >  {
> > @@ -880,6 +918,7 @@ static int __init hazptr_torture_init(void)
> >       atomic_set(&n_hazptr_torture_alloc_fail, 0);
> >       atomic_set(&n_hazptr_torture_free, 0);
> >       atomic_set(&n_hazptr_torture_error, 0);
> > +     atomic_set(&n_hazptr_torture_wq_churn, 0);
> >       for (i =3D 0; i < HAZPTR_TORTURE_PIPE_LEN + 1; i++)
> >               atomic_set(&hazptr_torture_wcount[i], 0);
> >       for_each_possible_cpu(cpu) {
> > @@ -960,6 +999,11 @@ static int __init hazptr_torture_init(void)
> >               if (torture_init_error(firsterr))
> >                       goto unwind;
> >       }
> > +     if (wq_churn) {
> > +             firsterr =3D torture_create_kthread(hazptr_torture_wq_chu=
rn, NULL, wq_churn_task);
> > +             if (torture_init_error(firsterr))
> > +                     goto unwind;
> > +     }
> >
> >       torture_init_end();
> >       return 0;
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP =
b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
> > new file mode 100644
> > index 000000000000..f0ff29925a54
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_DEBUG_LOCK_ALLOC=3Dy
> > +CONFIG_PROVE_LOCKING=3Dy
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.=
boot b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
> > new file mode 100644
> > index 000000000000..7b16720214bd
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
> > @@ -0,0 +1 @@
> > +hazptrtorture.wq_churn=3D1
> > diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH=
 b/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
> > new file mode 100644
> > index 000000000000..4d13028ca84c
> > --- /dev/null
> > +++ b/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
> > @@ -0,0 +1,16 @@
> > +CONFIG_SMP=3Dy
> > +CONFIG_NR_CPUS=3D16
> > +CONFIG_PREEMPT_NONE=3Dn
> > +CONFIG_PREEMPT_VOLUNTARY=3Dn
> > +CONFIG_PREEMPT=3Dy
> > +CONFIG_HZ_PERIODIC=3Dn
> > +CONFIG_NO_HZ_IDLE=3Dy
> > +CONFIG_NO_HZ_FULL=3Dn
> > +CONFIG_HOTPLUG_CPU=3Dy
> > +CONFIG_SUSPEND=3Dn
> > +CONFIG_HIBERNATION=3Dn
> > +CONFIG_PROVE_LOCKING=3Dn
> > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> > +CONFIG_DEBUG_KERNEL=3Dy
> > +CONFIG_HAZPTR_DEBUG=3Dy
> > +CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=3Dy
> > --
> > 2.43.0
> >
