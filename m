Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com ([104.47.33.87]:25632
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1761527AbcINOLa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Sep 2016 10:11:30 -0400
Subject: Re: [RFC PATCH v2 10/20] x86: Insure that memory areas are encrypted
 when possible
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223722.29880.94331.stgit@tlendack-t1.amdoffice.net>
 <20160909155305.bmm2fvw7ndjjhqvo@pd.tnic>
 <23855fb4-05b0-4c12-d34f-4d5f45f3b015@amd.com>
 <20160912163349.exnuvr7svsq7fmui@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <74d7fcd4-18e6-a81c-2510-bf0fe8a08a53@amd.com>
Date: Wed, 14 Sep 2016 09:11:13 -0500
MIME-Version: 1.0
In-Reply-To: <20160912163349.exnuvr7svsq7fmui@pd.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160914141113.Zl8S2dFmCd_KPzUEdKtkxDdCfDHRFz_uyj5RXcGo90Q@z>

On 09/12/2016 11:33 AM, Borislav Petkov wrote:
> On Mon, Sep 12, 2016 at 10:05:36AM -0500, Tom Lendacky wrote:
>> I can look into that.  The reason I put this here is this is all the
>> early page fault support that is very specific to this file. I modified
>> an existing static function to take advantage of the mapping support.
> 
> Yeah, but all this code is SME-specific and doesn't belong there.
> AFAICT, it uses global/public symbols so there shouldn't be a problem to
> have it in mem_encrypt.c.

Ok, I'll look into moving this into mem_encrypt.c. I'd like to avoid
duplicating code so I may have to make that static function external
unless I find a better way.

Thanks,
Tom

> 
>> Hmmm, maybe... With the change to the early_memremap() the initrd is now
>> identified as BOOT_DATA in relocate_initrd() and so it will be mapped
>> and copied as non-encyrpted data. But since it was encrypted before the
>> call to relocate_initrd() it will copy encrypted bytes which will later
>> be accessed encrypted. That isn't clear though, so I'll rework
>> reserve_initrd() to perform the sme_early_mem_enc() once at the end
>> whether the initrd is re-located or not.
> 
> Makes sense.
> 
