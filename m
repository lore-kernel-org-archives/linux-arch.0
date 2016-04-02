From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/3] mm/mmap.c: don't unmap the overlapping VMA(s)
Date: Sun, 3 Apr 2016 00:54:30 +0300
Message-ID: <20160402215430.GA100607@black.fi.intel.com>
References: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27618 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766AbcDBVyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Apr 2016 17:54:47 -0400
Content-Disposition: inline
In-Reply-To: <1459624654-7955-1-git-send-email-kwapulinski.piotr@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Piotr Kwapulinski <kwapulinski.piotr@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, mtk.manpages@gmail.com, cmetcalf@mellanox.com, arnd@arndb.de, viro@zeniv.linux.org.uk, mszeredi@suse.cz, dave@stgolabs.net, vbabka@suse.cz, mingo@kernel.org, dan.j.williams@intel.com, dave.hansen@linux.intel.com, koct9i@gmail.com, hannes@cmpxchg.org, jack@suse.cz, xiexiuqi@huawei.com, iamjoonsoo.kim@lge.com, oleg@redhat.com, gang.chen.5i5j@gmail.com, aarcange@redhat.com, aryabinin@virtuozzo.com, rientjes@google.com, denc716@gmail.com, toshi.kani@hpe.com, ldufour@linux.vnet.ibm.com, kuleshovmail@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org

On Sat, Apr 02, 2016 at 09:17:31PM +0200, Piotr Kwapulinski wrote:
> @@ -19,6 +19,7 @@
>  #define MAP_TYPE	0x0f		/* Mask for type of mapping */
>  #define MAP_FIXED	0x10		/* Interpret addr exactly */
>  #define MAP_ANONYMOUS	0x20		/* don't use a file */
> +#define MAP_DONTUNMAP	0x40		/* don't unmap overlapping VMA */

NAK.

arch/powerpc/include/uapi/asm/mman.h:#define MAP_NORESERVE   0x40            /* don't reserve swap pages */
arch/sparc/include/uapi/asm/mman.h:#define MAP_NORESERVE   0x40            /* don't reserve swap pages */
arch/x86/include/uapi/asm/mman.h:#define MAP_32BIT      0x40            /* only give out 32bit addresses */

-- 
 Kirill A. Shutemov
