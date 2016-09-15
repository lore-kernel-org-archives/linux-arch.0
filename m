Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0069.outbound.protection.outlook.com ([104.47.32.69]:30528
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750878AbcIORH7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Sep 2016 13:07:59 -0400
Subject: Re: [RFC PATCH v2 11/20] mm: Access BOOT related data in the clear
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223738.29880.6909.stgit@tlendack-t1.amdoffice.net>
 <CALCETrUk2kRSzKfwhio6KV3iuYaSV2uxybd-e95kK3vY=yTSfg@mail.gmail.com>
 <e30ddb53-df6c-28ee-54fe-f3e52e515acb@amd.com>
 <20160915095709.GB16797@codeblueprint.co.uk>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d25531f2-cc17-aa65-c6b9-f72e97b69b00@amd.com>
Date: Thu, 15 Sep 2016 11:52:05 -0500
MIME-Version: 1.0
In-Reply-To: <20160915095709.GB16797@codeblueprint.co.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Andy Lutomirski <luto@amacapital.net>, kasan-dev <kasan-dev@googlegroups.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, iommu@lists.linux-foundation.org, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>, Dave Young <dyoung@redhat.com>
Message-ID: <20160915165205.Ec3LiE6OAYNPN9xmMEsO_czySp_Np1C148VjIrvxEfQ@z>

On 09/15/2016 04:57 AM, Matt Fleming wrote:
> On Wed, 14 Sep, at 09:20:44AM, Tom Lendacky wrote:
>> On 09/12/2016 11:55 AM, Andy Lutomirski wrote:
>>> On Aug 22, 2016 6:53 PM, "Tom Lendacky" <thomas.lendacky@amd.com> wrote:
>>>>
>>>> BOOT data (such as EFI related data) is not encyrpted when the system is
>>>> booted and needs to be accessed as non-encrypted.  Add support to the
>>>> early_memremap API to identify the type of data being accessed so that
>>>> the proper encryption attribute can be applied.  Currently, two types
>>>> of data are defined, KERNEL_DATA and BOOT_DATA.
>>>
>>> What happens when you memremap boot services data outside of early
>>> boot?  Matt just added code that does this.
>>>
>>> IMO this API is not so great.  It scatters a specialized consideration
>>> all over the place.  Could early_memremap not look up the PA to figure
>>> out what to do?
>>
>> Yes, I could see if the PA falls outside of the kernel usable area and,
>> if so, remove the memory encryption attribute from the mapping (for both
>> early_memremap and memremap).
>>
>> Let me look into that, I would prefer something along that line over
>> this change.
> 
> So, the last time we talked about using the address to figure out
> whether to encrypt/decrypt you said,
> 
>  "I looked into this and this would be a large change also to parse
>   tables and build lists."
> 
> Has something changed that makes this approach easier?

The original idea of parsing the tables and building a list was
a large change.  This approach would be simpler by just checking if
the PA is outside the kernel usable area, and if so, removing the
encryption bit.

> 
> And again, you need to be careful with the EFI kexec code paths, since
> you've got a mixture of boot and kernel data being passed. In
> particular the EFI memory map is allocated by the firmware on first
> boot (BOOT_DATA) but by the kernel on kexec (KERNEL_DATA).
> 
> That's one of the reasons I suggested requiring the caller to decide
> on BOOT_DATA vs KERNEL_DATA - when you start looking at kexec the
> distinction isn't easily made.

Yeah, for kexec I think I'll need to make sure that everything looks
like it came from the BIOS/UEFI/bootloader.  If all of the kexec
pieces are allocated with un-encrypted memory, then the boot path
should remain the same.  That's the piece I need to investigate
further.

Thanks,
Tom

> 
