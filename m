Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33798 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbdBURx7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Feb 2017 12:53:59 -0500
Date: Tue, 21 Feb 2017 18:53:31 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 00/28] x86: Secure Memory Encryption (AMD)
Message-ID: <20170221175331.hpbvw7tepxfkilko@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170218181209.xk5ut4g65f2fedzi@pd.tnic>
 <1487698965.17158.8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487698965.17158.8.camel@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rik van Riel <riel@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170221175331.PDmWDCKFTL5w4PMMJ-kjMRLqYvw4gkm2I9JxtEH6Rzw@z>

On Tue, Feb 21, 2017 at 12:42:45PM -0500, Rik van Riel wrote:
> Do we want that in kernel/ or in arch/x86/mm/ ?

If you'd ask me, I don't have a strong preference. It is a pile of
functionality which is part of the SME feature and as such, it is closer
to the CPU. So arch/x86/cpu/sme.c or so.

But then it is mm-related in a way as it is RAM encryption...

Meh, ask me something easier :-)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
