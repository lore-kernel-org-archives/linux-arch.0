Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0078.outbound.protection.outlook.com ([65.55.169.78]:32019
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754216AbcFPOiq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Jun 2016 10:38:46 -0400
Subject: Re: [RFC PATCH v1 10/18] x86/efi: Access EFI related tables in the
 clear
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
 <20160426225740.13567.85438.stgit@tlendack-t1.amdoffice.net>
 <20160608111844.GV2658@codeblueprint.co.uk> <5759B67A.4000800@amd.com>
 <20160613135110.GC2658@codeblueprint.co.uk> <57615561.4090502@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5762B9E7.80903@amd.com>
Date: Thu, 16 Jun 2016 09:38:31 -0500
MIME-Version: 1.0
In-Reply-To: <57615561.4090502@amd.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160616143831.hjbHkhbet-CUbXXWqo6grobRhba0-XCtWXehmuKAlZU@z>

On 06/15/2016 08:17 AM, Tom Lendacky wrote:
> On 06/13/2016 08:51 AM, Matt Fleming wrote:
>> On Thu, 09 Jun, at 01:33:30PM, Tom Lendacky wrote:
>>>

[...]

>>
>>> I'll look further into this, but I saw that this area of virtual memory
>>> was mapped un-encrypted and after freeing the boot services the
>>> mappings were somehow reused as un-encrypted for DMA which assumes
>>> (unless using swiotlb) encrypted. This resulted in DMA data being
>>> transferred in as encrypted and then accessed un-encrypted.
>>
>> That the mappings were re-used isn't a surprise.
>>
>> efi_free_boot_services() lifts the reservation that was put in place
>> during efi_reserve_boot_services() and releases the pages to the
>> kernel's memory allocators.
>>
>> What is surprising is that they were marked unencrypted at all.
>> There's nothing special about these pages as far as the __va() region
>> is concerned.
> 
> Right, let me keep looking into this to see if I can pin down what
> was (or is) happening.

Ok, I think this was happening before the commit to build our own
EFI page table structures:

commit 67a9108ed ("x86/efi: Build our own page table structures")

Before this commit the boot services ended up mapped into the kernel
page table entries as un-encrypted during efi_map_regions() and I needed
to change those entries back to encrypted. With your change above,
this appears to no longer be needed.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
