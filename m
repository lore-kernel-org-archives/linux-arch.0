Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:50036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933143AbcINOvF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Sep 2016 10:51:05 -0400
Date: Wed, 14 Sep 2016 16:51:01 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 19/20] x86: Access the setup data through debugfs
 un-encrypted
Message-ID: <20160914145101.GB9295@nazgul.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223859.29880.60652.stgit@tlendack-t1.amdoffice.net>
 <20160912165944.rpqbwxz2biathnt3@pd.tnic>
 <4a357b9b-7d53-5bd6-81db-9d8cc63a6c72@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a357b9b-7d53-5bd6-81db-9d8cc63a6c72@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160914145101.p6AT9SfJBdlhLZto6rEqZkey9dtVI-gmLw1RRAsfXLg@z>

On Wed, Sep 14, 2016 at 09:29:41AM -0500, Tom Lendacky wrote:
> This is still required because just using the __va() would still cause
> the mapping created to have the encryption bit set. The ioremap call
> will result in the mapping not having the encryption bit set.

I meant this: https://lkml.kernel.org/r/20160902181447.GA25328@nazgul.tnic

Wouldn't simply clearing the SME mask work?

#define __va(x)			((void *)(((unsigned long)(x)+PAGE_OFFSET) & ~sme_me_mask))

Or are you saying, one needs the whole noodling through ioremap_cache()
because the data is already encrypted and accessing it with sme_me_mask
cleared would simply give you the encrypted garbage?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
