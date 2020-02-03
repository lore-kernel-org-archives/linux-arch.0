From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches
 as usercopy caches
Date: Mon, 3 Feb 2020 09:38:11 -0800
Message-ID: <20200203173811.GB30011@infradead.org>
References: <201911141327.4DE6510@keescook>
 <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz>
 <202001271519.AA6ADEACF0@keescook>
 <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com>
 <202001281457.FA11CC313A@keescook>
 <alpine.DEB.2.21.2001291640350.1546@www.lameter.com>
 <6844ea47-8e0e-4fb7-d86f-68046995a749@de.ibm.com>
 <20200129170939.GA4277@infradead.org>
 <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com>
 <202001300945.7D465B5F5@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBCRiP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 12:38:15 -0500
Content-Disposition: inline
In-Reply-To: <202001300945.7D465B5F5@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, Christopher Lameter <cl@linux.com>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>

On Thu, Jan 30, 2020 at 11:23:38AM -0800, Kees Cook wrote:
> Hm, looks like it's allocated from the low 16MB. Seems like poor naming!
> :) There seems to be a LOT of stuff using GFP_DMA, and it seems unlikely
> those are all expecting low addresses?

Most of that is either completely or partially bogus.  Besides the
weird S/390 stuff pretty much everything should be using the dma
allocators.  A couple really messed up drivers even pass GFP_DMA*
to the dma allocator, but my patches to fix that up seem to be stuck.
