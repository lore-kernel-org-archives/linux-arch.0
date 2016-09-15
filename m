Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0056.outbound.protection.outlook.com ([104.47.41.56]:38752
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752161AbcIORIV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Sep 2016 13:08:21 -0400
Subject: Re: [RFC PATCH v2 19/20] x86: Access the setup data through debugfs
 un-encrypted
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223859.29880.60652.stgit@tlendack-t1.amdoffice.net>
 <20160912165944.rpqbwxz2biathnt3@pd.tnic>
 <4a357b9b-7d53-5bd6-81db-9d8cc63a6c72@amd.com>
 <20160914145101.GB9295@nazgul.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b734c2da-fee4-efae-fda2-bbcd74abbb33@amd.com>
Date: Thu, 15 Sep 2016 12:08:04 -0500
MIME-Version: 1.0
In-Reply-To: <20160914145101.GB9295@nazgul.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160915170804.F493cuApw-mYjdpUOodUCl_qaYGPd1CJ6PwUIT0-nEo@z>

On 09/14/2016 09:51 AM, Borislav Petkov wrote:
> On Wed, Sep 14, 2016 at 09:29:41AM -0500, Tom Lendacky wrote:
>> This is still required because just using the __va() would still cause
>> the mapping created to have the encryption bit set. The ioremap call
>> will result in the mapping not having the encryption bit set.
> 
> I meant this: https://lkml.kernel.org/r/20160902181447.GA25328@nazgul.tnic
> 
> Wouldn't simply clearing the SME mask work?
> 
> #define __va(x)			((void *)(((unsigned long)(x)+PAGE_OFFSET) & ~sme_me_mask))
> 
> Or are you saying, one needs the whole noodling through ioremap_cache()
> because the data is already encrypted and accessing it with sme_me_mask
> cleared would simply give you the encrypted garbage?

The problem is that this physical address does not contain the
encryption bit, and even if it did, it wouldn't matter.  The __va()
define creates a virtual address that will be mapped as encrypted given
the current approach (which is how I found this).  It's only ioremap()
that would create a mapping without the encryption attribute and since
this is unencrypted data it needs to be access accordingly.

Thanks,
Tom

> 
