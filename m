Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:41250 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbdBYQYL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Feb 2017 11:24:11 -0500
Date: Sat, 25 Feb 2017 16:29:31 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 05/28] x86: Add Secure Memory Encryption (SME)
 support
Message-ID: <20170225152931.p4lws753myepkkb3@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154307.19244.72895.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216154307.19244.72895.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170225152931.U8yYOlTh46ihFA2OmVqzuP2lrNt2OPnlWsa0A7etiQ8@z>

On Thu, Feb 16, 2017 at 09:43:07AM -0600, Tom Lendacky wrote:
> Add support for Secure Memory Encryption (SME). This initial support
> provides a Kconfig entry to build the SME support into the kernel and
> defines the memory encryption mask that will be used in subsequent
> patches to mark pages as encrypted.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

...

> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -0,0 +1,42 @@
> +/*
> + * AMD Memory Encryption Support
> + *
> + * Copyright (C) 2016 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __X86_MEM_ENCRYPT_H__
> +#define __X86_MEM_ENCRYPT_H__
> +
> +#ifndef __ASSEMBLY__
> +
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +
> +extern unsigned long sme_me_mask;
> +
> +static inline bool sme_active(void)
> +{
> +	return (sme_me_mask) ? true : false;

	return !!sme_me_mask;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
