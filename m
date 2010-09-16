From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 6/6] sh: oprofile: Use perf-events oprofile backend
Date: Thu, 16 Sep 2010 16:32:54 +0200
Message-ID: <20100916143254.GC13563@erda.amd.com>
References: <cover.1284357372.git.matt@console-pimps.org>
 <e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:47268 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0IPOeZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Sep 2010 10:34:25 -0400
Content-Disposition: inline
In-Reply-To: <e75f8fa563b4bfb2b4cf62fe64ae398ea5e1831a.1284357372.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 13.09.10 02:07:37, Matt Fleming wrote:
> Now that we've got a generic perf-events based oprofile backend we might
> as well make use of it seeing as SH doesn't do anything special with its
> oprofile backend.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/sh/Kconfig             |    2 +-
>  arch/sh/kernel/perf_event.c |    8 +++
>  arch/sh/oprofile/Makefile   |    2 +-
>  arch/sh/oprofile/common.c   |  104 ++++--------------------------------------
>  arch/sh/oprofile/op_impl.h  |   33 --------------
>  5 files changed, 20 insertions(+), 129 deletions(-)
>  delete mode 100644 arch/sh/oprofile/op_impl.h
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 33990fa..dc4a017 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -11,7 +11,7 @@ config SUPERH
>  	select HAVE_CLK
>  	select HAVE_IDE if HAS_IOPORT
>  	select HAVE_MEMBLOCK
> -	select HAVE_OPROFILE
> +	select HAVE_OPROFILE if PERF_EVENTS

Same here, we might want to fall back to timer mode.

>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_DMA_API_DEBUG
> diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
> index 2cb9ad5..3c3fc9a 100644
> --- a/arch/sh/kernel/perf_event.c
> +++ b/arch/sh/kernel/perf_event.c
> @@ -59,6 +59,14 @@ static inline int sh_pmu_initialized(void)
>  	return !!sh_pmu;
>  }
>  
> +const char *sh_pmu_name(void)
> +{
> +	if (!sh_pmu)
> +		return NULL;
> +
> +	return sh_pmu->name;
> +}

Couldn't we make this a generic function like perf_num_counters()?

[...]

>  void oprofile_arch_exit(void)
>  {
> -	if (model && model->exit)
> -		model->exit();
> +	oprofile_perf_exit();
>  }

This will probalby cause a section missmatch. Use __exit marker for
oprofile_arch_exit().

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
