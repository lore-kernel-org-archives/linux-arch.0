From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 08/16] xen, mm: Set IORESOURCE_SYSTEM_RAM
 to System RAM
Date: Mon, 4 Jan 2016 11:41:31 +0000
Message-ID: <568A5A6B.3030700@citrix.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-8-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:49740 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcADLle (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2016 06:41:34 -0500
In-Reply-To: <1451081365-15190-8-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>, akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org

On 25/12/15 22:09, Toshi Kani wrote:
> Set IORESOURCE_SYSTEM_RAM to 'flags' of struct resource entries
> with "System RAM".
[...]
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -257,7 +257,7 @@ static struct resource *additional_memory_resource(phys_addr_t size)
>  		return NULL;
>  
>  	res->name = "System RAM";
> -	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  
>  	ret = allocate_resource(&iomem_resource, res,
>  				size, 0, -1,

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
