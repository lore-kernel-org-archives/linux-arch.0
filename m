Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:41952 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753553AbdERJED (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 May 2017 05:04:03 -0400
Date: Thu, 18 May 2017 11:03:54 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 18/32] x86, mpparse: Use memremap to map the mpf and
 mpc data
Message-ID: <20170518090354.e43erptxx6t767uz@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211930.10190.62640.stgit@tlendack-t1.amdoffice.net>
 <20170516083658.fq2h4ysmrbgn23cs@pd.tnic>
 <6e155b8f-b691-2ee0-8977-969aaab6199a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e155b8f-b691-2ee0-8977-969aaab6199a@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170518090354.soN-2aYcFJZTZc7XM6G6e5wJcKOO85HaHfYwseCYz_Y@z>

On Wed, May 17, 2017 at 03:26:58PM -0500, Tom Lendacky wrote:
> > Also, simplify that test:
> > 
> > 	if (mpf->feature1)
> > 		...
> 
> Ok, I can do that but I hope no one says anything about it being
> unrelated to the patch. :)

Bah, that's minor.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
