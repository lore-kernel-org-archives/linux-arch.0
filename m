From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
Date: Tue, 4 Sep 2018 11:02:41 +0800
Message-ID: <946157a5-fdb2-a45a-63aa-97e9d602e6f0@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
 <20180903190438.GF10249@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903190438.GF10249@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/4 3:04, Borislav Petkov wrote:
> It was "Hygon Dhyana" before now "Hygon" only. Can we agree on the
> naming nomenclature and stick with it.

OK, agree on it.

...

>> -	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
>> -	      (boot_cpu_data.x86 >= 0x0f)))
>> +	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>> +	       boot_cpu_data.x86 >= 0x0f) ||
>> +	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
> 
> Why are you even touching this statement? The function returns early on
> !X86_VENDOR_AMD.

The statement is briefly equal to !(X86_VENDOR_AMD || X86_VENDOR_HYGON).
So the function will not return early on !X86_VENDOR_AMD. :-)

Also the statement can be changed to:
+	if (!(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+	      boot_cpu_data.x86 >= 0x0f) &&
+	    !(boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))
or:
+	if ((boot_cpu_data.x86_vendor != X86_VENDOR_AMD ||
+	     boot_cpu_data.x86 < 0x0f) &&
+	    (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON))

Which statement is better?

Thanks,
Pu Wen
