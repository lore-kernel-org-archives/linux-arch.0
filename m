Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44922 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753604AbdBRSMe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Feb 2017 13:12:34 -0500
Date: Sat, 18 Feb 2017 19:12:09 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 00/28] x86: Secure Memory Encryption (AMD)
Message-ID: <20170218181209.xk5ut4g65f2fedzi@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170218181209.N0AZ2ii9-wnySPzuuOTY94g4FqMB7wVX5qov0cedAhQ@z>

On Thu, Feb 16, 2017 at 09:41:59AM -0600, Tom Lendacky wrote:
>  create mode 100644 Documentation/x86/amd-memory-encryption.txt
>  create mode 100644 arch/x86/include/asm/mem_encrypt.h
>  create mode 100644 arch/x86/kernel/mem_encrypt_boot.S
>  create mode 100644 arch/x86/kernel/mem_encrypt_init.c
>  create mode 100644 arch/x86/mm/mem_encrypt.c

I don't see anything standing in the way of merging those last two and
having a single:

arch/x86/kernel/mem_encrypt.c

with all functionality in there with ifdeffery around it so
that sme_encrypt_kernel() et all are still visible in the
!CONFIG_AMD_MEM_ENCRYPT case.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
