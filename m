Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:10592
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750999AbdFUNxE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jun 2017 09:53:04 -0400
Subject: Re: [PATCH v7 07/36] x86/mm: Don't use phys_to_virt in ioremap() if
 SME is active
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
 <alpine.DEB.2.20.1706202251110.2157@nanos>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c1072435-e3ad-21ea-b36f-505ff80ed599@amd.com>
Date: Wed, 21 Jun 2017 08:52:53 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1706202251110.2157@nanos>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170621135253.XpUpiMLa8QkJmd8u3FI1TBUalSH0NSzUXpOet4wOlm0@z>

On 6/20/2017 3:55 PM, Thomas Gleixner wrote:
> On Fri, 16 Jun 2017, Tom Lendacky wrote:
> 
>> Currently there is a check if the address being mapped is in the ISA
>> range (is_ISA_range()), and if it is then phys_to_virt() is used to
>> perform the mapping.  When SME is active, however, this will result
>> in the mapping having the encryption bit set when it is expected that
>> an ioremap() should not have the encryption bit set. So only use the
>> phys_to_virt() function if SME is not active
> 
> This does not make sense to me. What the heck has phys_to_virt() to do with
> the encryption bit. Especially why would the encryption bit be set on that
> mapping in the first place?

The default is that all entries that get added to the pagetables have
the encryption bit set unless specifically overridden.  Any __va() or
phys_to_virt() calls will result in a pagetable mapping that has the
encryption bit set.  For ioremap, the PAGE_KERNEL_IO protection is used
which will not/does not have the encryption bit set.

> 
> I'm probably missing something, but this want's some coherent explanation
> understandable by mere mortals both in the changelog and the code comment.

I'll add some additional info to the changelog and code.

Thanks,
Tom

> 
> Thanks,
> 
> 	tglx
> 
