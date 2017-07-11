Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com ([104.47.41.66]:17776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755296AbdGKPOr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jul 2017 11:14:47 -0400
Subject: Re: [PATCH v9 04/38] x86/CPU/AMD: Add the Secure Memory Encryption
 CPU feature
References: <20170707133804.29711.1616.stgit@tlendack-t1.amdoffice.net>
 <20170707133850.29711.29549.stgit@tlendack-t1.amdoffice.net>
 <CAMzpN2j-gXvx2wAp3EvQB70Mr_oz0MSUzG=c-mhu-bnRiQGaFQ@mail.gmail.com>
 <f5657d4a-aa15-9602-bb36-1a3cfe7fbcc1@amd.com>
 <CAMzpN2hqYMVwhDRTGEhcUxqN2+6ToMmy6NBUutYJgPoOJEH4uQ@mail.gmail.com>
 <20170711055659.GA4554@nazgul.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <df089d57-3785-c669-6c3b-6f90f77c3658@amd.com>
Date: Tue, 11 Jul 2017 10:14:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170711055659.GA4554@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, Linux-MM <linux-mm@kvack.org>, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170711151434.H4vrg4cn7q9uewcblpy49ApZk5RSVOEOIHyBpOJZQmQ@z>

On 7/11/2017 12:56 AM, Borislav Petkov wrote:
> On Tue, Jul 11, 2017 at 01:07:46AM -0400, Brian Gerst wrote:
>>> If I make the scattered feature support conditional on CONFIG_X86_64
>>> (based on comment below) then cpu_has() will always be false unless
>>> CONFIG_X86_64 is enabled. So this won't need to be wrapped by the
>>> #ifdef.
>>
>> If you change it to use cpu_feature_enabled(), gcc will see that it is
>> disabled and eliminate the dead code at compile time.
> 
> Just do this:
> 
>         if (cpu_has(c, X86_FEATURE_SME)) {
> 	       if (IS_ENABLED(CONFIG_X86_32)) {
>                         clear_cpu_cap(c, X86_FEATURE_SME);
> 	       } else {
> 		       u64 msr;
> 
> 		       /* Check if SME is enabled */
> 	              rdmsrl(MSR_K8_SYSCFG, msr);
> 	              if (!(msr & MSR_K8_SYSCFG_MEM_ENCRYPT))
> 	                      clear_cpu_cap(c, X86_FEATURE_SME);
> 	       }
>         }
> 
> so that it is explicit that we disable it on 32-bit and we can save us
> the ifdeffery elsewhere.

I'll use this method for the change and avoid the #ifdefs.

Thanks,
Tom

> 
> Thanks.
> 
