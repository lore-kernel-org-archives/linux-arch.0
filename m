Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33885 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfKLHSG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 02:18:06 -0500
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches as
 usercopy caches
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1515636190-24061-10-git-send-email-keescook@chromium.org>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz>
Date: Tue, 12 Nov 2019 08:17:57 +0100
MIME-Version: 1.0
In-Reply-To: <1515636190-24061-10-git-send-email-keescook@chromium.org>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Rik van Riel <riel@redhat.com>, Matthew Garrett <mjg59@google.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, kernel-hardening@lists.openwall.com, Vlastimil Babka <vbabka@suse.cz>, Michal Kubecek <mkubecek@suse.cz>
Message-ID: <20191112071757.r7DIuvOjTYESAgTi6-7A3w5anRMEfLCA60GscHwjhvI@z>

On 11. 01. 18, 3:02, Kees Cook wrote:
> From: David Windsor <dave@nullcore.net>
> 
> Mark the kmalloc slab caches as entirely whitelisted. These caches
> are frequently used to fulfill kernel allocations that contain data
> to be copied to/from userspace. Internal-only uses are also common,
> but are scattered in the kernel. For now, mark all the kmalloc caches
> as whitelisted.
> 
> This patch is modified from Brad Spengler/PaX Team's PAX_USERCOPY
> whitelisting code in the last public patch of grsecurity/PaX based on my
> understanding of the code. Changes or omissions from the original code are
> mine and don't reflect the original grsecurity/PaX code.
> 
> Signed-off-by: David Windsor <dave@nullcore.net>
> [kees: merged in moved kmalloc hunks, adjust commit log]
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Christoph Lameter <cl@linux.com>
> ---
>  mm/slab.c        |  3 ++-
>  mm/slab.h        |  3 ++-
>  mm/slab_common.c | 10 ++++++----
>  3 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index b9b0df620bb9..dd367fe17a4e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
...
> @@ -1098,7 +1099,8 @@ void __init setup_kmalloc_cache_index_table(void)
>  static void __init new_kmalloc_cache(int idx, slab_flags_t flags)
>  {
>  	kmalloc_caches[idx] = create_kmalloc_cache(kmalloc_info[idx].name,
> -					kmalloc_info[idx].size, flags);
> +					kmalloc_info[idx].size, flags, 0,
> +					kmalloc_info[idx].size);
>  }
>  
>  /*
> @@ -1139,7 +1141,7 @@ void __init create_kmalloc_caches(slab_flags_t flags)
>  
>  			BUG_ON(!n);
>  			kmalloc_dma_caches[i] = create_kmalloc_cache(n,
> -				size, SLAB_CACHE_DMA | flags);
> +				size, SLAB_CACHE_DMA | flags, 0, 0);

Hi,

was there any (undocumented) reason NOT to mark DMA caches as usercopy?

We are seeing this on s390x:

> usercopy: Kernel memory overwrite attempt detected to SLUB object
'dma-kmalloc-1k' (offset 0, size 11)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:99!

See:
https://bugzilla.suse.com/show_bug.cgi?id=1156053

This indeed fixes it:
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1290,7 +1290,8 @@ void __init create_kmalloc_caches(slab_flags_t flags)
                        kmalloc_caches[KMALLOC_DMA][i] =
create_kmalloc_cache(
                                kmalloc_info[i].name[KMALLOC_DMA],
                                kmalloc_info[i].size,
-                               SLAB_CACHE_DMA | flags, 0, 0);
+                               SLAB_CACHE_DMA | flags, 0,
+                               kmalloc_info[i].size);
                }
        }
 #endif


thanks,
-- 
js
suse labs
