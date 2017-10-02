From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: Regression: x86/mm: Add Secure Memory Encryption (SME) support
Date: Mon, 2 Oct 2017 11:30:57 -0500
Message-ID: <c0528ed8-2d00-dedf-4f90-8aa7eead4b5a@amd.com>
References: <d5c60048-dbb3-0440-d139-ea325621e654@iam.tj>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:63405
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751082AbdJBQbB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Oct 2017 12:31:01 -0400
In-Reply-To: <d5c60048-dbb3-0440-d139-ea325621e654@iam.tj>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tj <linux@iam.tj>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Borislav Petkov <bp@suse.de>

On 9/30/2017 5:36 PM, Tj wrote:
> With 4.14.0rc2 on an Intel CPU with an Nvidia GPU the proprietary nvidia
> driver (v340.102) fails to modpost due to:
> 
> FATAL: modpost: GPL-incompatible module nvidia.ko uses GPL-only symbol
> 'sme_me_mask'
> 
> I think this is due to:
> 
> config ARCH_HAS_MEM_ENCRYPT
>         def_bool y
> 

I think this is more likely because of CONFIG_AMD_MEM_ENCRYPT=y. If
CONFIG_AMD_MEM_ENCRYPT=n then sme_me_mask becomes a #define. I'm
assuming that changing the sme_me_mask in arch/x86/mm/mem_encrypt.c
from EXPORT_SYMBOL_GPL to EXPORT_SYMBOL fixes the issue?

Boris, is it a big deal to make this change if that's the issue?

Thanks,
Tom

> 
> I noticed that a grep of the built kernel for "sme_me_mask" shows the
> symbol imported into more than 300 modules on an Ubuntu mainline build
> of 4.14.0-041400rc2-lowlatency.
> 
> Should the new symbol be referenced so widely and how can it be
> prevented from being included in proprietary modules on systems that
> don't have SME even if the kernel is built with it enabled? >
