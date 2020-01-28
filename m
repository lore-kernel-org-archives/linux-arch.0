Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54310 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1725810AbgA1H6r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Tue, 28 Jan 2020 02:58:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1]) by
 mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S7s3RV001264
 for <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 02:58:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97]) by
 mx0b-001b2d01.pphosted.com with ESMTP id 2xsqa41m0j-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Tue, 28 Jan 2020 02:58:45 -0500
Received: from localhost by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>; Tue, 28 Jan 2020
 07:58:43 -0000
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches as
 usercopy caches
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1515636190-24061-10-git-send-email-keescook@chromium.org>
 <9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz>
 <201911121313.1097D6EE@keescook> <201911141327.4DE6510@keescook>
 <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz>
 <202001271519.AA6ADEACF0@keescook>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 28 Jan 2020 08:58:31 +0100
MIME-Version: 1.0
In-Reply-To: <202001271519.AA6ADEACF0@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-ID: <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Rik van Riel <riel@redhat.com>, Matthew Garrett <mjg59@google.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, kernel-hardening@lists.openwall.com, Vlastimil Babka <vbabka@suse.cz>, Michal Kubecek <mkubecek@suse.cz>
Message-ID: <20200128075831._ivsuGek3YR7hnmOixWd5B_uMBfnclKLrXKNFpm3nAk@z>



On 28.01.20 00:19, Kees Cook wrote:
> On Thu, Jan 23, 2020 at 09:14:20AM +0100, Jiri Slaby wrote:
>> On 14. 11. 19, 22:27, Kees Cook wrote:
>>> On Tue, Nov 12, 2019 at 01:21:54PM -0800, Kees Cook wrote:
>>>> How is iucv the only network protocol that has run into this? Do others
>>>> use a bounce buffer?
>>>
>>> Another solution would be to use a dedicated kmem cache (instead of the
>>> shared kmalloc dma one)?
>>
>> Has there been any conclusion to this thread yet? For the time being, we
>> disabled HARDENED_USERCOPY on s390...
>>
>> https://lore.kernel.org/kernel-hardening/9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz/
> 
> I haven't heard anything new. What did people think of a separate kmem
> cache?
> 

Adding Julian and Ursula. A separate kmem cache for iucv might be indeed
a solution for the user hardening issue.
On the other hand not marking the DMA caches still seems questionable.

For reference
https://bugzilla.suse.com/show_bug.cgi?id=1156053
the kernel hardening now triggers a warning.
