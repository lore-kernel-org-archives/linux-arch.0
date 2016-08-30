Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:34552 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753438AbcH3O5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2016 10:57:47 -0400
Received: by mail-ua0-f171.google.com with SMTP id k90so37213320uak.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2016 07:57:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e296f12d-7c76-4690-17bd-0f721d739f07@amd.com>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223610.29880.21739.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1608251503340.5714@nanos> <e296f12d-7c76-4690-17bd-0f721d739f07@amd.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 30 Aug 2016 07:57:25 -0700
Message-ID: <CALCETrVoiM3bskfWrg4c8ttHr467Us9xdXuxw=T6Dkr0PFo18g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/20] x86: Secure Memory Encryption (SME) support
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kasan-dev <kasan-dev@googlegroups.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>
Message-ID: <20160830145725.tocdBN8einH3pKuDvzgS0lGy7heHqzHci7BrWXXfngQ@z>

On Aug 30, 2016 6:34 AM, "Tom Lendacky" <thomas.lendacky@amd.com> wrote:
>
> On 08/25/2016 08:04 AM, Thomas Gleixner wrote:
> > On Mon, 22 Aug 2016, Tom Lendacky wrote:
> >
> >> Provide support for Secure Memory Encryption (SME). This initial support
> >> defines the memory encryption mask as a variable for quick access and an
> >> accessor for retrieving the number of physical addressing bits lost if
> >> SME is enabled.
> >
> > What is the reason that this needs to live in assembly code?
>
> In later patches this code is expanded and deals with a lot of page
> table manipulation, cpuid/rdmsr instructions, etc. and so I thought it
> was best to do it this way.

None of that sounds like it needs to be in asm, though.

I, at least, have a strong preference for minimizing the amount of asm
in the low-level arch code.

--Andy
