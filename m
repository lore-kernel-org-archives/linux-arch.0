From: Kees Cook <keescook@chromium.org>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches
 as usercopy caches
Date: Thu, 30 Jan 2020 11:23:38 -0800
Message-ID: <202001300945.7D465B5F5@keescook>
References: <201911121313.1097D6EE@keescook>
 <201911141327.4DE6510@keescook>
 <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz>
 <202001271519.AA6ADEACF0@keescook>
 <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com>
 <202001281457.FA11CC313A@keescook>
 <alpine.DEB.2.21.2001291640350.1546@www.lameter.com>
 <6844ea47-8e0e-4fb7-d86f-68046995a749@de.ibm.com>
 <20200129170939.GA4277@infradead.org>
 <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christopher Lameter <cl@linux.com>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbon>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 29, 2020 at 06:19:56PM +0100, Christian Borntraeger wrote:
> On 29.01.20 18:09, Christoph Hellwig wrote:
> > On Wed, Jan 29, 2020 at 06:07:14PM +0100, Christian Borntraeger wrote:
> >>> DMA can be done to NORMAL memory as well.
> >>
> >> Exactly. 
> >> I think iucv uses GFP_DMA because z/VM needs those buffers to reside below 2GB (which is ZONA_DMA for s390).
> > 
> > The normal way to allocate memory with addressing limits would be to
> > use dma_alloc_coherent and friends.  Any chance to switch iucv over to
> > that?  Or is there no device associated with it?
> 
> There is not necessarily a device for that. It is a hypervisor interface (an
> instruction that is interpreted by z/VM). We do have the netiucv driver that
> creates a virtual nic, but there is also AF_IUCV which works without a device.
> 
> But back to the original question: If we mark kmalloc caches as usercopy caches,
> we should do the same for DMA kmalloc caches. As outlined by Christoph, this has
> nothing to do with device DMA.

Hm, looks like it's allocated from the low 16MB. Seems like poor naming!
:) There seems to be a LOT of stuff using GFP_DMA, and it seems unlikely
those are all expecting low addresses?

Since this has only been a problem on s390, should just s390 gain the
weakening of the usercopy restriction?  Something like:


diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1907cb2903c7..c5bbc141f20b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1303,7 +1303,9 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
 				kmalloc_info[i].name[KMALLOC_DMA],
 				kmalloc_info[i].size,
-				SLAB_CACHE_DMA | flags, 0, 0);
+				SLAB_CACHE_DMA | flags, 0,
+				IS_ENABLED(CONFIG_S390) ?
+					kmalloc_info[i].size : 0);
 		}
 	}
 #endif



-- 
Kees Cook
