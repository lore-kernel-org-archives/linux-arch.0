Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:56427 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbeIKSRA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Sep 2018 14:17:00 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 09/16] x86/bugs: Add mitigation to spectre and no
 meltdown for Hygon Dhyana
References: <cover.1536550549.git.puwen@hygon.cn>
 <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
 <20180911103828.GF12094@zn.tnic>
Message-ID: <58bffcfe-c941-5831-dd39-d1f06ef359e8@hygon.cn>
Date: Tue, 11 Sep 2018 21:17:28 +0800
MIME-Version: 1.0
In-Reply-To: <20180911103828.GF12094@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180911131728.R3d15I8Yqf0uRchIquT1Ee7Sq8aqYgutsp4YOS5kA6M@z>

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
