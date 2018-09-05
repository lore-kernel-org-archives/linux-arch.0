Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:51154 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725900AbeIERaA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Sep 2018 13:30:00 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
Message-ID: <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
Date: Wed, 5 Sep 2018 20:59:24 +0800
MIME-Version: 1.0
In-Reply-To: <20180905092234.GC2237@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180905125924.8lbuZTRa7OCE74Nu2cST0QHARIH7pdMVYPvwAY6XnoE@z>

On 2018/9/5 17:22, Borislav Petkov wrote:
>> @@ -214,6 +214,11 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
>>   #endif
>>   
>> +static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)
>> +{
>> +	return mce_amd_feature_init(c);
>> +}
>> +
> 
> What happens if CONFIG_X86_MCE_AMD=n ?

If CONFIG_X86_MCE_AMD=n, mce_hygon_feature_init will call the other
one mce_amd_feature_init which is a null function and located in the
else branch of "#ifdef CONFIG_X86_MCE_AMD". The compilation is OK and
the kernel will run without MCE support.

> In general, since you're using AMD code, you need to make CPU_SUP_HYGON
> depend on a bunch of AMD config items like CONFIG_X86_MCE_AMD,
> CONFIG_CPU_SUP_AMD, CONFIG_AMD_NB,... Audit your code and see what other
> config items need to be selected.

All right, will check all the config items which are necessary for
CONFIG_CPU_SUP_HYGON.

-- 
Regards,
Pu Wen
