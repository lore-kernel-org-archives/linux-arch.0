Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:52302 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdBUPLH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Feb 2017 10:11:07 -0500
Date: Tue, 21 Feb 2017 16:10:39 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 06/28] x86: Add support to enable SME during early
 boot processing
Message-ID: <20170221151039.nheny3gazbnwaidp@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154319.19244.7863.stgit@tlendack-t1.amdoffice.net>
 <20170220125131.cenb2subqjcqf2xr@pd.tnic>
 <a23be4fa-d7ef-4e7a-5b6b-73e120a5ca80@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a23be4fa-d7ef-4e7a-5b6b-73e120a5ca80@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170221151039.Uhyfbxy4t5xtMhiUEi3ZpoMrh8tPe8Gk9Le30ZeDxug@z>

On Tue, Feb 21, 2017 at 08:55:30AM -0600, Tom Lendacky wrote:
> Actually, %rbp will have the encryption bit set in it at the time of the
> check so if SME is active we won't take the jump to .Lskip_fixup.

Ha, I didn't think of that! Do you see now what I mean with being
explicit in the asm boot code? :-)

Please note that in the comment above sme_encrypt_kernel().

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
