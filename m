From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches
 as usercopy caches
Date: Mon, 3 Feb 2020 09:36:22 -0800
Message-ID: <20200203173622.GA30011@infradead.org>
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
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBCRge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 12:36:34 -0500
Content-Disposition: inline
In-Reply-To: <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christopher Lameter <cl@linux.com>, Kees Cook <keescook@chromium.org>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracl>

On Wed, Jan 29, 2020 at 06:19:56PM +0100, Christian Borntraeger wrote:
> There is not necessarily a device for that. It is a hypervisor interface (an
> instruction that is interpreted by z/VM). We do have the netiucv driver that
> creates a virtual nic, but there is also AF_IUCV which works without a device.
> 
> But back to the original question: If we mark kmalloc caches as usercopy caches,
> we should do the same for DMA kmalloc caches. As outlined by Christoph, this has
> nothing to do with device DMA.

Oh well, s/390 with its weird mix of cpu and I/O again.  Everywhere else
where we have addressing limits we do treat that as a DMA address.

We've also had a bit of a lose plan to force ZONE_DMA as a public
interface out, as it is generally the wrong thing to do for drivers.
A ZONE_32 and/or ZONE_31 makes some sense as the backing for the
dma allocator, but it mostly shouldn't be exposed, especially not to
the slab allocator.
