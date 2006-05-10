Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:40077 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751405AbWEJHJm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 03:09:42 -0400
Date: Wed, 10 May 2006 09:09:29 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Define __raw_get_cpu_var and use it
Message-ID: <20060510070929.GA23414@elte.hu>
References: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


* Paul Mackerras <paulus@samba.org> wrote:

> There are several instances of per_cpu(foo, raw_smp_processor_id()), 
> which is semantically equivalent to __get_cpu_var(foo) but without the 
> warning that smp_processor_id() can give if CONFIG_DEBUG_PREEMPT is 
> enabled.  For those architectures with optimized per-cpu 
> implementations, namely ia64, powerpc, s390, sparc64 and x86_64, 
> per_cpu() turns into more and slower code than __get_cpu_var(), so it 
> would be preferable to use __get_cpu_var on those platforms.
> 
> This defines a __raw_get_cpu_var(x) macro which turns into per_cpu(x, 
> raw_smp_processor_id()) on architectures that use the generic per-cpu 
> implementation, and turns into __get_cpu_var(x) on the architectures 
> that have an optimized per-cpu implementation.
>     
> Signed-off-by: Paul Mackerras <paulus@samba.org>

i made the original raw_smp_processor_id() changes and i never liked the 
per_cpu() open-coding it introduced. Your patch solves this problem 
nicely.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
