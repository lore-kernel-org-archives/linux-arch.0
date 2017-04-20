Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0073.outbound.protection.outlook.com ([104.47.33.73]:27554
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941989AbdDTR3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Apr 2017 13:29:34 -0400
Subject: Re: [PATCH v5 05/32] x86/CPU/AMD: Handle SME reduction in physical
 address size
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211711.10190.30861.stgit@tlendack-t1.amdoffice.net>
 <20170420165922.j2inlwbchrs6senw@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <aaa52e93-5875-6033-e72f-8fc3de43ca3a@amd.com>
Date: Thu, 20 Apr 2017 12:29:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170420165922.j2inlwbchrs6senw@pd.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170420172920.8jRrz5pj9LgiEsIFMBDd1rYr8BU9wEkJTA4rxkMZhao@z>

On 4/20/2017 11:59 AM, Borislav Petkov wrote:
> On Tue, Apr 18, 2017 at 04:17:11PM -0500, Tom Lendacky wrote:
>> When System Memory Encryption (SME) is enabled, the physical address
>> space is reduced. Adjust the x86_phys_bits value to reflect this
>> reduction.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/kernel/cpu/amd.c |   14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> ...
>
>> @@ -622,8 +624,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
>>
>>  			/* Check if SME is enabled */
>>  			rdmsrl(MSR_K8_SYSCFG, msr);
>> -			if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
>> +			if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT) {
>> +				unsigned int ebx;
>> +
>> +				ebx = cpuid_ebx(0x8000001f);
>> +				c->x86_phys_bits -= (ebx >> 6) & 0x3f;
>> +			} else {
>>  				clear_cpu_cap(c, X86_FEATURE_SME);
>> +			}
>
> Lemme do some simplifying to save an indent level, get rid of local var
> ebx and kill some { }-brackets for a bit better readability:
>
>         if (c->extended_cpuid_level >= 0x8000001f) {
>                 u64 msr;
>
>                 if (!cpu_has(c, X86_FEATURE_SME))
>                         return;
>
>                 /* Check if SME is enabled */
>                 rdmsrl(MSR_K8_SYSCFG, msr);
>                 if (msr & MSR_K8_SYSCFG_MEM_ENCRYPT)
>                         c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
>                 else
>                         clear_cpu_cap(c, X86_FEATURE_SME);
>         }
>

Hmmm... and actually if cpu_has(X86_FEATURE_SME) is true then it's a
given that extended_cpuid_level >= 0x8000001f.  So this can be
simplified to just:

	if (cpu_has(c, X86_FEATURE_SME)) {
		... the rest of your suggestion (minus cpu_has()) ...
	}

Thanks,
Tom
