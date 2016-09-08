Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:53619 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965157AbcIHNzz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Sep 2016 09:55:55 -0400
Date: Thu, 8 Sep 2016 15:55:51 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 07/20] x86: Provide general kernel support for
 memory encryption
Message-ID: <20160908135551.3gtbwezbb7xpyud2@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223646.29880.28794.stgit@tlendack-t1.amdoffice.net>
 <20160906093113.GA18319@pd.tnic>
 <f4125cae-63af-f8c7-086f-e297ce480a07@amd.com>
 <20160907155535.i7wh46uxxa2bj3ik@pd.tnic>
 <bc8f22db-b6f9-951f-145c-fed919098cbe@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc8f22db-b6f9-951f-145c-fed919098cbe@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160908135551.6Yd7KCxGYBaYJ_5aCvI_rHSfEjZGh7NoRrI2ssGKPMM@z>

On Thu, Sep 08, 2016 at 08:26:27AM -0500, Tom Lendacky wrote:
> When does this value get initialized?  Since _PAGE_ENC is #defined to
> sme_me_mask, which is not set until the boot process begins, I'm afraid
> we'd end up using the initial value of sme_me_mask, which is zero.  Do
> I have that right?

Hmm, but then that would hold true for all the other defines where you
OR-in _PAGE_ENC, no?

In any case, the preprocessed source looks like this:

pmdval_t early_pmd_flags = (((((((pteval_t)(1)) << 0) | (((pteval_t)(1)) << 1) | (((pteval_t)(1)) << 6) | (((pteval_t)(1)) << 5) | (((pteval_t)(1)) << 8)) | (((pteval_t)(1)) << 63)) | (((pteval_t)(1)) << 7)) | sme_me_mask) & ~((((pteval_t)(1)) << 8) | (((pteval_t)(1)) << 63));

but the problem is later, when building:

arch/x86/kernel/head64.c:39:28: error: initializer element is not constant
 pmdval_t early_pmd_flags = (__PAGE_KERNEL_LARGE | _PAGE_ENC) & ~(_PAGE_GLOBAL | _PAGE_NX);
                            ^
scripts/Makefile.build:153: recipe for target 'arch/x86/kernel/head64.s' failed

so I guess not. :-\

Ok, then at least please put the early_pmd_flags init after
sme_early_init() along with a small comment explaning what happens.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
