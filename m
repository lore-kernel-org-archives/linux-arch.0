Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:38347 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbcILQ7t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 12:59:49 -0400
Date: Mon, 12 Sep 2016 18:59:44 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 19/20] x86: Access the setup data through debugfs
 un-encrypted
Message-ID: <20160912165944.rpqbwxz2biathnt3@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223859.29880.60652.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160822223859.29880.60652.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160912165944.vIIP48lCm0qHZyC1q9ZgRml_BwSUUdwPk1mod-iZubM@z>

On Mon, Aug 22, 2016 at 05:38:59PM -0500, Tom Lendacky wrote:
> Since the setup data is in memory in the clear, it must be accessed as
> un-encrypted.  Always use ioremap (similar to sysfs setup data support)
> to map the data.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/kdebugfs.c |   30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
> index bdb83e4..a58a82e 100644
> --- a/arch/x86/kernel/kdebugfs.c
> +++ b/arch/x86/kernel/kdebugfs.c
> @@ -48,17 +48,13 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
>  
>  	pa = node->paddr + sizeof(struct setup_data) + pos;
>  	pg = pfn_to_page((pa + count - 1) >> PAGE_SHIFT);
> -	if (PageHighMem(pg)) {

Why is it ok to get rid of the PageHighMem() check?

Btw, we did talk earlier in the thread about making __va() clear the SME
mask and then you won't really need to change stuff here. Or?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
