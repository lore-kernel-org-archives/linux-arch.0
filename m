Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:58575 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbYDZGot (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Apr 2008 02:44:49 -0400
Message-ID: <4812CF5B.4080902@goop.org>
Date: Fri, 25 Apr 2008 23:44:43 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com>
In-Reply-To: <1208890227-24808-3-git-send-email-jens.axboe@oracle.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org
Message-ID: <20080426064443.TCLGaIXeFOhvg4kiVZweW49BNxbvoJoHoN_tWblIFjY@z>

Jens Axboe wrote:
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
>   
[...]
> +void arch_send_call_function_single_ipi(int cpu)
>  {
>   
[...]
> +void arch_send_call_function_ipi(cpumask_t mask)
>  {
>   
[...]
> --- a/arch/x86/xen/smp.c
> +++ b/arch/x86/xen/smp.c
> +void arch_send_call_function_ipi(cpumask_t mask)
> +{
>   
[...]
> +void arch_send_call_function_single_ipi(int cpu)
> +{
> +	xen_send_IPI_mask(cpumask_of_cpu(cpu), XEN_CALL_FUNCTION_SINGLE_VECTOR);
>  

Xen vs native is a runtime choice, so you can't just statically define 
arch_send_call_function(_single)_ipi for each.  You need to define the 
arch_* functions once, make them call via smp_ops, and call into the 
respective native and Xen versions of the ipi functions.

Aside from that it looks good, with a very appealing code size reduction.

    J
