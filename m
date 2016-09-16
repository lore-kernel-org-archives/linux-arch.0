Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45575 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755380AbcIPHMC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Sep 2016 03:12:02 -0400
Date: Fri, 16 Sep 2016 09:11:47 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 19/20] x86: Access the setup data through debugfs
 un-encrypted
Message-ID: <20160916071147.GB23229@nazgul.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223859.29880.60652.stgit@tlendack-t1.amdoffice.net>
 <20160912165944.rpqbwxz2biathnt3@pd.tnic>
 <4a357b9b-7d53-5bd6-81db-9d8cc63a6c72@amd.com>
 <20160914145101.GB9295@nazgul.tnic>
 <b734c2da-fee4-efae-fda2-bbcd74abbb33@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b734c2da-fee4-efae-fda2-bbcd74abbb33@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160916071147.ZHqQL01DW1m55mX5Jn2gZZPO87cVSJD2wgxLFO_aCPs@z>

On Thu, Sep 15, 2016 at 12:08:04PM -0500, Tom Lendacky wrote:
> The problem is that this physical address does not contain the
> encryption bit, and even if it did, it wouldn't matter.  The __va()
> define creates a virtual address that will be mapped as encrypted given
> the current approach (which is how I found this).  It's only ioremap()
> that would create a mapping without the encryption attribute and since
> this is unencrypted data it needs to be access accordingly.

I see. So since this is not obvious, please add this explanation to maybe

Documentation/x86/amd-memory-encryption.txt

and point in there to an example or so so.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
