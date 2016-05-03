Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0097.outbound.protection.outlook.com ([207.46.100.97]:39568
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933487AbcECPza (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 May 2016 11:55:30 -0400
Subject: Re: [RFC PATCH v1 00/18] x86: Secure Memory Encryption (AMD)
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
 <94D0CD8314A33A4D9D801C0FE68B402963918FDA@G4W3296.americas.hpqcorp.net>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5728C9E1.3050803@amd.com>
Date: Tue, 3 May 2016 10:55:13 -0500
MIME-Version: 1.0
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B402963918FDA@G4W3296.americas.hpqcorp.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160503155513.LtmFpjko9eB-lGS4ob6Imt4KCIWvtrAiZn7lSz_tBfU@z>

On 04/30/2016 01:13 AM, Elliott, Robert (Persistent Memory) wrote:
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Tom Lendacky
>> Sent: Tuesday, April 26, 2016 5:56 PM
>> Subject: [RFC PATCH v1 00/18] x86: Secure Memory Encryption (AMD)
>>
>> This RFC patch series provides support for AMD's new Secure Memory
>> Encryption (SME) feature.
>>
>> SME can be used to mark individual pages of memory as encrypted through the
>> page tables. A page of memory that is marked encrypted will be automatically
>> decrypted when read from DRAM and will be automatically encrypted when
>> written to DRAM. Details on SME can found in the links below.
>>
> ...
>> ...  Certain data must be accounted for
>> as having been placed in memory before SME was enabled (EFI, initrd, etc.)
>> and accessed accordingly.
>>
> ...
>>       x86/efi: Access EFI related tables in the clear
>>       x86: Access device tree in the clear
>>       x86: Do not specify encrypted memory for VGA mapping
> 
> If the SME encryption key "is created randomly each time a system is booted,"
> data on NVDIMMs won't decrypt properly on the next boot.  You need to exclude
> persistent memory regions (reported in the UEFI memory map as 
> EfiReservedMemoryType with the NV attribute, or as EfiPersistentMemory).

The current plan is for the AMD Secure Processor to securely save the
SME encryption key when NVDIMMs are installed on a system. The saved SME
key will be restored if an NVDIMM restore event needs to be performed.
If there isn't an NVDIMM restore event, then the randomly generated key
will be used.

Thanks,
Tom

> 
> Perhaps the SEV feature will allow key export/import that could work for
> NVDIMMs.
> 
> ---
> Robert Elliott, HPE Persistent Memory
> 
> 
