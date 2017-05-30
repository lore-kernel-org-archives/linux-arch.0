Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0051.outbound.protection.outlook.com ([104.47.41.51]:49856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750938AbdE3Rru (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 May 2017 13:47:50 -0400
Subject: Re: [PATCH v5 17/32] x86/mm: Add support to access boot related data
 in the clear
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418211921.10190.1537.stgit@tlendack-t1.amdoffice.net>
 <20170515183517.mb4k2gp2qobbuvtm@pd.tnic>
 <20170518195051.GA5651@codeblueprint.co.uk>
 <4c2ef3ba-2940-3330-d362-5b2b0d812c6f@amd.com>
 <20170526163517.nrweesvse24dszkz@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <900ee7c4-221a-f4d6-93c6-81dfc0612dbf@amd.com>
Date: Tue, 30 May 2017 12:47:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170526163517.nrweesvse24dszkz@pd.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Larry Woodman <lwoodman@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20170530174730.Yet2InNmSPmv0sXROFh9JgLoijocc8uLuIFPuAlIBGU@z>

On 5/26/2017 11:35 AM, Borislav Petkov wrote:
> On Fri, May 26, 2017 at 11:22:36AM -0500, Tom Lendacky wrote:
>> In addition to the same issue as efi.memmap.phys_map, efi_phys has
>> the __initdata attribute so it will be released/freed which will cause
>> problems in checks performed afterwards.
> 
> Sounds to me like we should drop the __initdata attr and prepare them
> much earlier for use by the SME code.

Probably something we can look at for a follow-on patch.

Thanks,
Tom

> 
