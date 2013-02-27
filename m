From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [patch] mm, show_mem: suppress page counts in non-blockable contexts
Date: Wed, 27 Feb 2013 07:51:45 -0800
Message-ID: <512E2B91.6000506@linux.vnet.ibm.com>
References: <alpine.DEB.2.02.1302261642520.11109@chino.kir.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:57537 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760122Ab3B0PwM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Feb 2013 10:52:12 -0500
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dave@linux.vnet.ibm.com>;
	Wed, 27 Feb 2013 10:52:11 -0500
In-Reply-To: <alpine.DEB.2.02.1302261642520.11109@chino.kir.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

On 02/26/2013 04:46 PM, David Rientjes wrote:
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -99,6 +99,9 @@ void show_mem(unsigned int filter)
>  	printk("Mem-info:\n");
>  	show_free_areas(filter);
> 
> +	if (filter & SHOW_MEM_FILTER_PAGE_COUNT)
> +		return;
> +

Won't this just look like a funky truncated warning to the end user?

Seems like we should at least dump out a little message for this stuff
to say that it's intentionally truncated?
