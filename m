From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 2/6] ARM: oprofile: Rename op_arm to oprofile_perf
Date: Thu, 16 Sep 2010 14:46:56 +0200
Message-ID: <20100916124656.GY13563@erda.amd.com>
References: <cover.1284357372.git.matt@console-pimps.org>
 <61369979994f435ba2ac62f06717644d722ee002.1284357372.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <61369979994f435ba2ac62f06717644d722ee002.1284357372.git.matt@console-pimps.org>
Sender: linux-sh-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 13.09.10 02:07:33, Matt Fleming wrote:
> In preparation for moving the generic functions out of this file, give
> the functions more general names (e.g. remove "arm" from the names).
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/arm/oprofile/common.c |   68 ++++++++++++++++++++++----------------------
>  1 files changed, 34 insertions(+), 34 deletions(-)

>  static struct platform_driver oprofile_driver = {
>  	.driver		= {
> -		.name		= "arm-oprofile",
> +		.name		= "perf-oprofile",

This should be "oprofile-perf" instead, otherwise the driver belongs
to perf.

-Robert

>  	},
> -	.resume		= op_arm_resume,
> -	.suspend	= op_arm_suspend,
> +	.resume		= oprofile_perf_resume,
> +	.suspend	= oprofile_perf_suspend,
>  };

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

