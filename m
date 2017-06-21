Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:53120 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751069AbdFUJng (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jun 2017 05:43:36 -0400
Date: Wed, 21 Jun 2017 11:43:24 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 23/36] x86, realmode: Decrypt trampoline area if
 memory encryption is active
Message-ID: <20170621094324.n3dukli4gq6g5ftn@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185412.18967.91559.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616185412.18967.91559.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170621094324.cNvpD_groFzqRL5rjTbaSgb-TLNYcCkDDYJlTTqMGao@z>

On Fri, Jun 16, 2017 at 01:54:12PM -0500, Tom Lendacky wrote:
> When Secure Memory Encryption is enabled, the trampoline area must not
> be encrypted. A CPU running in real mode will not be able to decrypt
> memory that has been encrypted because it will not be able to use addresses
> with the memory encryption mask.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/realmode/init.c |    8 ++++++++
>  1 file changed, 8 insertions(+)

Subject: x86/realmode: ...

other than that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
