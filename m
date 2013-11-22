Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout62.mail01.mtsvc.net ([216.70.64.126]:55317 "EHLO
	mailout62.mail01.mtsvc.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754973Ab3KVSse (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Nov 2013 13:48:34 -0500
Message-ID: <528F9B8D.2090806@hurleysoftware.com>
Date: Fri, 22 Nov 2013 12:59:41 -0500
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
Subject: Re: [RFC] Control dependencies
References: <20131121161733.GH10022@twins.programming.kicks-ass.net> <20131121180237.GX4138@linux.vnet.ibm.com> <20131122134630.GQ3866@twins.programming.kicks-ass.net>
In-Reply-To: <20131122134630.GQ3866@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, "Figo.zhang" <figo1802@gmail.com>
Message-ID: <20131122175941.ailMVt-2_BdtygQ3imPjRiem6-Ux8La7Y4H_M1QS9vk@z>

On 11/22/2013 08:46 AM, Peter Zijlstra wrote:
> How about the below version?
>
> ---
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -61,19 +61,20 @@ static void perf_output_put_handle(struc
>   	 *
>   	 *   kernel				user
>   	 *
> -	 *   READ ->data_tail			READ ->data_head
> -	 *   smp_mb()	(A)			smp_rmb()	(C)
> -	 *   WRITE $data			READ $data
> -	 *   smp_wmb()	(B)			smp_mb()	(D)
> -	 *   STORE ->data_head			WRITE ->data_tail
> +	 *   if (LOAD ->data_tail) {		LOAD ->data_head
> +	 *			(A)		smp_rmb()	(C)
> +	 *	STORE $data			LOAD $data
> +	 *	smp_wmb()	(B)		smp_mb()	(D)
> +	 *	STORE ->data_head		STORE ->data_tail


I wasn't subscribed to linux-arch so missed the smp_store_release()
outcome, if there was one.

Are (B) and (D) still slated for changing to STORE.rel semantics,
aka smp_store_release()?

I realize that, for the perf ring buffer, (D) is in userspace but
I'm also interested in non-perf situations where (D) would be in the
kernel.

Regards,
Peter Hurley



