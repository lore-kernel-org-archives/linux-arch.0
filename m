Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:37494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932436AbdESU6v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 May 2017 16:58:51 -0400
Date: Fri, 19 May 2017 22:58:36 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 28/32] x86/mm, kexec: Allow kexec to be used with SME
Message-ID: <20170519205836.3wvl3nztqyyouje3@pd.tnic>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212121.10190.94885.stgit@tlendack-t1.amdoffice.net>
 <20170517191755.h2xluopk2p6suw32@pd.tnic>
 <1b74e0e6-3dda-f638-461b-f73af9904360@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b74e0e6-3dda-f638-461b-f73af9904360@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170519205836.jEq3lwxrcBK4c3AXV0XNkFBsyQDkCNxTGHAGn0fzqVc@z>

On Fri, May 19, 2017 at 03:45:28PM -0500, Tom Lendacky wrote:
> Actually there is.  The above will result in data in the cache because
> halt() turns into a function call if CONFIG_PARAVIRT is defined (refer
> to the comment above where do_wbinvd_halt is set to true). I could make
> this a native_wbinvd() and native_halt()

That's why we have the native_* versions - to bypass paravirt crap.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
