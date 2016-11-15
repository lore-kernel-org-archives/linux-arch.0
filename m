Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:54432
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751633AbcKOOdN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Nov 2016 09:33:13 -0500
Subject: Re: [RFC PATCH v3 04/20] x86: Handle reduction in physical address
 size with SME
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003513.3280.12104.stgit@tlendack-t1.amdoffice.net>
 <20161115121035.GD24857@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f36306aa-cc28-ae2e-1a7e-a6b69c474daf@amd.com>
Date: Tue, 15 Nov 2016 08:32:50 -0600
MIME-Version: 1.0
In-Reply-To: <20161115121035.GD24857@8bytes.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161115143250.blF9BMy7O9ac52PFkrzbNzZtcfI61QALSPxWrdJfyOs@z>

On 11/15/2016 6:10 AM, Joerg Roedel wrote:
> On Wed, Nov 09, 2016 at 06:35:13PM -0600, Tom Lendacky wrote:
>> +/*
>> + * AMD Secure Memory Encryption (SME) can reduce the size of the physical
>> + * address space if it is enabled, even if memory encryption is not active.
>> + * Adjust x86_phys_bits if SME is enabled.
>> + */
>> +static void phys_bits_adjust(struct cpuinfo_x86 *c)
>> +{
> 
> Better call this function amd_sme_phys_bits_adjust(). This name makes it
> clear at the call-site why it is there and what it does.

Will do.

> 
>> +	u32 eax, ebx, ecx, edx;
>> +	u64 msr;
>> +
>> +	if (c->x86_vendor != X86_VENDOR_AMD)
>> +		return;
>> +
>> +	if (c->extended_cpuid_level < 0x8000001f)
>> +		return;
>> +
>> +	/* Check for SME feature */
>> +	cpuid(0x8000001f, &eax, &ebx, &ecx, &edx);
>> +	if (!(eax & 0x01))
>> +		return;
> 
> Maybe add a comment here why you can't use cpu_has (yet).
> 

Ok, will do.

Thanks,
Tom

