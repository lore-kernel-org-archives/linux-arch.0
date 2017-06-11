Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:47402 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751794AbdFKTod (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Jun 2017 15:44:33 -0400
Date: Sun, 11 Jun 2017 21:44:11 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 18/34] x86/efi: Update EFI pagetable creation to work
 with SME
Message-ID: <20170611194411.shbwwf34ftumipab@pd.tnic>
References: <20170607191309.28645.15241.stgit@tlendack-t1.amdoffice.net>
 <20170607191627.28645.4398.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170607191627.28645.4398.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170611194411.87W9kNXwVtTfd3Wc34jNPHf9MF1mnt6uWYjegMimG2I@z>

On Wed, Jun 07, 2017 at 02:16:27PM -0500, Tom Lendacky wrote:
> When SME is active, pagetable entries created for EFI need to have the
> encryption mask set as necessary.
> 
> When the new pagetable pages are allocated they are mapped encrypted. So,
> update the efi_pgt value that will be used in cr3 to include the encryption
> mask so that the PGD table can be read successfully. The pagetable mapping
> as well as the kernel are also added to the pagetable mapping as encrypted.
> All other EFI mappings are mapped decrypted (tables, etc.).
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/platform/efi/efi_64.c |   15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

patches 15-18:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
