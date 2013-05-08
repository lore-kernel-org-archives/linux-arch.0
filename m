From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v5, part4 20/41] mm/h8300: prepare for removing num_physpages
 and simplify mem_init()
Date: Wed, 08 May 2013 20:26:40 +0400
Message-ID: <518A7CC0.1010606@cogentembedded.com>
References: <1368028298-7401-1-git-send-email-jiang.liu@huawei.com> <1368028298-7401-21-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:64480 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab3EHQ0j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2013 12:26:39 -0400
Received: by mail-la0-f49.google.com with SMTP id eh20so1920690lab.22
        for <linux-arch@vger.kernel.org>; Wed, 08 May 2013 09:26:38 -0700 (PDT)
In-Reply-To: <1368028298-7401-21-git-send-email-jiang.liu@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@huawei.com>, David Rientjes <rientjes@google.com>, Wen Congyang <wency@cn.fujitsu.com>, Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@suse.cz>, James Bottomley <James.Bottomley@HansenPartnership.com>, David Howells <dhowells@redhat.com>, Mark Salter <msalter@redhat.com>, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>

Hello.

On 08-05-2013 19:51, Jiang Liu wrote:

> Prepare for removing num_physpages and simplify mem_init().

> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>   arch/h8300/mm/init.c |   34 ++++++++--------------------------
>   1 file changed, 8 insertions(+), 26 deletions(-)

> diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
> index 22fd869..0088f3a 100644
> --- a/arch/h8300/mm/init.c
> +++ b/arch/h8300/mm/init.c
> @@ -121,40 +121,22 @@ void __init paging_init(void)
>
>   void __init mem_init(void)
>   {
> -	int codek = 0, datak = 0, initk = 0;
> -	/* DAVIDM look at setup memory map generically with reserved area */
> -	unsigned long tmp;
> -	extern unsigned long  _ramend, _ramstart;
> -	unsigned long len = &_ramend - &_ramstart;
> -	unsigned long start_mem = memory_start; /* DAVIDM - these must start at end of kernel */
> -	unsigned long end_mem   = memory_end; /* DAVIDM - this must not include kernel stack at top */
> +	unsigned long codesize = _etext - _stext;
>
>   #ifdef DEBUG
> -	printk(KERN_DEBUG "Mem_init: start=%lx, end=%lx\n", start_mem, end_mem);
> +	pr_debug("Mem_init: start=%lx, end=%lx\n", memory_start, memory_end);
>   #endif

     pr_debug() only prints something if DEBUG is #define'd, so you can 
drop the #ifdef here.

WBR, Sergei
