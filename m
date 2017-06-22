Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33199 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbdFVK5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 06:57:33 -0400
Received: by mail-wr0-f174.google.com with SMTP id r103so18249882wrb.0
        for <linux-arch@vger.kernel.org>; Thu, 22 Jun 2017 03:57:27 -0700 (PDT)
Date: Thu, 22 Jun 2017 11:57:20 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH v7 16/36] efi: Add an EFI table address match function
Message-ID: <20170622105720.GA3129@codeblueprint.co.uk>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185253.18967.55724.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170616185253.18967.55724.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170622105720.d0-dcWsfAQ8lVDMFHZ02DLyGK93rjZqXUDvryNNbtcM@z>

On Fri, 16 Jun, at 01:52:53PM, Tom Lendacky wrote:
> Add a function that will determine if a supplied physical address matches
> the address of an EFI table.
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/firmware/efi/efi.c |   33 +++++++++++++++++++++++++++++++++
>  include/linux/efi.h        |    7 +++++++
>  2 files changed, 40 insertions(+)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
