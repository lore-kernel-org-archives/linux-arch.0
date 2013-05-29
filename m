Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:50786 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965117Ab3E2IwY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2013 04:52:24 -0400
Message-ID: <51A5C1AE.6000805@synopsys.com>
Date: Wed, 29 May 2013 14:21:58 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8, part3 02/14] mm: enhance free_reserved_area() to support
 poisoning memory with zero
References: <1369575522-26405-1-git-send-email-jiang.liu@huawei.com> <1369575522-26405-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1369575522-26405-3-git-send-email-jiang.liu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20130529085158.yqIpQPxNZFzMIAYrXznMNLOoRxsk69TIwF8HWdlSsME@z>

On 05/26/2013 07:08 PM, Jiang Liu wrote:
> Address more review comments from last round of code review.
> 1) Enhance free_reserved_area() to support poisoning freed memory with
>    pattern '0'. This could be used to get rid of poison_init_mem()
>    on ARM64.
> 2) A previous patch has disabled memory poison for initmem on s390
>    by mistake, so restore to the original behavior.
> 3) Remove redundant PAGE_ALIGN() when calling free_reserved_area().
> 
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>

Can you apply these to you github v5 branch as well !

Thx,
-Vineet

