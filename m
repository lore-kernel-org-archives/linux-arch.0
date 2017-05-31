Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:54474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbdEaOMU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 May 2017 10:12:20 -0400
Date: Wed, 31 May 2017 16:12:01 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 32/32] x86/mm: Add support to make use of Secure
 Memory Encryption
Message-ID: <20170531141201.7srucl6lgsye7qyv@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212223.10190.85121.stgit@tlendack-t1.amdoffice.net>
 <20170519112703.voajtn4t7uy6nwa3@pd.tnic>
 <7c522f65-c5c8-9362-e1eb-d0765e3ea6c9@amd.com>
 <20170530145459.tyuy6veqxnrqkhgw@pd.tnic>
 <115ca39d-6ae7-f603-a415-ead7c4e8193d@amd.com>
 <20170531084923.mmlpefxfx53f3okp@pd.tnic>
 <706d6ae0-bc4c-5ba7-529c-b0fc5e4ad464@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <706d6ae0-bc4c-5ba7-529c-b0fc5e4ad464@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170531141201.ElRVWulf9of19UnZfg2KFk-qSZKZxrRMU6nxie32LbU@z>

On Wed, May 31, 2017 at 08:37:50AM -0500, Tom Lendacky wrote:
> I like keeping the command line option and the values together. It may
> not look the greatest but I like it more than defining the command line
> option in head_64.S and passing it in as an argument.
> 
> OTOH, I don't think the rip-relative addressing was that bad, I can
> always go back to that...

Yeah, no nice solution here. Having gone full circle, the rip-relative
thing doesn't look all that bad, all of a sudden. I'd let you decide
what to do...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
