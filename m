Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0081.outbound.protection.outlook.com ([104.47.40.81]:26752
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758053AbcHaN0Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Aug 2016 09:26:16 -0400
Subject: Re: [RFC PATCH v2 04/20] x86: Secure Memory Encryption (SME) support
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223610.29880.21739.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1608251503340.5714@nanos>
 <e296f12d-7c76-4690-17bd-0f721d739f07@amd.com>
 <CALCETrVoiM3bskfWrg4c8ttHr467Us9xdXuxw=T6Dkr0PFo18g@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <386eadac-b6eb-747e-65e7-1ffa4cfd7210@amd.com>
Date: Wed, 31 Aug 2016 08:26:01 -0500
MIME-Version: 1.0
In-Reply-To: <CALCETrVoiM3bskfWrg4c8ttHr467Us9xdXuxw=T6Dkr0PFo18g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: kasan-dev <kasan-dev@googlegroups.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>
Message-ID: <20160831132601.TUnzvA2TOY1DQnw7qo-7BniojQWxNH11t2IQ1AyJszE@z>

On 08/30/2016 09:57 AM, Andy Lutomirski wrote:
> On Aug 30, 2016 6:34 AM, "Tom Lendacky" <thomas.lendacky@amd.com> wrote:
>>
>> On 08/25/2016 08:04 AM, Thomas Gleixner wrote:
>>> On Mon, 22 Aug 2016, Tom Lendacky wrote:
>>>
>>>> Provide support for Secure Memory Encryption (SME). This initial support
>>>> defines the memory encryption mask as a variable for quick access and an
>>>> accessor for retrieving the number of physical addressing bits lost if
>>>> SME is enabled.
>>>
>>> What is the reason that this needs to live in assembly code?
>>
>> In later patches this code is expanded and deals with a lot of page
>> table manipulation, cpuid/rdmsr instructions, etc. and so I thought it
>> was best to do it this way.
> 
> None of that sounds like it needs to be in asm, though.
> 
> I, at least, have a strong preference for minimizing the amount of asm
> in the low-level arch code.

I can take a look at converting it over to C code.

Thanks,
Tom

> 
> --Andy
> 
