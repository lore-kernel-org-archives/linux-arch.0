Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42651 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964851AbWEJIjc
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 04:39:32 -0400
Subject: Re: [PATCH] Define __raw_get_cpu_var and use it
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
References: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 10:39:49 +0200
Message-Id: <1147250390.7364.5.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-05-10 at 13:30 +1000, Paul Mackerras wrote:
> There are several instances of per_cpu(foo, raw_smp_processor_id()),
> which is semantically equivalent to __get_cpu_var(foo) but without the
> warning that smp_processor_id() can give if CONFIG_DEBUG_PREEMPT is
> enabled.  For those architectures with optimized per-cpu
> implementations, namely ia64, powerpc, s390, sparc64 and x86_64,
> per_cpu() turns into more and slower code than __get_cpu_var(), so it
> would be preferable to use __get_cpu_var on those platforms.
> 
> This defines a __raw_get_cpu_var(x) macro which turns into
> per_cpu(x, raw_smp_processor_id()) on architectures that use the
> generic per-cpu implementation, and turns into __get_cpu_var(x) on
> the architectures that have an optimized per-cpu implementation.
>     
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Nice, saves an indirection over __per_cpu_offset[]. And it works :-)

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


