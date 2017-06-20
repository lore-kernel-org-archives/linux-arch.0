Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0073.outbound.protection.outlook.com ([104.47.34.73]:14656
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750927AbdFTQXL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jun 2017 12:23:11 -0400
Subject: Re: [PATCH v7 11/36] x86/mm: Add SME support for read_cr3_pa()
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185154.18967.71073.stgit@tlendack-t1.amdoffice.net>
 <CALCETrVkyj=wfcgNMVG_BU+xGb3yBNhxrDdSTxJLx7UYraVcUA@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9a1c0df8-ca12-eebc-5565-ced847989169@amd.com>
Date: Tue, 20 Jun 2017 11:23:03 -0500
MIME-Version: 1.0
In-Reply-To: <CALCETrVkyj=wfcgNMVG_BU+xGb3yBNhxrDdSTxJLx7UYraVcUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, X86 ML <x86@kernel.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, xen-devel <xen-devel@lists.xen.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170620162303.qX9oKuzvBGlJ0BJvYpZ49WJsM3oTGHOPkLBO40wUmQ4@z>

On 6/20/2017 11:17 AM, Andy Lutomirski wrote:
> On Fri, Jun 16, 2017 at 11:51 AM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>> The cr3 register entry can contain the SME encryption mask that indicates
>> the PGD is encrypted.  The encryption mask should not be used when
>> creating a virtual address from the cr3 register, so remove the SME
>> encryption mask in the read_cr3_pa() function.
>>
>> During early boot SME will need to use a native version of read_cr3_pa(),
>> so create native_read_cr3_pa().
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   arch/x86/include/asm/processor-flags.h |    3 ++-
>>   arch/x86/include/asm/processor.h       |    5 +++++
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
>> index 79aa2f9..cb6999c 100644
>> --- a/arch/x86/include/asm/processor-flags.h
>> +++ b/arch/x86/include/asm/processor-flags.h
>> @@ -2,6 +2,7 @@
>>   #define _ASM_X86_PROCESSOR_FLAGS_H
>>
>>   #include <uapi/asm/processor-flags.h>
>> +#include <linux/mem_encrypt.h>
>>
>>   #ifdef CONFIG_VM86
>>   #define X86_VM_MASK    X86_EFLAGS_VM
>> @@ -33,7 +34,7 @@
>>    */
>>   #ifdef CONFIG_X86_64
>>   /* Mask off the address space ID bits. */
>> -#define CR3_ADDR_MASK 0x7FFFFFFFFFFFF000ull
>> +#define CR3_ADDR_MASK __sme_clr(0x7FFFFFFFFFFFF000ull)
> 
> Can you update the comment one line above, too?

Yup, will do.

Thanks,
Tom

> 
