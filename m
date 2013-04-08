From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v4, part3 11/15] mm: use a dedicated lock to protect totalram_pages
 and zone->managed_pages
Date: Mon, 08 Apr 2013 09:39:19 -0400
Message-ID: <5162C887.5070900@redhat.com>
References: <1365256509-29024-1-git-send-email-jiang.liu@huawei.com> <1365256509-29024-12-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365256509-29024-12-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michel Lespinasse <walken@google.com>
List-Id: linux-arch.vger.kernel.org

On 04/06/2013 09:55 AM, Jiang Liu wrote:

> @@ -5186,6 +5189,22 @@ early_param("movablecore", cmdline_parse_movablecore);
>
>   #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>
> +void adjust_managed_page_count(struct page *page, long count)
> +{
> +	bool lock = (system_state != SYSTEM_BOOTING);
> +
> +	/* No need to acquire the lock during boot */
> +	if (lock)
> +		spin_lock(&managed_page_count_lock);
> +
> +	page_zone(page)->managed_pages += count;
> +	totalram_pages += count;
> +
> +	if (lock)
> +		spin_unlock(&managed_page_count_lock);
> +}

While I agree the boot code currently does not need the lock, is
there any harm to removing that conditional?

That would simplify the code, and protect against possible future
cleverness of initializing multiple memory things simultaneously.

-- 
All rights reversed
