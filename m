Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:50614 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932871AbdEZQZe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 May 2017 12:25:34 -0400
Date: Fri, 26 May 2017 18:25:22 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 29/32] x86/mm: Add support to encrypt the kernel
 in-place
Message-ID: <20170526162522.p7prrqqalx2ivfxl@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212149.10190.70894.stgit@tlendack-t1.amdoffice.net>
 <20170518124626.hqyqqbjpy7hmlpqc@pd.tnic>
 <7e2ae014-525c-76f2-9fce-2124596db2d2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e2ae014-525c-76f2-9fce-2124596db2d2@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170526162522.VaiSadPaRhwsfJ7Grm8VtNj24QBKfOzB3JqMZ_UGW_I@z>

On Thu, May 25, 2017 at 05:24:27PM -0500, Tom Lendacky wrote:
> I guess I could do that, but this will probably only end up clearing a
> single PGD entry anyway since it's highly doubtful the address range
> would cross a 512GB boundary.

Or you can compute how many 512G-covering, i.e., PGD entries there are
and clear just the right amnount. :^)

> I can change the name. As for the use of ENTRY... without the
> ENTRY/ENDPROC combination I was receiving a warning about a return
> instruction outside of a callable function. It looks like I can just
> define the "sme_enc_routine:" label with the ENDPROC and the warning
> goes away and the global is avoided. It doesn't like the local labels
> (.L...) so I'll use the new name.

Is that warning from objtool or where does it come from?

How do I trigger it locally?

> The hardware will try to optimize rep movsb into large chunks assuming
> things are aligned, sizes are large enough, etc. so we don't have to
> explicitly specify and setup for a rep movsq.

I thought the hw does that for movsq too?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
