From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Date: Tue, 28 Apr 2020 20:36:41 +0100
Message-ID: <20200428193641.GA35158@C02TF0J2HF1T.local>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:58186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgD1Tgs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 15:36:48 -0400
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-21-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>

On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3025,13 +3025,16 @@ void *copy_mount_options(const void __user * data)
>  	if (!copy)
>  		return ERR_PTR(-ENOMEM);
>  
> -	size = PAGE_SIZE - offset_in_page(data);
> +	size = PAGE_SIZE;
> +	if (!arch_has_exact_copy_from_user(size))
> +		size -= offset_in_page(data);
>  
> -	if (copy_from_user(copy, data, size)) {
> +	if (copy_from_user(copy, data, size) == size) {
>  		kfree(copy);
>  		return ERR_PTR(-EFAULT);
>  	}
>  	if (size != PAGE_SIZE) {
> +		WARN_ON(1);
>  		if (copy_from_user(copy + size, data + size, PAGE_SIZE - size))
>  			memset(copy + size, 0, PAGE_SIZE - size);
>  	}

Argh, this WARN_ON should not be here at all. It's something I added to
make check that I don't reach this part in arm64. Will remove in v4.

-- 
Catalin
