From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 08/16] x86/apic: add modern APIC support for Hygon
Date: Wed, 5 Sep 2018 16:08:25 +0800
Message-ID: <cc7c152f-596a-79fe-6082-c4d5ce1b770f@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <969a367a0b2d58f3e68bc6f97b6e8238e2390991.1535459013.git.puwen@hygon.cn>
 <20180904183301.GN32615@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904183301.GN32615@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/5 2:33, Borislav Petkov wrote:
> On Wed, Aug 29, 2018 at 08:44:30PM +0800, Pu Wen wrote:
...
>> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>> +	     boot_cpu_data.x86 >= 0xf) ||
>> +	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>>   		return 1;
> 
> Those compound conditionals are not nice to read. Just add yours
> underneath:
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> 	    boot_cpu_data.x86 >= 0xf)
> 		return 1;
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> 		return 1;
> 
> Do that where applicable and where it makes sense, syntax-wise to have a
> separate vendor == HYGON check in the other patches too.

That's OK, will check other patches and split the compound conditionals
where it's possible.

-- 
Thanks,
Pu Wen
