Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:48816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdCALiF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Mar 2017 06:38:05 -0500
Date: Wed, 1 Mar 2017 12:17:58 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v4 21/28] x86: Check for memory encryption on the APs
Message-ID: <20170301111758.ye2nnssvflylrwkk@pd.tnic>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154647.19244.18733.stgit@tlendack-t1.amdoffice.net>
 <20170227181701.2lynk4rm77yk4msf@pd.tnic>
 <5f461d57-9232-1cb3-d4d9-9b8a39d00b12@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f461d57-9232-1cb3-d4d9-9b8a39d00b12@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170301111758.LUZBV3kFeYO98tiAUjESe7Iyulsr9MHIP08xx1A2k8g@z>

On Tue, Feb 28, 2017 at 05:28:48PM -0600, Tom Lendacky wrote:
> That's a good idea, I'll expand on that.  I probably won't be that
> direct in my comment though :)

You either haven't dealt with firmware long enough or you're much better
person than me. :-)))

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
