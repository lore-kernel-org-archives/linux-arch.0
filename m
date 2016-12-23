Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759834AbcLWNpl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Dec 2016 08:45:41 -0500
Date: Fri, 23 Dec 2016 14:45:39 +0100
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 1/4] dax: kill uml support
Message-ID: <20161223134539.GH22679@quack2.suse.cz>
References: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
 <1482441536-14550-2-git-send-email-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482441536-14550-2-git-send-email-ross.zwisler@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@intel.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <mawilcox@microsoft.com>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
Message-ID: <20161223134539.0Z6fJRqPle6eusA-6nyBo4B2bxszDjaZbUhNPjM4go8@z>

On Thu 22-12-16 14:18:53, Ross Zwisler wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> The lack of common transparent-huge-page helpers for UML is becoming
> increasingly painful for fs/dax.c now that it is growing more pmd
> functionality. Add UML to the list of unsupported architectures.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> [rez: squashed #ifdef removal into another patch in the series ]
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>

Fine by me. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index c2a377c..661931f 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -37,7 +37,7 @@ source "fs/f2fs/Kconfig"
>  config FS_DAX
>  	bool "Direct Access (DAX) support"
>  	depends on MMU
> -	depends on !(ARM || MIPS || SPARC)
> +	depends on !(ARM || MIPS || SPARC || UML)
>  	help
>  	  Direct Access (DAX) can be used on memory-backed block devices.
>  	  If the block device supports DAX and the filesystem supports DAX,
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
