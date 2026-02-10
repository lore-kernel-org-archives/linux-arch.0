Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3E3246F0
	for <linux-arch@vger.kernel.org>; Tue, 10 Feb 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742569; cv=none; b=HtySmf0XbtBDiP3B5eaz+TCbpYqefGV75vrV6IP+A5mnFJ1OsSUsw18RmM7hIwFCj4jko93bFyDRtm85h8a3OiAi45DzNLdkw3KjYrufQnuRpallbBYXzi+4Kv5ksuFvTs7F1QJwQPVIOSBb6Be1mRANf/zpywb9yDPbJkmhtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742569; c=relaxed/simple;
	bh=mp18oumLYcbeEo35CqspzfgW3GZ3+0epzStLxKYcz3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSSuc7rqaEIBjMFOYsIHGM9U6d6v+qDsLdpucxUeEbiuYOsCsC/UhSJmAyz27cUuz6MMwjYa/b1EAW+KUeDsWGRw4Q9eCAW4UNFi/WraquoB9usUh/KNr9ShqJ3i67TPXs28M/HTLV2ujhET/khmyqkXA97GEqBDgKgEglb6Ez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+vfLrXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+vfLrXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9CCC2BC86
	for <linux-arch@vger.kernel.org>; Tue, 10 Feb 2026 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770742569;
	bh=mp18oumLYcbeEo35CqspzfgW3GZ3+0epzStLxKYcz3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B+vfLrXYDhuxtnnfJaay1hYyGh42RGex8MZljTnODqb8w0NnHVgg62DJCZGCdHRV7
	 Kw9YPHaw3seqxJfv0Pw4wpCfaMoLuEyKQYXZpL2ADOggg2TtvUNcOBuqLTtyE9SWsB
	 7lKD94ie8eFqrayG2h4CQ+cxX7cQD2C16diAaWMBST32onkjGdgyzhSbvh92JBqtfg
	 +wqHcTG4aTOnLcQNtJHJ7f0qStdrCUGzF8F2ecqY91jCUdJ0cl+uR0MDE3nyiA1NPr
	 pDeSXFSD5fYiXIjAwx7gaj8QjQIb/EkrjIF6NFLIVTzjEVHifnC27z3FQLkpPJvsL+
	 MeLolQoeKxZ+g==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40945a682b5so2214321fac.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Feb 2026 08:56:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIee5qkNTbR/yFetbqajNyAUfUnfZLrLU48Zj/wAkkIzzLxGSehHMn8gVgsesCAQeSfezXQO5eY6fK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5d8xBs3wi8mair3EUgCP3jxkIu+WhL/zigwlQMXnrgNg+TdaC
	NxvRGV9tCS8FVjg1eiF0XO3JhmylODHs3yTuFNf3FR6EdA2Stb5O1OJXFLeiwznDWA+qqR7vSIk
	qymO5HLifhtJTNfMSgwj/ebznQj5fGVk=
X-Received: by 2002:a05:6870:e98e:b0:409:e025:a467 with SMTP id
 586e51a60fabf-40e66987163mr1394689fac.56.1770742568025; Tue, 10 Feb 2026
 08:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com> <20260209023153.2661784-13-ankur.a.arora@oracle.com>
In-Reply-To: <20260209023153.2661784-13-ankur.a.arora@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 17:55:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_iXcbsOpkEFN=Qy0UMpa73eVfLLM42mNpx2E6JD1zHw@mail.gmail.com>
X-Gm-Features: AZwV_Qg8i5FSICt8qHIV10FqvRMrMFr7XqGHKA8IPhFnZEOVrYzwGdBhqyez9Dg
Message-ID: <CAJZ5v0j_iXcbsOpkEFN=Qy0UMpa73eVfLLM42mNpx2E6JD1zHw@mail.gmail.com>
Subject: Re: [PATCH v9 12/12] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 3:43=E2=80=AFAM Ankur Arora <ankur.a.arora@oracle.co=
m> wrote:
>
> The inner loop in poll_idle() polls over the thread_info flags,
> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> exits once the condition is met, or if the poll time limit has
> been exceeded.
>
> To minimize the number of instructions executed in each iteration,
> the time check is rate-limited. In addition, each loop iteration
> executes cpu_relax() which on certain platforms provides a hint to
> the pipeline that the loop busy-waits, allowing the processor to
> reduce power consumption.
>
> Switch over to tif_need_resched_relaxed_wait() instead, since that
> provides exactly that.
>
> However, since we want to minimize power consumption in idle, building
> of cpuidle/poll_state.c continues to depend on CONFIG_ARCH_HAS_CPU_RELAX
> as that serves as an indicator that the platform supports an optimized
> version of tif_need_resched_relaxed_wait() (via
> smp_cond_load_acquire_timeout()).
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

This is generally fine with me, of course depending on how
tif_need_resched_relaxed_wait() will work, so conditional on reaching
an agreement with the arch and scheduler folks feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to this one.

> ---
> Notes:
>   - get rid of unnecessary variable assignments, casts etc
>
>  drivers/cpuidle/poll_state.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index c7524e4c522a..7443b3e971ba 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -6,41 +6,22 @@
>  #include <linux/cpuidle.h>
>  #include <linux/export.h>
>  #include <linux/irqflags.h>
> -#include <linux/sched.h>
> -#include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
>  #include <linux/sprintf.h>
>  #include <linux/types.h>
>
> -#define POLL_IDLE_RELAX_COUNT  200
> -
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>                                struct cpuidle_driver *drv, int index)
>  {
> -       u64 time_start;
> -
> -       time_start =3D local_clock_noinstr();
> -
>         dev->poll_time_limit =3D false;
>
>         raw_local_irq_enable();
>         if (!current_set_polling_and_test()) {
> -               unsigned int loop_count =3D 0;
>                 u64 limit;
>
>                 limit =3D cpuidle_poll_time(drv, dev);
>
> -               while (!need_resched()) {
> -                       cpu_relax();
> -                       if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -                               continue;
> -
> -                       loop_count =3D 0;
> -                       if (local_clock_noinstr() - time_start > limit) {
> -                               dev->poll_time_limit =3D true;
> -                               break;
> -                       }
> -               }
> +               dev->poll_time_limit =3D !tif_need_resched_relaxed_wait(l=
imit);
>         }
>         raw_local_irq_disable();
>
> --
