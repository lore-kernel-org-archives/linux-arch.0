Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40725 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752675AbcILQfb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Sep 2016 12:35:31 -0400
Date: Mon, 12 Sep 2016 18:35:26 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v2 11/20] mm: Access BOOT related data in the clear
Message-ID: <20160912163526.tdmdssawmole723n@pd.tnic>
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223738.29880.6909.stgit@tlendack-t1.amdoffice.net>
 <20160909163814.sgsi2jlxlshskt5c@pd.tnic>
 <6431e761-a4c8-c9bb-1352-6d66672200fd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6431e761-a4c8-c9bb-1352-6d66672200fd@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160912163526.eRu_gXGMvH8zVz2A0g4xuj6ML79IXE2b1Rv2TpPvQ28@z>

On Mon, Sep 12, 2016 at 10:14:59AM -0500, Tom Lendacky wrote:
> I did run checkpatch against everything, but was always under the
> assumption that I shouldn't change existing warnings/errors like this.
> If it's considered ok since I'm touching that line of code then I'll
> take care of those situations.

Yeah, normally we fix sensible checkpatch warnings/errors when we touch
the code so please do correct them :-)

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
