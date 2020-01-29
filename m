From: Ursula Braun <ubraun@linux.ibm.com>
Subject: Re: [kernel-hardening] [PATCH 09/38] usercopy: Mark kmalloc caches as
 usercopy caches
Date: Wed, 29 Jan 2020 10:26:07 +0100
Message-ID: <009da641-175c-4a50-d658-a40ac0ca7bc6@linux.ibm.com>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1515636190-24061-10-git-send-email-keescook@chromium.org>
 <9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz>
 <201911121313.1097D6EE@keescook> <201911141327.4DE6510@keescook>
 <bfca96db-bbd0-d958-7732-76e36c667c68@suse.cz>
 <202001271519.AA6ADEACF0@keescook>
 <5861936c-1fe1-4c44-d012-26efa0c8b6e7@de.ibm.com>
 <202001281457.FA11CC313A@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202001281457.FA11CC313A@keescook>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Julian Wiedmann <jwi@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, David Windsor <dave@nullcore.net>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-xfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoffer Dall <christoffer>
List-Id: linux-arch.vger.kernel.org



On 1/29/20 12:01 AM, Kees Cook wrote:
> On Tue, Jan 28, 2020 at 08:58:31AM +0100, Christian Borntraeger wrote:
>>
>>
>> On 28.01.20 00:19, Kees Cook wrote:
>>> On Thu, Jan 23, 2020 at 09:14:20AM +0100, Jiri Slaby wrote:
>>>> On 14. 11. 19, 22:27, Kees Cook wrote:
>>>>> On Tue, Nov 12, 2019 at 01:21:54PM -0800, Kees Cook wrote:
>>>>>> How is iucv the only network protocol that has run into this? Do others
>>>>>> use a bounce buffer?
>>>>>
>>>>> Another solution would be to use a dedicated kmem cache (instead of the
>>>>> shared kmalloc dma one)?
>>>>
>>>> Has there been any conclusion to this thread yet? For the time being, we
>>>> disabled HARDENED_USERCOPY on s390...
>>>>
>>>> https://lore.kernel.org/kernel-hardening/9519edb7-456a-a2fa-659e-3e5a1ff89466@suse.cz/
>>>
>>> I haven't heard anything new. What did people think of a separate kmem
>>> cache?
>>>
>>
>> Adding Julian and Ursula. A separate kmem cache for iucv might be indeed
>> a solution for the user hardening issue.
> 
> It should be very clean -- any existing kmallocs already have to be
> "special" in the sense that they're marked with the DMA flag. So
> converting these to a separate cache should be mostly mechanical.
> 

Linux on System z can run within a guest hosted by the IBM mainframe operating system
z/VM. z/VM offers a transport called Inter-User Communications Vehicle (short IUCV).
It is limited to 4-byte-addresses when sending and receiving data.
One base transport for AF_IUCV sockets in the Linux kernel is this Inter-User
Communications Vehicle of z/VM. AF_IUCV sockets exist for s390 only. 

AF_IUCV sockets make use of the base socket layer, and work with sk_buffs for sending
and receiving data of variable length.
Storage for sk_buffs is allocated with __alloc_skb(), which invokes
   data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
For IUCV transport the "data"-address should fit into 4 bytes. That's the reason why
we work with GFP_DMA here.

kmem_caches manage memory of fixed size. This does not fit well for sk_buff memory
of variable length. Do you propose to add a kmem_cache solution for sk_buff memory here?

>> On the other hand not marking the DMA caches still seems questionable.
> 
> My understanding is that exposing DMA memory to userspace copies can
> lead to unexpected results, especially for misbehaving hardware, so I'm
> not convinced this is a generically bad hardening choice.
> 

We have not yet been reported a memory problem here. Do you have more details, if
this is really a problem for the s390 architecture?

Kind regards, Ursula 

> -Kees
> 
>>
>> For reference
>> https://bugzilla.suse.com/show_bug.cgi?id=1156053
>> the kernel hardening now triggers a warning.
>>
> 
