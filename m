Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55337 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbcIGPzj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Sep 2016 11:55:39 -0400
Date: Wed, 7 Sep 2016 17:55:35 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 07/20] x86: Provide general kernel support for
 memory encryption
Message-ID: <20160907155535.i7wh46uxxa2bj3ik@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223646.29880.28794.stgit@tlendack-t1.amdoffice.net>
 <20160906093113.GA18319@pd.tnic>
 <f4125cae-63af-f8c7-086f-e297ce480a07@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4125cae-63af-f8c7-086f-e297ce480a07@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160907155535.mClMIxGASrcrfGekjHYFH4pD9rJLb40Z0zH1UMabHBg@z>

On Wed, Sep 07, 2016 at 09:30:54AM -0500, Tom Lendacky wrote:
> _PAGE_ENC is #defined as sme_me_mask and sme_me_mask has already been
> set (or not set) at this point - so it will be the mask if SME is
> active or 0 if SME is not active.

Yeah, I remember :-)

> sme_early_init() is merely propagating the mask to other structures.
> Since early_pmd_flags is mainly used in this file (one line in
> head_64.S is the other place) I felt it best to modify it here. But it
> can always be moved if you feel that is best.

Hmm, so would it work then if you stick it in early_pmd_flags'
definition like you do with the other masks? I.e.,

pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE | _PAGE_ENC & ~(_PAGE_GLOBAL | _PAGE_NX);

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
