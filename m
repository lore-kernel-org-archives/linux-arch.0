From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v1 3/5] mm, uaccess: trigger might_sleep() in
 might_fault() when pagefaults are disabled
Date: Fri, 5 Dec 2014 12:45:29 +0100
Message-ID: <20141205114529.GD4213@osiris>
References: <1417778289-51567-1-git-send-email-dahi@linux.vnet.ibm.com>
 <1417778289-51567-4-git-send-email-dahi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:41151 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaLELph (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2014 06:45:37 -0500
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 5 Dec 2014 11:45:35 -0000
Content-Disposition: inline
In-Reply-To: <1417778289-51567-4-git-send-email-dahi@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, peterz@infradead.org, hughd@google.com, hocko@suse.cz

On Fri, Dec 05, 2014 at 12:18:07PM +0100, David Hildenbrand wrote:
> -void might_fault(void)
> +void __might_fault(const char *file, int line)
>  {
>  	/*
>  	 * Some code (nfs/sunrpc) uses socket ops on kernel memory while
> @@ -3710,21 +3710,16 @@ void might_fault(void)
>  	 */
>  	if (segment_eq(get_fs(), KERNEL_DS))
>  		return;
> -
> -	/*
> -	 * it would be nicer only to annotate paths which are not under
> -	 * pagefault_disable, however that requires a larger audit and
> -	 * providing helpers like get_user_atomic.
> -	 */
> -	if (in_atomic())
> +	if (unlikely(!pagefault_disabled())) {
> +		__might_sleep(file, line, 0);
>  		return;
> -
> -	__might_sleep(__FILE__, __LINE__, 0);
> -
> +	}

This should be likely() instead of unlikely(), no?
I'd rather write this

	if (pagefault_disabled())
 		return;
	__might_sleep(file, line, 0);

and leave the likely stuff completely away.
