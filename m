From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/9] mips/gup: Replace ACCESS_ONCE with READ_ONCE
Date: Wed, 3 Dec 2014 16:11:16 -0800
Message-ID: <20141204001116.GB25340@linux.vnet.ibm.com>
References: <1417645821-54731-1-git-send-email-borntraeger@de.ibm.com>
 <1417645821-54731-6-git-send-email-borntraeger@de.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:37651 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbaLDALU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Dec 2014 19:11:20 -0500
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Wed, 3 Dec 2014 17:11:20 -0700
Content-Disposition: inline
In-Reply-To: <1417645821-54731-6-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On Wed, Dec 03, 2014 at 11:30:17PM +0100, Christian Borntraeger wrote:
> ACCESS_ONCE does not work reliably on non-scalar types. For
> example gcc 4.6 and 4.7 might remove the volatile tag for such
> accesses during the SRA (scalar replacement of aggregates) step
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
> 
> Change the gup code to replace ACCESS_ONCE with READ_ONCE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
>  arch/mips/mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
> index 06ce17c..8aa50e3 100644
> --- a/arch/mips/mm/gup.c
> +++ b/arch/mips/mm/gup.c
> @@ -30,7 +30,7 @@ retry:
> 
>  	return pte;
>  #else
> -	return ACCESS_ONCE(*ptep);
> +	return READ_ONCE(*ptep);
>  #endif
>  }
> 
> -- 
> 1.9.3
> 
