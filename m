Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:59326 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752042AbdFNQjN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jun 2017 12:39:13 -0400
Date: Wed, 14 Jun 2017 18:39:04 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v6 23/34] x86, realmode: Decrypt trampoline area if
 memory encryption is active
Message-ID: <20170614163903.fvlvscewnuk2u75x@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170614163904.UcovIiKQdjy1WBRzr7WqzFpf4Y7O-4fPAh3PVdYobDg@z>

On Wed, Jun 14, 2017 at 06:24:16PM +0200, Borislav Petkov wrote:
> On Wed, Jun 07, 2017 at 02:17:09PM -0500, Tom Lendacky wrote:
> > When Secure Memory Encryption is enabled, the trampoline area must not
> > be encrypted. A CPU running in real mode will not be able to decrypt
> > memory that has been encrypted because it will not be able to use addresses
> > with the memory encryption mask.
> > 
> > A recent change that added a new system_state value exposed a warning
> > issued by early_ioreamp() when the system_state was not SYSTEM_BOOTING.
> > At the stage where the trampoline area is decrypted, the system_state is
> > now SYSTEM_SCHEDULING. The check was changed to issue a warning if the
> > system_state is greater than or equal to SYSTEM_RUNNING.
> 
> This piece along with the hunk touching system_state absolutely needs to
> be a separate patch as it is unrelated.

Btw, pls send this now and separate from the patchset as it is a bugfix
that should go into sched/core.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
