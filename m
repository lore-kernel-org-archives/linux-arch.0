From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 5/6] ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS
Date: Mon, 13 Sep 2010 13:22:42 +0400
Message-ID: <4C8DED62.3080208@ru.mvista.com>
References: <cover.1284357372.git.matt@console-pimps.org> <831bc9523fe04ce899bc78230990033fbe009431.1284357372.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46817 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab0IMJYW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2010 05:24:22 -0400
In-Reply-To: <831bc9523fe04ce899bc78230990033fbe009431.1284357372.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Robert Richter <robert.richter@amd.com>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, linux-arm-kernel@lists.infradead.org

Hello.

On 13-09-2010 10:07, Matt Fleming wrote:

> Currently, oprofile support is only functional if CONFIG_HW_PERF_EVENTS
> is set. If this symbol is not set, oprofile initialisation will fail at
> runtime. Instead of allowing the oprofile code to build but fail at
> runtime it seems less confusing to not allow the code to be built unless
> hardware performance counter support is available.

> Signed-off-by: Matt Fleming<matt@console-pimps.org>
> ---
>   arch/arm/Kconfig           |    2 +-
>   arch/arm/oprofile/common.c |    9 ---------
>   2 files changed, 1 insertions(+), 10 deletions(-)

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a7ed21f..d29075c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -14,7 +14,7 @@ config ARM
>   	select RTC_LIB
>   	select SYS_SUPPORTS_APM_EMULATION
>   	select GENERIC_ATOMIC64 if (!CPU_32v6K)
> -	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
> +	select HAVE_OPROFILE if (HW_PERF_EVENTS)

    Could remove useless parens while at it...

WBR, Sergei
