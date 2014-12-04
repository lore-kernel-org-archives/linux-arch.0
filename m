From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] kernel: tighten rules for ACCESS ONCE
Date: Wed, 3 Dec 2014 16:16:21 -0800
Message-ID: <20141204001621.GF25340@linux.vnet.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
 <1417645821-54731-10-git-send-email-borntraeger@de.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:37180 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaLDAQ1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Dec 2014 19:16:27 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 3 Dec 2014 17:16:27 -0700
Content-Disposition: inline
In-Reply-To: <1417645821-54731-10-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On Wed, Dec 03, 2014 at 11:30:21PM +0100, Christian Borntraeger wrote:
> Now that all non-scalar users of ACCESS_ONCE have been converted
> to READ_ONCE or ASSIGN once, lets tighten ACCESS_ONCE to only
> work on scalar types.
> This variant was proposed by Alexei Starovoitov.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

With or without the updated comment:

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  include/linux/compiler.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 947710e..5ba91de 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -441,8 +441,16 @@ static __always_inline void __assign_once_size(volatile void *p, void *res, int
>   * merging, or refetching absolutely anything at any time.  Its main intended
>   * use is to mediate communication between process-level code and irq/NMI
>   * handlers, all running on the same CPU.

This comment is obsolete in the same way as that of READ_ONCE() and
ASSIGN_ONCE(), but probably more to the point to just get rid of
ACCESS_ONCE().  ;-)

> + *
> + * ACCESS_ONCE will only work on scalar types. For union types, ACCESS_ONCE
> + * on a union member will work as long as the size of the member matches the
> + * size of the union and the size is smaller than word size.
> + * If possible READ_ONCE/ASSIGN_ONCE should be used instead.
>   */
> -#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
> +#define __ACCESS_ONCE(x) ({ \
> +	 __maybe_unused typeof(x) __var = 0; \
> +	(volatile typeof(x) *)&(x); })
> +#define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
> 
>  /* Ignore/forbid kprobes attach on very low level functions marked by this attribute: */
>  #ifdef CONFIG_KPROBES
> -- 
> 1.9.3
> 
