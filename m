Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0060.outbound.protection.outlook.com ([104.47.40.60]:10912
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754785AbdEDONo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 May 2017 10:13:44 -0400
Subject: Re: [PATCH v5 31/32] x86: Add sysfs support for Secure Memory
 Encryption
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212212.10190.73484.stgit@tlendack-t1.amdoffice.net>
 <1498ec98-b19d-c47d-902b-a68870a3f860@intel.com>
 <20170427072547.GB15297@dhcp-128-65.nay.redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <2abc7ad8-9d64-8617-44fe-1cb8af31e1f6@amd.com>
Date: Thu, 4 May 2017 09:13:35 -0500
MIME-Version: 1.0
In-Reply-To: <20170427072547.GB15297@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Young <dyoung@redhat.com>, Dave Hansen <dave.hansen@intel.com>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170504141335.U0YpXwekNqf0TnK1jVyQ1CVNn-_hVH_xF-Xo-Nn4VgE@z>

On 4/27/2017 2:25 AM, Dave Young wrote:
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

Sorry, I haven't had a chance to test this yet.

Thanks,
Tom

>
> Thanks
> Dave
>
