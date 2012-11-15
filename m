Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57827 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992548Ab2KOB2b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2012 20:28:31 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so714970pad.19
        for <linux-arch@vger.kernel.org>; Wed, 14 Nov 2012 17:28:31 -0800 (PST)
Date: Wed, 14 Nov 2012 17:28:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/2] asm-generic: add __WARN() to bug.h
In-Reply-To: <50A43E5E.9040905@xenotime.net>
Message-ID: <alpine.DEB.2.00.1211141726380.4749@chino.kir.corp.google.com>
References: <20121114163042.64f0c0495663331b9c2d60d6@canb.auug.org.au> <50A43E5E.9040905@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org
Message-ID: <20121115012829.GOxqIEOATa1vus9iHktAk6NsbjBbxyLpoL_6lEzlS-U@z>

On Wed, 14 Nov 2012, Randy Dunlap wrote:

> --- linux-next-20121114.orig/include/asm-generic/bug.h
> +++ linux-next-20121114/include/asm-generic/bug.h
> @@ -129,6 +129,10 @@ extern void warn_slowpath_null(const cha
>  })
>  #endif
>  
> +#ifndef __WARN
> +#define __WARN()	do {} while (0)
> +#endif
> +
>  #define WARN_TAINT(condition, taint, format...) WARN_ON(condition)
>  
>  #endif

__WARN() isn't supposed to be used by generic code, though.  The 
mm/balloon_compaction.c error should be resolved by 
mm-introduce-a-common-interface-for-balloon-pages-mobility-fix-fix-fix.patch 
added to -mm today.  It converts the __WARN() there into WARN_ON(1) which 
is defined appropriately for CONFIG_BUG=n.
