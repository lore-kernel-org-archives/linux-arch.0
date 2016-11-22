Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:49433 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755365AbcKVS6v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Nov 2016 13:58:51 -0500
Date: Tue, 22 Nov 2016 19:58:18 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v3 20/20] x86: Add support to make use of Secure
 Memory Encryption
Message-ID: <20161122185818.k2znytnjjkh2ygpy@pd.tnic>
References: <20161110003426.3280.2999.stgit@tlendack-t1.amdoffice.net>
 <20161110003838.3280.23327.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161110003838.3280.23327.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20161122185818.uqbQ7b-XlSGjyJLfXa-TxuiMHkb6sut2JGJ5eP-dTvo@z>

On Wed, Nov 09, 2016 at 06:38:38PM -0600, Tom Lendacky wrote:
> This patch adds the support to check if SME has been enabled and if the
> mem_encrypt=on command line option is set. If both of these conditions
> are true, then the encryption mask is set and the kernel is encrypted
> "in place."

Something went wrong here - 19/20 and 20/20 have the same Subject and
commit message.

Care to resend only 19 and 20 with the above fixed?

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
