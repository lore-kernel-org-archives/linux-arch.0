Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:8818
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750795AbcH3NTO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Aug 2016 09:19:14 -0400
Subject: Re: [RFC PATCH v2 04/20] x86: Secure Memory Encryption (SME) support
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223610.29880.21739.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1608251503340.5714@nanos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e296f12d-7c76-4690-17bd-0f721d739f07@amd.com>
Date: Tue, 30 Aug 2016 08:19:00 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608251503340.5714@nanos>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160830131900.EHThoE2FTxsecAWrc2fIgSYNtxFngFaXeAFSMq8o6Ho@z>

On 08/25/2016 08:04 AM, Thomas Gleixner wrote:
> On Mon, 22 Aug 2016, Tom Lendacky wrote:
> 
>> Provide support for Secure Memory Encryption (SME). This initial support
>> defines the memory encryption mask as a variable for quick access and an
>> accessor for retrieving the number of physical addressing bits lost if
>> SME is enabled.
> 
> What is the reason that this needs to live in assembly code?

In later patches this code is expanded and deals with a lot of page
table manipulation, cpuid/rdmsr instructions, etc. and so I thought it
was best to do it this way.

Thanks,
Tom

>  
> Thanks,
> 
> 	tglx
> 
