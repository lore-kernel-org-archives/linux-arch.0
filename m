Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:64171 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751637AbWHYAXy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Aug 2006 20:23:54 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7P0NphF032254
	for <linux-arch@vger.kernel.org>; Thu, 24 Aug 2006 20:23:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k7P0NplU371684
	for <linux-arch@vger.kernel.org>; Thu, 24 Aug 2006 18:23:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k7P0No8W014817
	for <linux-arch@vger.kernel.org>; Thu, 24 Aug 2006 18:23:51 -0600
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
From: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060825001459.GE3580@holomorphy.com>
References: <20060824234445.6B519D52@localhost.localdomain>
	 <20060824235806.GD3580@holomorphy.com>
	 <1156464441.12011.151.camel@localhost.localdomain>
	 <20060825001459.GE3580@holomorphy.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:23:44 -0700
Message-Id: <1156465424.12011.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-08-24 at 17:14 -0700, William Lee Irwin III wrote:
> With CONFIG_PAGE_SHIFT there doesn't need to be a CONFIG_PAGE_SIZE at
> all; just let #define PAGE_SIZE (1 << PAGE_SHIFT) handle it. 

I think it does that:

> +#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
> +#define PAGE_SIZE       (ASM_CONST(1) << PAGE_SHIFT)

Is it the Kconfig names themselves which you don't like?  I guess it is
a bit silly to have CONFIG_PAGE_SIZE_X, defined to be number Y, which is
then calculated back to being X again.  But, we were really already
doing that (in three places):

> -#if defined(CONFIG_SPARC64_PAGE_SIZE_8KB)
> -#define PAGE_SHIFT   13
> -#elif defined(CONFIG_SPARC64_PAGE_SIZE_64KB)
> -#define PAGE_SHIFT   16
> -#elif defined(CONFIG_SPARC64_PAGE_SIZE_512KB)
> -#define PAGE_SHIFT   19
> -#elif defined(CONFIG_SPARC64_PAGE_SIZE_4MB)
> -#define PAGE_SHIFT   22
> -#else
> -#error No page size specified in kernel configuration
> -#endif

But, unless users are willing to live with CONFIG_SMALLEST_PAGE,
CONFIG_SLIGHTLY_LESS_SMALL_PAGE, CONFIG_MEDIUM_SIZE_PAGE, etc... I'm not
sure what other names we can use.  Does it seem any less objectionable
to think of the Kconfig options as just the names that we _present_ to
users?  

-- Dave

