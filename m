Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756115AbcKVUlg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Nov 2016 15:41:36 -0500
Date: Tue, 22 Nov 2016 22:41:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v3 13/20] x86: DMA support for memory encryption
Message-ID: <20161122224005-mutt-send-email-mst@kernel.org>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003723.3280.62636.stgit@tlendack-t1.amdoffice.net>
 <20161115171443-mutt-send-email-mst@kernel.org>
 <4d97f998-5835-f4e0-9840-7f7979251275@amd.com>
 <20161122113859.5dtlrfgizwpum6st@pd.tnic>
 <20161122171455-mutt-send-email-mst@kernel.org>
 <20161122154137.z5vp3xcl5cpesuiz@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161122154137.z5vp3xcl5cpesuiz@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161122204130.zIdmp-9oohP9192BeCsk-lySS-PMEbxWKMVroExEiOU@z>

On Tue, Nov 22, 2016 at 04:41:37PM +0100, Borislav Petkov wrote:
> On Tue, Nov 22, 2016 at 05:22:38PM +0200, Michael S. Tsirkin wrote:
> > The issue is it's a (potential) security hole, not a slowdown.
> 
> How? Because the bounce buffers will be unencrypted and someone might
> intercept them?

Or even modify them. Guests generally trust devices since they
assume they are under their control.

> > To disable unsecure things. If someone enables SEV one might have an
> > expectation of security.  Might help push vendors to do the right thing
> > as a side effect.
> 
> Ok, you're looking at the SEV-cloud-multiple-guests aspect. Right, that
> makes sense.
> 
> I guess for SEV we should even flip the logic: disable such devices by
> default and an opt-in option to enable them and issue a big fat warning.
> I'd even want to let the guest users know that they're on a system which
> cannot give them encrypted DMA to some devices...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
