Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36247 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936560AbcIGPYC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Sep 2016 11:24:02 -0400
Date: Wed, 7 Sep 2016 17:23:58 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 01/20] x86: Documentation for AMD Secure Memory
 Encryption (SME)
Message-ID: <20160907152358.6msxtd4bjjacpz5f@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223539.29880.96739.stgit@tlendack-t1.amdoffice.net>
 <20160902085045.GG17338@nazgul.tnic>
 <3fbb0763-5f9f-6ff7-2266-7478fb12642e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fbb0763-5f9f-6ff7-2266-7478fb12642e@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160907152358.r1PBK86yTwfjqLyQ9vj_1ROKC3vwONYfyU_mPT3SGUo@z>

On Wed, Sep 07, 2016 at 09:02:38AM -0500, Tom Lendacky wrote:
> Ugh..  I thought I caught all of these.  Obviously not.  I'll go through
> all the patches on this.

What you could do is run all patches through scripts/checkpatch.pl
and fix those issues which make sense to you. What I'm saying is, you
shouldn't take its output to the letter but some of the stuff it catches
are valid.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
