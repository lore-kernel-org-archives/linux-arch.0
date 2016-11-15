Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0056.outbound.protection.outlook.com ([104.47.38.56]:45120
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751749AbcKOWBz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Nov 2016 17:01:55 -0500
Subject: Re: [RFC PATCH v3 04/20] x86: Handle reduction in physical address
 size with SME
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003513.3280.12104.stgit@tlendack-t1.amdoffice.net>
 <20161115121035.GD24857@8bytes.org> <20161115121456.f4slpk4i2jl3e2ke@pd.tnic>
 <39da89c3-b89f-1d93-6af3-ea93cb750c45@amd.com>
 <20161115213312.lrtejyv4x7nzvzsp@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <25496e6a-ddf0-231a-f83d-cdc2f61e6d96@amd.com>
Date: Tue, 15 Nov 2016 16:01:45 -0600
MIME-Version: 1.0
In-Reply-To: <20161115213312.lrtejyv4x7nzvzsp@pd.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161115220145.izrMGga2ik4PuweU0WWV9HzLJry_iaofTtZjZgebZrQ@z>

On 11/15/2016 3:33 PM, Borislav Petkov wrote:
> On Tue, Nov 15, 2016 at 03:22:45PM -0600, Tom Lendacky wrote:
>> Hmmm... I still need the ebx value from the CPUID instruction to
>> calculate the proper reduction in physical bits, so I'll still need
>> to make the CPUID call.
> 
>         if (c->extended_cpuid_level >= 0x8000001f) {
>                 cpuid(0x8000001f, &eax, &ebx, &ecx, &edx);
> 
> 		...
> 
> just like the rest of get_cpu_cap() :)

Right, which is what the code does now.  I was looking at switching
over to the cpu_has() function and eliminate the cpuid call, but I
still need the cpuid call for the ebx value.

Thanks,
Tom

> 
