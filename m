Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:60619 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965117Ab3E2IuI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 04:50:08 -0400
Message-ID: <51A5C126.9030105@synopsys.com>
Date: Wed, 29 May 2013 14:19:42 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH v7, part3 14/16] mm: concentrate modification of totalram_pages
 into the mm core
References: <1368805518-2634-1-git-send-email-jiang.liu@huawei.com> <1368805518-2634-15-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368805518-2634-15-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130529084942.GherJZlQCgGCRwAczrQg8LuqazCRTi2Y7Iltc3f3EdY@z>

On 05/17/2013 09:15 PM, Jiang Liu wrote:
> Concentrate code to modify totalram_pages into the mm core, so the arch
> memory initialized code doesn't need to take care of it. With these
> changes applied, only following functions from mm core modify global
> variable totalram_pages:
> free_bootmem_late(), free_all_bootmem(), free_all_bootmem_node(),
> adjust_managed_page_count().
> 
> With this patch applied, it will be much more easier for us to keep
> totalram_pages and zone->managed_pages in consistence.
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Acked-by: David Howells <dhowells@redhat.com>
> ---
>  arch/alpha/mm/init.c             | 2 +-
>  arch/alpha/mm/numa.c             | 2 +-
>  arch/arc/mm/init.c               | 2 +-

...

> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
> index f9c7077..c668a60 100644
> --- a/arch/arc/mm/init.c
> +++ b/arch/arc/mm/init.c
> @@ -111,7 +111,7 @@ void __init mem_init(void)
>  
>  	high_memory = (void *)(CONFIG_LINUX_LINK_BASE + arc_mem_sz);
>  
> -	totalram_pages = free_all_bootmem();
> +	free_all_bootmem();
>  
>  	/* count all reserved pages [kernel code/data/mem_map..] */
>  	reserved_pages = 0;

Acked-by: Vineet Gupta <vgupta@synopsys.com>	for arch/arc bits

Thx,
-Vineet

