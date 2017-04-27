Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58482 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031688AbdD0Pwh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Apr 2017 11:52:37 -0400
Subject: Re: [PATCH v5 31/32] x86: Add sysfs support for Secure Memory
 Encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212212.10190.73484.stgit@tlendack-t1.amdoffice.net>
 <1498ec98-b19d-c47d-902b-a68870a3f860@intel.com>
 <20170427072547.GB15297@dhcp-128-65.nay.redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1f034974-20e6-b5e9-e6ff-434b634e1522@intel.com>
Date: Thu, 27 Apr 2017 08:52:34 -0700
MIME-Version: 1.0
In-Reply-To: <20170427072547.GB15297@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170427155234.EySZ9pIn7RzbyhOrWawbCI1f5Ohs5OfMXM2qRsgDo6Q@z>

On 04/27/2017 12:25 AM, Dave Young wrote:
> On 04/21/17 at 02:55pm, Dave Hansen wrote:
>> On 04/18/2017 02:22 PM, Tom Lendacky wrote:
>>> Add sysfs support for SME so that user-space utilities (kdump, etc.) can
>>> determine if SME is active.
>>>
>>> A new directory will be created:
>>>   /sys/kernel/mm/sme/
>>>
>>> And two entries within the new directory:
>>>   /sys/kernel/mm/sme/active
>>>   /sys/kernel/mm/sme/encryption_mask
>>
>> Why do they care, and what will they be doing with this information?
> 
> Since kdump will copy old memory but need this to know if the old memory
> was encrypted or not. With this sysfs file we can know the previous SME
> status and pass to kdump kernel as like a kernel param.
> 
> Tom, have you got chance to try if it works or not?

What will the kdump kernel do with it though?  We kexec() into that
kernel so the SME keys will all be the same, right?  So, will the kdump
kernel be just setting the encryption bit in the PTE so it can copy the
old plaintext out?

Why do we need both 'active' and 'encryption_mask'?  How could it be
that the hardware-enumerated 'encryption_mask' changes across a kexec()?
