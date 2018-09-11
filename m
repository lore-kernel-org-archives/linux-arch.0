From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 08/16] x86/apic: Add Hygon Dhyana support to APIC
Date: Tue, 11 Sep 2018 21:03:41 +0800
Message-ID: <b8055a18-2002-13b2-3438-7fbb38149837@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
 <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
 <20180911101454.GE12094@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911101454.GE12094@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/11 18:14, Borislav Petkov wrote:
>> @@ -1211,9 +1216,11 @@ void __init sync_Arb_IDs(void)
>>   {
>>   	/*
>>   	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
>> -	 * needed on AMD.
>> +	 * needed on AMD or Hygon.
>>   	 */
>> -	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +	if (modern_apic() ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> 
> This change is not needed, after the above hunk in modern_apic(), right?

Yes, you are right. Since the Hygon Dhyana CPU always uses modern APIC,
so the function modern_apic will always return true for Hygon Dhyana.
I will remove this change in next version of patch.

> 
> With it removed:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards,
Pu Wen
