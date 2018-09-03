Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:40563 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbeICRTc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Sep 2018 13:19:32 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 02/16] x86/cache: get cache size/leaves and setup cache
 cpumap for Dhyana
References: <cover.1535459012.git.puwen@hygon.cn>
 <ff6d0392ccdd50ca747e762ae91d9c1c210b1d82.1535459013.git.puwen@hygon.cn>
 <20180903095711.GC10249@zn.tnic>
Message-ID: <3dd6e6f6-91d0-696f-2e09-472c39f4af71@hygon.cn>
Date: Mon, 3 Sep 2018 20:59:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180903095711.GC10249@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180903125904.1vSjoMRt8YgdBrpiRuS-FUYFY1E00MEf7PV3TM698b8@z>

On 2018/9/3 17:57, Borislav Petkov wrote:
> Patch subject needs to be of the format:
>
> <file path(s)>: Sentence starting with a capital letter and describing
> concisely the patch
>
> Fix all your subjects pls.

OK, will fix them in next version of patches.

>> With this bit kernel can get the cache info. So add support
>
> "With this bit, the kernel..."
>
>> Dhyana also find num_cache_leaves via CPUID leaf 0x8000001d, so
>
> "... also discovers num_cache_leaves ..."
>

Thanks for the correction.

Regards,
Pu Wen

>
> With that:
>
> Reviewed-by: Borislav Petkov <bp@suse.de>
>
