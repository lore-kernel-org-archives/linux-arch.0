From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/9] arm/spinlock: Replace ACCESS_ONCE with READ_ONCE
Date: Wed, 3 Dec 2014 16:12:02 -0800
Message-ID: <20141204001202.GD25340@linux.vnet.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
 <1417645821-54731-8-git-send-email-borntraeger@de.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:50894 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaLDAMH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Dec 2014 19:12:07 -0500
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 3 Dec 2014 17:12:06 -0700
Content-Disposition: inline
In-Reply-To: <1417645821-54731-8-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On Wed, Dec 03, 2014 at 11:30:19PM +0100, Christian Borntraeger wrote:
> ACCESS_ONCE does not work reliably on non-scalar types. For
> example gcc 4.6 and 4.7 might remove the volatile tag for such
> accesses during the SRA (scalar replacement of aggregates) step
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
> 
> Change the spinlock code to replace ACCESS_ONCE with READ_ONCE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/arm/include/asm/spinlock.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
> index ac4bfae..0fa4184 100644
> --- a/arch/arm/include/asm/spinlock.h
> +++ b/arch/arm/include/asm/spinlock.h
> @@ -120,12 +120,12 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> 
>  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -	return !arch_spin_value_unlocked(ACCESS_ONCE(*lock));
> +	return !arch_spin_value_unlocked(READ_ONCE(*lock));
>  }
> 
>  static inline int arch_spin_is_contended(arch_spinlock_t *lock)
>  {
> -	struct __raw_tickets tickets = ACCESS_ONCE(lock->tickets);
> +	struct __raw_tickets tickets = READ_ONCE(lock->tickets);
>  	return (tickets.next - tickets.owner) > 1;
>  }
>  #define arch_spin_is_contended	arch_spin_is_contended
> -- 
> 1.9.3
> 
