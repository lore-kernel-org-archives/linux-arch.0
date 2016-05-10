Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:33791 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231AbcEJN6F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 May 2016 09:58:05 -0400
Date: Tue, 10 May 2016 15:57:58 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH v1 10/18] x86/efi: Access EFI related tables in the
 clear
Message-ID: <20160510135758.GA16783@pd.tnic>
References: <20160426225553.13567.19459.stgit@tlendack-t1.amdoffice.net>
 <20160426225740.13567.85438.stgit@tlendack-t1.amdoffice.net>
 <20160510134358.GR2839@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160510134358.GR2839@codeblueprint.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160510135758.mQf1Wf4aD1KESawokOjjivbx9kvdXeOiDvEsVWa3bSI@z>

On Tue, May 10, 2016 at 02:43:58PM +0100, Matt Fleming wrote:
> Is it not possible to maintain some kind of kernel virtual address
> mapping so memremap*() and friends can figure out when to twiddle the
> mapping attributes and map with/without encryption?

I guess we can move the sme_* specific stuff one indirection layer
below, i.e., in the *memremap() routines so that callers don't have to
care... That should keep the churn down...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
