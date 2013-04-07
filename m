Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:42525 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161469Ab3DGITE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Apr 2013 04:19:04 -0400
Date: Sun, 7 Apr 2013 09:59:02 +0200
From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH v4, part3 15/41] mm/AVR32: prepare for removing
 num_physpages and simplify mem_init()
Message-ID: <20130407075902.GA31879@samfundet.no>
References: <1365258760-30821-1-git-send-email-jiang.liu@huawei.com>
 <1365258760-30821-16-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365258760-30821-16-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
Message-ID: <20130407075902.VTMAV0p6N6pyIqL97bAJXFHmdHfKXjAtSZOI-vJn1aM@z>

Around Sat 06 Apr 2013 22:32:14 +0800 or thereabout, Jiang Liu wrote:
> Prepare for removing num_physpages and simplify mem_init().
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Cc: linux-kernel@vger.kernel.org (open list)

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/mm/init.c |   29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/avr32/mm/init.c b/arch/avr32/mm/init.c
> index 7e8d55a..c1706a0 100644
> --- a/arch/avr32/mm/init.c
> +++ b/arch/avr32/mm/init.c

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
