Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:52979
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750794AbcIOQ5t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Sep 2016 12:57:49 -0400
Subject: Re: [RFC PATCH v2 15/20] iommu/amd: AMD IOMMU support for memory
 encryption
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223820.29880.17752.stgit@tlendack-t1.amdoffice.net>
 <20160912114550.nwhtpmncwp22l7vy@pd.tnic>
 <27bc5c87-3a74-a1ee-55b1-7f19ec9cd6cc@amd.com>
 <20160914144139.GA9295@nazgul.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <421c767b-2410-2537-4f4e-b70670898fee@amd.com>
Date: Thu, 15 Sep 2016 11:57:41 -0500
MIME-Version: 1.0
In-Reply-To: <20160914144139.GA9295@nazgul.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160915165741.07v1WPLVw0E8SQWeNVIjBPyvkt72r8_zAd11kyv890o@z>

On 09/14/2016 09:41 AM, Borislav Petkov wrote:
> On Wed, Sep 14, 2016 at 08:45:44AM -0500, Tom Lendacky wrote:
>> Currently, mem_encrypt.h only lives in the arch/x86 directory so it
>> wouldn't be able to be included here without breaking other archs.
> 
> I'm wondering if it would be simpler to move only sme_me_mask to an
> arch-agnostic header just so that we save us all the code duplication.
> 
> Hmmm.

If I do that, then I could put an #ifdef in the header to include the
asm/mem_encrypt.h if the memory encryption is configured, else set the
value to zero.  I'll look into this.  One immediate question becomes do
we keep the name very specific vs. making it more generic, sme_me_mask
vs me_mask, etc.

Thanks,
Tom

> 
