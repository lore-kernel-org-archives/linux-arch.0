Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:50311 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbeIEPKD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 11:10:03 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 09/16] x86/bugs: add lfence mitigation to spectre v2
 and no meltdown for Hygon
References: <cover.1535459012.git.puwen@hygon.cn>
 <bf6e0e5403ae96715606366b3b5f817cbdab0dc3.1535459013.git.puwen@hygon.cn>
 <20180905091309.GB2237@zn.tnic>
Message-ID: <ba3ff0cd-1717-f9a4-5583-d71444a87223@hygon.cn>
Date: Wed, 5 Sep 2018 18:40:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180905091309.GB2237@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180905104009.jAf_YAELIoEFm_KQ2NpZbRSP1ODozf0IgEgbk6XvgKI@z>

On 2018/9/5 17:13, Borislav Petkov wrote:
>>   static const char *spectre_v2_strings[] = {
>>   	[SPECTRE_V2_NONE]			= "Vulnerable",
>>   	[SPECTRE_V2_RETPOLINE_MINIMAL]		= "Vulnerable: Minimal generic ASM retpoline",
>> -	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
>> +	[SPECTRE_V2_RETPOLINE_MINIMAL_LFENCE]	= "Vulnerable: Minimal LFENCE ASM retpoline",
>>   	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
>> -	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
>> +	[SPECTRE_V2_RETPOLINE_LFENCE]		= "Mitigation: Full LFENCE retpoline",
>>   	[SPECTRE_V2_IBRS_ENHANCED]		= "Mitigation: Enhanced IBRS",
>>   };
> 
> This is user-visible and with all the back'n'forth and backporting
> and the whole security fiasco, I don't want to have another source of
> confusion. You'll have to live with it saying "AMD" in dmesg
....
>> @@ -272,7 +272,7 @@ static const struct {
>>   	{ "off",               SPECTRE_V2_CMD_NONE,              false },
>>   	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
>>   	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
>> -	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
>> +	{ "retpoline,lfence",     SPECTRE_V2_CMD_RETPOLINE_LFENCE,     false },
>>   	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
>>   	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
>>   };
> 
> This even more so. Those are command line strings which we're still
> communicating to people, even. So no, it needs to remain "retpoline,amd"
> on Hygon.
> 
> And then to not confuse people staring at the code either, we can drop
> this change too:
> 
> -     SPECTRE_V2_CMD_RETPOLINE_AMD,
> +     SPECTRE_V2_CMD_RETPOLINE_LFENCE,
> 
> Which leaves this patch only with the addition of the vendor tests. The
> other stuff you can drop.

That's reasonable. To avoid the confusion, will only leave the vendor
testing for Hygon and drop the other changes, which also minimize the
code modification.

-- 
Regards,
Pu Wen
