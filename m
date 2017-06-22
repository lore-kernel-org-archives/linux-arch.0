Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33483 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbdFVKD0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 06:03:26 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so16371266wrb.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2017 03:03:20 -0700 (PDT)
Date: Thu, 22 Jun 2017 11:03:13 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v7 17/36] efi: Update efi_mem_type() to return an error
 rather than 0
Message-ID: <20170622100313.GB3238@codeblueprint.co.uk>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185306.18967.8964.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616185306.18967.8964.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170622100313.3xbzYg4INrf-CV-854Yb5jVXHvtwMgzGyvnCUWEniE0@z>

On Fri, 16 Jun, at 01:53:06PM, Tom Lendacky wrote:
> The efi_mem_type() function currently returns a 0, which maps to
> EFI_RESERVED_TYPE, if the function is unable to find a memmap entry for
> the supplied physical address. Returning EFI_RESERVED_TYPE implies that
> a memmap entry exists, when it doesn't.  Instead of returning 0, change
> the function to return a negative error value when no memmap entry is
> found.
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/ia64/kernel/efi.c      |    4 ++--
>  arch/x86/platform/efi/efi.c |    6 +++---
>  include/linux/efi.h         |    2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
