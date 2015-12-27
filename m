Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t4625.austin.hp.com ([15.73.212.76]:58028 "EHLO
	g2t4625.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbbL0Ab2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2015 19:31:28 -0500
Subject: Re: [PATCH v2 14/16] x86,nvdimm,kexec: Use walk_iomem_res_desc() for
 iomem search
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226103804.GB21988@pd.tnic>
From: Toshi Kani <toshi.kani@hpe.com>
Message-ID: <567F315B.8080005@hpe.com>
Date: Sat, 26 Dec 2015 17:31:23 -0700
MIME-Version: 1.0
In-Reply-To: <20151226103804.GB21988@pd.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, linux-nvdimm@lists.01.org
Message-ID: <20151227003123.G7SNu4FvRO16r4xbKSFyWJ9qNzXZHNA7R7jMYwd4ydU@z>

+ cc: kexec list

On 12/26/2015 3:38 AM, Borislav Petkov wrote:
> On Fri, Dec 25, 2015 at 03:09:23PM -0700, Toshi Kani wrote:
>> Change to call walk_iomem_res_desc() for searching resource entries
>> with the following names:
>>   "ACPI Tables"
>>   "ACPI Non-volatile Storage"
>>   "Persistent Memory (legacy)"
>>   "Crash kernel"
>>
>> Note, the caller of walk_iomem_res() with "GART" is left unchanged
>> because this entry may be initialized by out-of-tree drivers, which
>> do not have 'desc' set to IORES_DESC_GART.
>
> There's this out-of-tree bogus argument again. :\
>
> Why do we care about out-of-tree drivers?
>
> You can just as well fix the "GART" case too and kill walk_iomem_res()
> altogether...

Right, but I do not see any "GART" case in the upstream code, so I 
cannot change it...

Thanks,
-Toshi
