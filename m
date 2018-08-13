Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:50199 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbeHMTFd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Aug 2018 15:05:33 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 15/17] driver/cpufreq: enable Hygon support to cpufreq
 driver
References: <cover.1533989492.git.puwen@hygon.cn>
 <36b1edf4bd9e203f8e14fa5b90a5a197fdf13898.1533989493.git.puwen@hygon.cn>
 <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com>
Message-ID: <04744a9f-5865-bbc8-7735-e92c6cf6472d@hygon.cn>
Date: Tue, 14 Aug 2018 00:22:16 +0800
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0izyq2SoUspLPDRM9U7W+-bZPCcQ4C5Zu1hVFDoUj=w1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, thomas.lendacky@amd.com, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Message-ID: <20180813162216.aSzgLUkjJvD6Nt__evBTT-ew2wz8-k1MkrCVK9Ld8tE@z>

On 2018/8/12 17:55, Rafael J. Wysocki wrote:
> On Sat, Aug 11, 2018 at 3:36 PM Pu Wen <puwen@hygon.cn> wrote:
>>
>> Enable ACPI cpufreq driver support for Hygon by adding family ID check
>> along with AMD.
>>
>> As Hygon platforms have SMBus device(PCI device ID 0x790b), enable Hygon
>> support to function amd_freq_sensitivity_init().
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
> 
> Is there any technical difference between HYGON and AMD?

For ACPI cpufreq patch, you are right. But for the whole point of view,
there has some technical difference between Hygon Dhyana and AMD Family
17h.
For cpufreq if not added X86_VENDOR_HYGON codes, this driver will not
work functionally on Hygon platforms.

> 
> You seem to be mechanically adding X86_VENDOR_HYGON wherever
> X86_VENDOR_AMD is used.

X86_VENDOR_HYGON is not mechanically added wherever X86_VENDOR_AMD is
used, we have reviewed and tested the features wherever X86_VENDOR_HYGON
is needed.

As Hygon Dhyana can share code path with AMD family 17h, to minimize the
code duplication, we choose to reuse the AMD's codes here.

Thanks,
Pu Wen

> 
>> ---
>>   drivers/cpufreq/acpi-cpufreq.c         | 5 +++++
>>   drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index b61f4ec..d62fd37 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -61,6 +61,7 @@ enum {
>>
>>   #define INTEL_MSR_RANGE                (0xffff)
>>   #define AMD_MSR_RANGE          (0x7)
>> +#define HYGON_MSR_RANGE                (0x7)
>>
>>   #define MSR_K7_HWCR_CPB_DIS    (1ULL << 25)
>>
>> @@ -95,6 +96,7 @@ static bool boost_state(unsigned int cpu)
>>                  rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
>>                  msr = lo | ((u64)hi << 32);
>>                  return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
>> +       case X86_VENDOR_HYGON:
>>          case X86_VENDOR_AMD:
>>                  rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
>>                  msr = lo | ((u64)hi << 32);
