From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 15/25] memconsole: fix __iomem mishandling, switch to
 memremap
Date: Sun, 26 Jul 2015 01:02:32 +0300
Message-ID: <55B40778.4010909@cogentembedded.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023923.8664.66965.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:33741 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbbGYWCh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jul 2015 18:02:37 -0400
Received: by laah7 with SMTP id h7so30938215laa.0
        for <linux-arch@vger.kernel.org>; Sat, 25 Jul 2015 15:02:35 -0700 (PDT)
In-Reply-To: <20150725023923.8664.66965.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
Cc: linux-arch@vger.kernel.org, toshi.kani@hp.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Mike Waychison <mikew@google.com>, rmk+kernel@arm.linux.org.uk, hch@lst.de, linux-arm-kernel@lists.infradead.org

Hello.

On 07/25/2015 05:39 AM, Dan Williams wrote:

> The memconsole driver is not using proper accessors for __iomem.  Switch
> to memremap to fix this issue, and this also prepares the driver for the
> removal of ioremap_cache.

> Cc: Mike Waychison <mikew@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/firmware/google/memconsole.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/google/memconsole.c
> index 2f569aaed4c7..1b25fba84f32 100644
> --- a/drivers/firmware/google/memconsole.c
> +++ b/drivers/firmware/google/memconsole.c
> @@ -52,14 +52,15 @@ static ssize_t memconsole_read(struct file *filp, struct kobject *kobp,
>   	char *memconsole;
>   	ssize_t ret;
>
> -	memconsole = ioremap_cache(memconsole_baseaddr, memconsole_length);
> +	memconsole = memremap(memconsole_baseaddr, memconsole_length,
> +			MEMREMAP_CACHE);

    Could you maintain the existing style of the broken line alignment in this 
file?

>   	if (!memconsole) {
> -		pr_err("memconsole: ioremap_cache failed\n");
> +		pr_err("memconsole: memremap failed\n");
>   		return -ENOMEM;
>   	}
>   	ret = memory_read_from_buffer(buf, count, &pos, memconsole,
>   				      memconsole_length);

    Here's an example...

> -	iounmap(memconsole);
> +	memunmap(memconsole);
>   	return ret;
>   }

MBR, Sergei
