From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH v2 14/16] x86,nvdimm,kexec: Use walk_iomem_res_desc() for
 iomem search
Date: Sat, 26 Dec 2015 17:39:05 -0700
Message-ID: <567F3329.2030808@hpe.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20151226160522.GA28533@dhcp-128-25.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20151226160522.GA28533@dhcp-128-25.nay.redhat.com>
Sender: owner-linux-mm@kvack.org
To: Minfei Huang <mhuang@redhat.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, linux-nvdimm@ml01.01.org, kexec@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
