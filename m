Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:46048
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756348AbcINOM0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Sep 2016 10:12:26 -0400
Subject: Re: [RFC PATCH v2 16/20] x86: Check for memory encryption on the APs
References: <20160822223529.29880.50884.stgit@tlendack-t1.amdoffice.net>
 <20160822223829.29880.10341.stgit@tlendack-t1.amdoffice.net>
 <20160912164303.kaqx2ayqjtbkcc2z@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <d4ba2c6c-491a-7107-9a0d-daa78446cd9c@amd.com>
Date: Wed, 14 Sep 2016 09:12:17 -0500
MIME-Version: 1.0
In-Reply-To: <20160912164303.kaqx2ayqjtbkcc2z@pd.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Potapenko <glider@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20160914141217.LCTzNRYdwblr2C9XLUMegqP_e_DfonRN9PXDfeUgorM@z>



On 09/12/2016 11:43 AM, Borislav Petkov wrote:
> On Mon, Aug 22, 2016 at 05:38:29PM -0500, Tom Lendacky wrote:
>> Add support to check if memory encryption is active in the kernel and that
>> it has been enabled on the AP. If memory encryption is active in the kernel
> 
> A small nit: let's write out "AP" the first time at least: "... on the
> Application Processors (AP)." for more clarity.

Will do.

Thanks,
Tom

> 
