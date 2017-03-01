Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:49224 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752599AbdCALoQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Mar 2017 06:44:16 -0500
Date: Wed, 1 Mar 2017 12:17:37 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 19/28] swiotlb: Add warnings for use of bounce
 buffers with SME
Message-ID: <20170301111737.z3bwfpdoj7ndzmyd@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154619.19244.76653.stgit@tlendack-t1.amdoffice.net>
 <20170227175259.whl75utazbzxp7jo@pd.tnic>
 <9b5af67b-0969-5402-cc01-3ea98f41b748@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b5af67b-0969-5402-cc01-3ea98f41b748@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170301111737.V89Ak3znluw8w6b5SO8CkQND2iwvk0gvlWSNE9mqLlM@z>

On Tue, Feb 28, 2017 at 05:19:51PM -0600, Tom Lendacky wrote:
> Device drivers don't supply set_dma_mask() since that is part of the
> dma_map_ops structure. The fm10k_pf.c file function is unrelated to this
> (it's part of an internal driver structure). The dma_map_ops structure
> is setup by the arch or an iommu.

That was certainly a brainfart, sorry.

Joerg explained to me on IRC how the whole dma_map_ops handling is
supposed to be happening.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
