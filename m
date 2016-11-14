Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:55559
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752253AbcKNQjw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Nov 2016 11:39:52 -0500
Subject: Re: [RFC PATCH v3 10/20] Add support to access boot related data in
 the clear
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003631.3280.73292.stgit@tlendack-t1.amdoffice.net>
 <1478880929.20881.148.camel@hpe.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d25de4d7-ae6f-b701-8ae1-0a39fa02a9b0@amd.com>
Date: Mon, 14 Nov 2016 10:24:14 -0600
MIME-Version: 1.0
In-Reply-To: <1478880929.20881.148.camel@hpe.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kani, Toshimitsu" <toshi.kani@hpe.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "x86@kernel.org" <x86@kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>, "corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "joro@8bytes.org" <joro@8bytes.org>, "dvyukov@google.com" <dvyukov@google.com>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>, "riel@redhat.com" <riel@redhat.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "glider@google.com" <glider@google.com>, "rkrcmar@redhat.com" <rkrcmar@redhat.com>, "arnd@arndb.de" <arnd@arndb.de>
Message-ID: <20161114162414.msCBg0ja5kHbpruluKEON5kbTLEqsnrDFaf_L5q2-nc@z>

On 11/11/2016 10:17 AM, Kani, Toshimitsu wrote:
> On Wed, 2016-11-09 at 18:36 -0600, Tom Lendacky wrote:
>> Boot data (such as EFI related data) is not encrypted when the system
>> is booted and needs to be accessed unencrypted.  Add support to apply
>> the proper attributes to the EFI page tables and to the
>> early_memremap and memremap APIs to identify the type of data being
>> accessed so that the proper encryption attribute can be applied.
>  :
>> +static bool memremap_apply_encryption(resource_size_t phys_addr,
>> +				      unsigned long size)
>> +{
>> +	/* SME is not active, just return true */
>> +	if (!sme_me_mask)
>> +		return true;
>> +
>> +	/* Check if the address is part of the setup data */
>> +	if (memremap_setup_data(phys_addr, size))
>> +		return false;
>> +
>> +	/* Check if the address is part of EFI boot/runtime data */
>> +	switch (efi_mem_type(phys_addr)) {
>> +	case EFI_BOOT_SERVICES_DATA:
>> +	case EFI_RUNTIME_SERVICES_DATA:
>> +		return false;
>> +	}
>> +
>> +	/* Check if the address is outside kernel usable area */
>> +	switch (e820_get_entry_type(phys_addr, phys_addr + size -
>> 1)) {
>> +	case E820_RESERVED:
>> +	case E820_ACPI:
>> +	case E820_NVS:
>> +	case E820_UNUSABLE:
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
> 
> Are you supporting encryption for E820_PMEM ranges?  If so, this
> encryption will persist across a reboot and does not need to be
> encrypted again, right?  Also, how do you keep a same key across a
> reboot?

The key will change across a reboot... so I need to look into this
more for memory that isn't used as traditional system ram.

Thanks,
Tom

> 
> Thanks,
> -Toshi
> 
