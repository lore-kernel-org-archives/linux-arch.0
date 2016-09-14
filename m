Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:11728
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1764171AbcINOU5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Sep 2016 10:20:57 -0400
Subject: Re: [RFC PATCH v2 11/20] mm: Access BOOT related data in the clear
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223738.29880.6909.stgit@tlendack-t1.amdoffice.net>
 <CALCETrUk2kRSzKfwhio6KV3iuYaSV2uxybd-e95kK3vY=yTSfg@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e30ddb53-df6c-28ee-54fe-f3e52e515acb@amd.com>
Date: Wed, 14 Sep 2016 09:20:44 -0500
MIME-Version: 1.0
In-Reply-To: <CALCETrUk2kRSzKfwhio6KV3iuYaSV2uxybd-e95kK3vY=yTSfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Matt Fleming <mfleming@suse.de>
Cc: kasan-dev <kasan-dev@googlegroups.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>
Message-ID: <20160914142044.nGGN5EsP2yB-zpSUDm9xWshlRzBM1tzPfCyXhzBEcDY@z>

On 09/12/2016 11:55 AM, Andy Lutomirski wrote:
> On Aug 22, 2016 6:53 PM, "Tom Lendacky" <thomas.lendacky@amd.com> wrote:
>>
>> BOOT data (such as EFI related data) is not encyrpted when the system is
>> booted and needs to be accessed as non-encrypted.  Add support to the
>> early_memremap API to identify the type of data being accessed so that
>> the proper encryption attribute can be applied.  Currently, two types
>> of data are defined, KERNEL_DATA and BOOT_DATA.
> 
> What happens when you memremap boot services data outside of early
> boot?  Matt just added code that does this.
> 
> IMO this API is not so great.  It scatters a specialized consideration
> all over the place.  Could early_memremap not look up the PA to figure
> out what to do?

Yes, I could see if the PA falls outside of the kernel usable area and,
if so, remove the memory encryption attribute from the mapping (for both
early_memremap and memremap).

Let me look into that, I would prefer something along that line over
this change.

Thanks,
Tom

> 
> --Andy
> 
