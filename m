Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4798 "EHLO
 mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1726671AbgA2RUN (ORCPT <rfc822;linux-arch@vger.kernel.org>); Wed,
 29 Jan 2020 12:20:13 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00THJdcL054083
 for <linux-arch@vger.kernel.org>; Wed, 29 Jan 2020 12:20:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100]) by
 mx0a-001b2d01.pphosted.com with ESMTP id 2xrvw94eu7-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Wed, 29 Jan 2020 12:20:11 -0500
Received: from localhost by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>; Wed, 29 Jan 2020
 17:20:06 -0000
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches as
 usercopy caches
References: <1515636190-24061-10-git-send-email-keescook@chromium.org>
 <9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz>
 <201911121313.1097D6EE@keescook> <201911141327.4DE6510@keescook>
 <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz>
 <202001271519.AA6ADEACF0@keescook>
 <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com>
 <202001281457.FA11CC313A@keescook>
 <alpine.DEB.2.21.2001291640350.1546@www.lameter.com>
 <6844ea47-8e0e-4fb7-d86f-68046995a749@de.ibm.com>
 <20200129170939.GA4277@infradead.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 29 Jan 2020 18:19:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200129170939.GA4277@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <771c5511-c5ab-3dd1-d938-5dbc40396daa@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christopher Lameter <cl@linux.com>, Kees Cook <keescook@chromium.org>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Rik van Riel <riel@redhat.com>, Matthew Garrett <mjg59@google.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, kernel-hardening@lists.openwall.com, Vlastimil Babka <vbabka@suse.cz>, Michal Kubecek <mkubecek@suse.cz>
Message-ID: <20200129171956.ONF-qTBqh9M9Ts_E7ZX264olpCKNXOsGjCC7UcOlVbk@z>



On 29.01.20 18:09, Christoph Hellwig wrote:
> On Wed, Jan 29, 2020 at 06:07:14PM +0100, Christian Borntraeger wrote:
>>> DMA can be done to NORMAL memory as well.
>>
>> Exactly. 
>> I think iucv uses GFP_DMA because z/VM needs those buffers to reside below 2GB (which is ZONA_DMA for s390).
> 
> The normal way to allocate memory with addressing limits would be to
> use dma_alloc_coherent and friends.  Any chance to switch iucv over to
> that?  Or is there no device associated with it?

There is not necessarily a device for that. It is a hypervisor interface (an
instruction that is interpreted by z/VM). We do have the netiucv driver that
creates a virtual nic, but there is also AF_IUCV which works without a device.

But back to the original question: If we mark kmalloc caches as usercopy caches,
we should do the same for DMA kmalloc caches. As outlined by Christoph, this has
nothing to do with device DMA.
