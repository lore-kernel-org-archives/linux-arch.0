Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g1t6225.austin.hp.com ([15.73.96.126]:42626 "EHLO
	g1t6225.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574AbbL0AjK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Dec 2015 19:39:10 -0500
Subject: Re: [PATCH v2 14/16] x86,nvdimm,kexec: Use walk_iomem_res_desc() for
 iomem search
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226160522.GA28533@dhcp-128-25.nay.redhat.com>
From: Toshi Kani <toshi.kani@hpe.com>
Message-ID: <567F3329.2030808@hpe.com>
Date: Sat, 26 Dec 2015 17:39:05 -0700
MIME-Version: 1.0
In-Reply-To: <20151226160522.GA28533@dhcp-128-25.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Minfei Huang <mhuang@redhat.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, linux-nvdimm@ml01.01.org, kexec@lists.infradead.org
Message-ID: <20151227003905.R9REN54ZsfeKz4hdRY7-hQ857oR4RlKUJPmp_vmdI7Y@z>

On 12/26/2015 9:05 AM, Minfei Huang wrote:
> Ccing kexec maillist.
>
> On 12/25/15 at 03:09pm, Toshi Kani wrote:
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index c245085..e2bd737 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -522,10 +522,10 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>>
>>   	/* Walk the RAM ranges and allocate a suitable range for the buffer */
>>   	if (image->type == KEXEC_TYPE_CRASH)
>> -		ret = walk_iomem_res("Crash kernel",
>> -				     IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>> -				     crashk_res.start, crashk_res.end, kbuf,
>> -				     locate_mem_hole_callback);
>> +		ret = walk_iomem_res_desc(IORES_DESC_CRASH_KERNEL,
>
> Since crashk_res's desc has been assigned to IORES_DESC_CRASH_KERNEL, it
> is better to use crashk_res.desc, instead of using
> IORES_DESC_CRASH_KERNEL directly.

Sounds good. I will change it to use crashk_res.desc.

Thanks,
-Toshi
