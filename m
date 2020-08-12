Return-Path: <SRS0=fuLN=BW=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:39408 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgHLBIF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Aug 2020 21:08:05 -0400
Subject: Re: [PATCH v3 0/8] huge vmalloc mappings
References: <20200810022732.1150009-1-npiggin@gmail.com>
 <20200811173217.0000161e@huawei.com>
From: Zefan Li <lizefan@huawei.com>
Message-ID: <d457aabc-9f58-f47e-f5fa-9539618b2759@huawei.com>
Date: Wed, 12 Aug 2020 09:07:44 +0800
MIME-Version: 1.0
In-Reply-To: <20200811173217.0000161e@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20200812010744.KSdecKKAHpAajEK9u2gC-meigzB9xWCs0Zq3fEO8TLk@z>

On 2020/8/12 0:32, Jonathan Cameron wrote:
> On Mon, 10 Aug 2020 12:27:24 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
>> Not tested on x86 or arm64, would appreciate a quick test there so I can
>> ask Andrew to put it in -mm. Other option is I can disable huge vmallocs
>> for them for the time being.
> 
> Hi Nicholas,
> 
> For arm64 testing with a Kunpeng920.
> 
> I ran a quick sanity test with this series on top of mainline (yes mid merge window
> so who knows what state is...).  Could I be missing some dependency?
> 
> Without them it boots, with them it doesn't.  Any immediate guesses?
> 

I've already reported this bug in v2, and yeah I also tested it on arm64
(not Kunpeng though), so looks like it still hasn't been fixed.

...
>>
>> Since v2:
>> - Rebased on vmalloc cleanups, split series into simpler pieces.
>> - Fixed several compile errors and warnings
>> - Keep the page array and accounting in small page units because
>>   struct vm_struct is an interface (this should fix x86 vmap stack debug
>>   assert). [Thanks Zefan]

though the changelog says it's fixed for x86.
