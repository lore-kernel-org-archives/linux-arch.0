Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:44218 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752878AbdFWL56 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jun 2017 07:57:58 -0400
Date: Fri, 23 Jun 2017 13:57:41 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 35/36] x86/boot: Add early cmdline parsing for options
 with arguments
Message-ID: <20170623115741.o4ejclshoy6yjogl@pd.tnic>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185630.18967.80046.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616185630.18967.80046.stgit@tlendack-t1.amdoffice.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170623115741.ugf-8RAEKi7ISXKrZMQ7n3oT5-If_wOVhuS-zBR2Tuk@z>

On Fri, Jun 16, 2017 at 01:56:30PM -0500, Tom Lendacky wrote:
> Add a cmdline_find_option() function to look for cmdline options that
> take arguments. The argument is returned in a supplied buffer and the
> argument length (regardless of whether it fits in the supplied buffer)
> is returned, with -1 indicating not found.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/include/asm/cmdline.h |    2 +
>  arch/x86/lib/cmdline.c         |  105 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
