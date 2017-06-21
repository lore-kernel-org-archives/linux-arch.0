Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0043.outbound.protection.outlook.com ([104.47.34.43]:52510
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752573AbdFUSag (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jun 2017 14:30:36 -0400
Subject: Re: [PATCH v7 08/36] x86/mm: Add support to enable SME in early boot
 processing
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185115.18967.79622.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1706202259290.2157@nanos>
 <8d3c215f-cdad-5554-6e9c-5598e1081850@amd.com>
 <alpine.DEB.2.20.1706211720060.2328@nanos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <fc697503-ec54-f481-36b3-3d5bf63aaaee@amd.com>
Date: Wed, 21 Jun 2017 13:30:19 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706211720060.2328@nanos>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170621183019.CXGMMW6qHKlOiscEm3gmUnFIjplPV2qHf4-r_CqL0S0@z>

On 6/21/2017 10:38 AM, Thomas Gleixner wrote:
> On Wed, 21 Jun 2017, Tom Lendacky wrote:
>> On 6/21/2017 2:16 AM, Thomas Gleixner wrote:
>>> Why is this an unconditional function? Isn't the mask simply 0 when the MEM
>>> ENCRYPT support is disabled?
>>
>> I made it unconditional because of the call from head_64.S. I can't make
>> use of the C level static inline function and since the mask is not a
>> variable if CONFIG_AMD_MEM_ENCRYPT is not configured (#defined to 0) I
>> can't reference the variable directly.
>>
>> I could create a #define in head_64.S that changes this to load rax with
>> the variable if CONFIG_AMD_MEM_ENCRYPT is configured or a zero if it's
>> not or add a #ifdef at that point in the code directly. Thoughts on
>> that?
> 
> See below.
> 
>>> That does not make any sense. Neither the call to sme_encrypt_kernel() nor
>>> the following call to sme_get_me_mask().
>>>
>>> __startup_64() is already C code, so why can't you simply call that from
>>> __startup_64() in C and return the mask from there?
>>
>> I was trying to keep it explicit as to what was happening, but I can
>> move those calls into __startup_64().
> 
> That's much preferred. And the return value wants to be documented in both
> C and ASM code.

Will do.

> 
>> I'll still need the call to sme_get_me_mask() in the secondary_startup_64
>> path, though (depending on your thoughts to the above response).
> 
>          call verify_cpu
> 
>          movq    $(init_top_pgt - __START_KERNEL_map), %rax
> 
> So if you make that:
> 
> 	/*
> 	 * Sanitize CPU configuration and retrieve the modifier
> 	 * for the initial pgdir entry which will be programmed
> 	 * into CR3. Depends on enabled SME encryption, normally 0.
> 	 */
> 	call __startup_secondary_64
> 
>          addq    $(init_top_pgt - __START_KERNEL_map), %rax
> 
> You can hide that stuff in C-code nicely without adding any cruft to the
> ASM code.
> 

Moving the call to verify_cpu into the C-code might be quite a bit of
change.  Currently, the verify_cpu code is included code and not a
global function.  I can still do the __startup_secondary_64() function
and then look to incorporate verify_cpu into both __startup_64() and
__startup_secondary_64() as a post-patch to this series. At least the
secondary path will have a base C routine to which modifications can
be made in the future if needed.  How does that sound?

Thanks,
Tom

> Thanks,
> 
> 	tglx
> 
