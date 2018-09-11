From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 09/16] x86/bugs: Add mitigation to spectre and no
 meltdown for Hygon Dhyana
Date: Tue, 11 Sep 2018 21:17:28 +0800
Message-ID: <58bffcfe-c941-5831-dd39-d1f06ef359e8@hygon.cn>
References: <cover.1536550549.git.puwen@hygon.cn>
 <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
 <20180911103828.GF12094@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911103828.GF12094@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018/9/11 18:38, Borislav Petkov wrote:
>>   	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
>> +	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
>>   	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
>> -		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
>> +		pr_err("retpoline,amd selected but CPU is not AMD or Hygon. Switching to AUTO select\n");
> 
> Didn't we say, no user-visible changes pls?

Sorry for the incomplete modification. Will revert the pr_err string.

-- 
Regards,
Pu Wen
