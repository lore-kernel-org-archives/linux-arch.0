From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v3 13/17] x86/xen: enable Hygon support to Xen
Date: Thu, 16 Aug 2018 21:22:01 +0800
Message-ID: <d8e2dfb0-a2ff-5376-c39f-83626f257fda@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
 <2747ad959f07459000f2693a98d237e2b3149ca1.1533989493.git.puwen@hygon.cn>
 <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b32887e0-df6e-fb31-d9cd-6b31961c9c2b@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, jgross@suse.com, JBeulich@suse.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

On 2018/8/11 22:34, Boris Ostrovsky wrote:
> On 08/11/2018 09:29 AM, Pu Wen wrote:
>> To make Xen work correctly on Hygon platforms, reuse AMD's Xen support
>> code path and add vendor check for Hygon along with AMD.
>>
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> ---
>>   arch/x86/xen/pmu.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
>> index 7d00d4a..1053dda 100644
>> --- a/arch/x86/xen/pmu.c
>> +++ b/arch/x86/xen/pmu.c
>> @@ -90,6 +90,12 @@ static void xen_pmu_arch_init(void)
>>   			k7_counters_mirrored = 0;
>>   			break;
>>   		}
>> +	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +		amd_num_counters = F10H_NUM_COUNTERS;
> 
> I haven't looked in details at Zen's PMU but the PMC section in the spec
> starts with
>    "There are six core performance events counters per thread..."

There are six core performance events counters per thread, so there are
six MSRs for these counters(0-5). Also there are four legacy PMC MSRs,
they are alias of the counters(0-3).

In this version of kernel Zen use the lagacy version of PMU MSRs for Xen.
For safety consideration, Dhyana just fullow this stategy. And it works
fine when VPMU enabled in Xen on Hygon platforms by testing with perf.

Thanks,
Pu Wen
