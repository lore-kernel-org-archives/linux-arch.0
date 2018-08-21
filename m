Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48351 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbeHUIir (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 04:38:47 -0400
Date: Tue, 21 Aug 2018 07:20:00 +0200
From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] x86/mm: Simplify p[g4um]d_page() macros
Message-ID: <20180821052000.GB23615@kroah.com>
References: <20180820203705.16212-1-andi@firstfloor.org>
 <20180820203705.16212-2-andi@firstfloor.org>
 <CA+55aFyo_MFz2Qg3pEbLMf3zhvAQbpZf3mQf98bTRJx28drbeQ@mail.gmail.com>
 <20180820220422.7qrayn7wivmejr24@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820220422.7qrayn7wivmejr24@two.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, stable <stable@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Alexander Potapenko <glider@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andrew Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Dave Young <dyoung@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Larry Woodman <lwoodman@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Rik van Riel <riel@redhat.com>, Toshi Kani <toshi.kani@hpe.com>, kasan-dev <kasan-dev@googlegroups.com>, KVM list <kvm@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20180821052000.6-cOZR0Jx_0Xg5zlyk1Ko6tfsdDNqhIUhRiFDrqpWX4@z>

On Mon, Aug 20, 2018 at 03:04:23PM -0700, Andi Kleen wrote:
> On Mon, Aug 20, 2018 at 02:57:39PM -0700, Linus Torvalds wrote:
> > On Mon, Aug 20, 2018 at 1:37 PM Andi Kleen <andi@firstfloor.org> wrote:
> > >
> > > From: Andi Kleen <ak@linux.intel.com>
> > >
> > > Create a pgd_pfn() macro similar to the p[4um]d_pfn() macros and then
> > > use the p[g4um]d_pfn() macros in the p[g4um]d_page() macros instead of
> > > duplicating the code.
> > 
> > When doing backports, _please_ explicitly specify which commit this is
> > upstream too.
> 
> Ok.
> 
> > 
> > Also, the original upstream patch is credited to Tom Lendacky.
> 
> Okay.
> 
> > 
> > Or is there something I'm not seeing, and this is different from
> > commit fd7e315988b7 ("x86/mm: Simplify p[g4um]d_page() macros")?
> 
> No it's Tom's patch just ported to the older tree with some minor
> changes. I just fat fingered it while doing the commit

Ok, I've fixed this up by hand now, please be more careful next time.

greg k-h
