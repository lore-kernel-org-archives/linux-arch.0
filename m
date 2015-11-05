Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57526 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032102AbbKEK7B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2015 05:59:01 -0500
Date: Thu, 5 Nov 2015 03:02:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] asm/sections: Add helpers to check for section data
Message-ID: <20151105030221.68b7e98c.akpm@linux-foundation.org>
In-Reply-To: <1446107167-7001-1-git-send-email-thierry.reding@gmail.com>
References: <1446107167-7001-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20151105110221.SJDhSiM4JwEYlBKW893u7dLfBooV9_2boBei2JBkB4Q@z>

On Thu, 29 Oct 2015 09:26:06 +0100 Thierry Reding <thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
> 
> Add a helper to check if an object (given an address and a size) is part
> of a section (given beginning and end addresses). For convenience, also
> provide a helper that performs this check for __init data using the
> __init_begin and __init_end limits.
> 
> ...
>
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -63,4 +63,15 @@ static inline int arch_is_kernel_data(unsigned long addr)
>  }
>  #endif
>  
> +static inline bool section_contains(void *virt, size_t size, void *begin,
> +				    void *end)
> +{
> +	return virt >= begin && virt + size <= end;
> +}

This is ambiguous: does it return true if the object is wholly within
the region, or if it is only partially within the region.  A code
comment will help.  Something like

/*
 * Return true if the region described by [virt, virt+size) is wholly contained
 * within the region described by [begin, end).
 */


Which makes me wonder whether this function should in fact do
"partially within".  Shrug, doesn't matter much I guess.


