Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:32798 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbdFNR11 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 13:27:27 -0400
Date: Wed, 14 Jun 2017 19:27:18 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 20/34] x86, mpparse: Use memremap to map the mpf and
 mpc data
Message-ID: <20170614172718.3opzawxsgobiy2li@pd.tnic>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191643.28645.91679.stgit@tlendack-t1.amdoffice.net>
 <20170614160754.c4ywbf5ktqwgc4ij@pd.tnic>
 <86f31710-76d0-5fee-f4a7-8cdb4b9b9a8e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86f31710-76d0-5fee-f4a7-8cdb4b9b9a8e@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170614172718.6DFcItq3ss3BysB1tjKk7n56fvxJGO2_WS01rLb37qo@z>

On Wed, Jun 14, 2017 at 12:06:54PM -0500, Tom Lendacky wrote:
> This isn't new...  there are a number of messages issued in this file
> with that prefix, so I was just following convention.

The "convention" that some of the messages are prefixed and some aren't?

:-)

> Changing the prefix could be a follow-on patch.

Ok. As some of those print statements have prefixes and some don't,
let's unify them.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
