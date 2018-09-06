Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:54228 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbeIFI02 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Sep 2018 04:26:28 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE
 infrastructure
References: <cover.1535459012.git.puwen@hygon.cn>
 <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
 <20180905092234.GC2237@zn.tnic>
 <01604799-b993-e530-817c-ad097d343fc4@hygon.cn>
 <20180905131427.GI2237@zn.tnic>
Message-ID: <a9b7aa87-c99a-42ee-48df-69bec64bb468@hygon.cn>
Date: Thu, 6 Sep 2018 11:52:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180905131427.GI2237@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180906035242.nICdBE_SzMBuyesqrpxRJWbhZGx3VxXIeiZ8OiN5CxI@z>

On 2018/9/5 21:15, Borislav Petkov wrote:
> On Wed, Sep 05, 2018 at 08:59:24PM +0800, Pu Wen wrote:
>> If CONFIG_X86_MCE_AMD=n, mce_hygon_feature_init will call the other
>> one mce_amd_feature_init which is a null function and located in the
>> else branch of "#ifdef CONFIG_X86_MCE_AMD". The compilation is OK and
>> the kernel will run without MCE support.
> 
> So my question was rather ironic but I guess irony can't travel through
> mail. So let me paraphrase: is that a use case you wanna support?
> Because I'd advise very strongly against !MCE kernels.

In most of the normal use cases MCE is necessary. Rarely in some cases
such as for test purpose MCE may be unselected.

-- 
Regards,
Pu Wen
