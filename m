Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:40330
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933985AbdBQP4d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Feb 2017 10:56:33 -0500
Subject: Re: [RFC PATCH v4 02/28] x86: Set the write-protect cache mode for
 full PAT support
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154225.19244.96438.stgit@tlendack-t1.amdoffice.net>
 <20170217110724.ah5s3rz6emwxoc3u@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <389b298d-b73e-bd17-626b-974b3848232d@amd.com>
Date: Fri, 17 Feb 2017 09:56:17 -0600
MIME-Version: 1.0
In-Reply-To: <20170217110724.ah5s3rz6emwxoc3u@pd.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rik van Riel <riel@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170217155617.WyFy24QqFFfYq7Dzcf2QrYzXPfzrWexfK6mGwedB0Zw@z>

On 2/17/2017 5:07 AM, Borislav Petkov wrote:
> On Thu, Feb 16, 2017 at 09:42:25AM -0600, Tom Lendacky wrote:
>> For processors that support PAT, set the write-protect cache mode
>> (_PAGE_CACHE_MODE_WP) entry to the actual write-protect value (x05).
>>
>> Acked-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>
> Just a nit:
>
> Subject should have "x86/mm/pat: " prefix but that can be fixed when
> applying.

I'll go through the series and verify/fix the prefix for each patch.

Thanks,
Tom

>
