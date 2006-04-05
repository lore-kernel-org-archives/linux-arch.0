Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:34148 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751082AbWDFGbA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Apr 2006 02:31:00 -0400
Message-ID: <44338EA9.3020102@yahoo.com.au>
Date: Wed, 05 Apr 2006 19:32:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix memory barrier docs wrt atomic ops
References: <29800.1144228639@warthog.cambridge.redhat.com>
In-Reply-To: <29800.1144228639@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:

>  ATOMIC OPERATIONS
>  -----------------
>  
> -Though they are technically interprocessor interaction considerations, atomic
> -operations are noted specially as they do _not_ generally imply memory
> -barriers.  The possible offenders include:
> +Whilst they are technically interprocessor interaction considerations, atomic
> +operations are noted specially as some of them imply full memory barriers and
> +some don't, but they're very heavily relied on as a group throughout the
> +kernel.
> +
> +Any atomic_t operation, for instance, that returns a value implies an
> +SMP-conditional general memory barrier (smp_mb()) on each side of the actual
> +operation.  These include:

Actually: this only applies to operations which _both_ modify their atomic_t
operand and return a value. Eg. atomic_read() does not have barrier semantics.

>  
> -	xchg();
> -	cmpxchg();
> -	test_and_set_bit();
> -	test_and_clear_bit();
> -	test_and_change_bit();
>  	atomic_cmpxchg();
>  	atomic_inc_return();
>  	atomic_dec_return();
> @@ -1283,20 +1283,30 @@ barriers.  The possible offenders includ
>  	atomic_add_negative();
>  	atomic_add_unless();
>  
> -These may be used for such things as implementing LOCK operations or controlling
> -the lifetime of objects by decreasing their reference counts.  In such cases
> -they need preceding memory barriers.
>  
> -The following may also be possible offenders as they may be used as UNLOCK
> -operations.
> +The following, however, do _not_ imply memory barrier effects:
> +
> +	xchg();
> +	cmpxchg();
> +	test_and_set_bit();
> +	test_and_clear_bit();
> +	test_and_change_bit();
> +
> +These may be used for such things as implementing LOCK-class operations.  In
> +such cases they need explicit memory barriers.
> +

I believe all the bitops are essentially the same as the atomic semantics.
That is, if they change their operand and return something, they are full
barriers both ways.

atomic_ops.txt says of them:
   "These routines, like the atomic_t counter operations returning values,
    require explicit memory barrier semantics around their execution."

I think we'd have problems at least with TestSetPageLocked if this were
not the case.

I'm not sure if I like the words imply, explicit, implicit, etc. They're
a bit confusing. provide, semantics may be better?

> +The following are also potential offenders as they may be used as UNLOCK-class
> +operations, amongst other things, but do _not_ imply memory barriers either:
>  
>  	set_bit();
>  	clear_bit();
>  	change_bit();
>  	atomic_set();
>  
> +With these the appropriate explicit memory barrier should be used if necessary.
> +
>  

In particular, when clearing a bit to signal the end of a critical section,
clear_bit must be preceeded by smp_mb__before_clear_bit();

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
