Return-Path: <ak@suse.de>
Received: from cantor.suse.de ([195.135.220.2]:29584 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264933AbUEQJJz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2004 05:09:55 -0400
Date: Mon, 17 May 2004 11:09:54 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
Message-ID: <20040517090953.GB4903@wotan.suse.de>
References: <40A60984.1070202@colorfullife.com> <40A60BE1.2060809@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A60BE1.2060809@colorfullife.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> --- 2.6/include/linux/types.h	2004-05-15 11:21:51.000000000 +0200
> +++ build-2.6/include/linux/types.h	2004-05-15 12:57:29.000000000 +0200
> @@ -140,6 +140,9 @@
>  #define pgoff_t unsigned long
>  #endif
>  
> +#ifndef HAVE_KMEM_BUFCTL_T
> +typedef unsigned int kmem_bufctl_t;
> +#endif

Please remove the ifdef and add type to every arch's asm-*/posix_types.h

-Andi
