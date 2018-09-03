From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v5 02/16] x86/cache: get cache size/leaves and setup cache
 cpumap for Dhyana
Date: Mon, 3 Sep 2018 20:59:04 +0800
Message-ID: <3dd6e6f6-91d0-696f-2e09-472c39f4af71@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ff6d0392ccdd50ca747e762ae91d9c1c210b1d82.1535459013.git.puwen@hygon.cn>
 <20180903095711.GC10249@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180903095711.GC10249@zn.tnic>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
