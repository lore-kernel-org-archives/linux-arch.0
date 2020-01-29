From: Christopher Lameter <cl@linux.com>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches
 as usercopy caches
Date: Wed, 29 Jan 2020 16:43:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.2001291640350.1546@www.lameter.com>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org> <1515636190-24061-10-git-send-email-keescook@chromium.org> <9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz> <201911121313.1097D6EE@keescook> <201911141327.4DE6510@keescook>
 <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz> <202001271519.AA6ADEACF0@keescook> <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com> <202001281457.FA11CC313A@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gentwo.org ([3.19.106.255]:40906 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgA2Qnb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 11:43:31 -0500
In-Reply-To: <202001281457.FA11CC313A@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo

On Tue, 28 Jan 2020, Kees Cook wrote:

> > On the other hand not marking the DMA caches still seems questionable.
>
> My understanding is that exposing DMA memory to userspace copies can
> lead to unexpected results, especially for misbehaving hardware, so I'm
> not convinced this is a generically bad hardening choice.

"DMA" memory (and thus DMA caches) have nothing to do with DMA. Its a
legacy term. "DMA Memory" is memory limited to a certain
physical address boundary (old restrictions on certain devices only
supporting a limited number of address bits).

DMA can be done to NORMAL memory as well.
