Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754124AbdKGL0R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Nov 2017 06:26:17 -0500
Subject: Re: POWER: Unexpected fault when writing to brk-allocated memory
References: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
 <20171105231850.5e313e46@roar.ozlabs.ibm.com>
 <871slcszfl.fsf@linux.vnet.ibm.com>
 <20171106174707.19f6c495@roar.ozlabs.ibm.com>
 <24b93038-76f7-33df-d02e-facb0ce61cd2@redhat.com>
 <20171106192524.12ea3187@roar.ozlabs.ibm.com>
 <d52581f4-8ca4-5421-0862-3098031e29a8@linux.vnet.ibm.com>
 <546d4155-5b7c-6dba-b642-29c103e336bc@redhat.com>
 <20171107160705.059e0c2b@roar.ozlabs.ibm.com>
 <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <c5586546-1e7e-0f0f-a8b3-680fadb38dcf@redhat.com>
Date: Tue, 7 Nov 2017 12:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171107111543.ep57evfxxbwwlhdh@node.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Nicholas Piggin <npiggin@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20171107112612.Ba4fizm3cP9EAxpucpedlaUJ3qYkmUQxH2n9Yr_szHI@z>

On 11/07/2017 12:15 PM, Kirill A. Shutemov wrote:

>> First of all, using addr and MAP_FIXED to develop our heuristic can
>> never really give unchanged ABI. It's an in-band signal. brk() is a
>> good example that steadily keeps incrementing address, so depending
>> on malloc usage and address space randomization, you will get a brk()
>> that ends exactly at 128T, then the next one will be >
>> DEFAULT_MAP_WINDOW, and it will switch you to 56 bit address space.
> 
> No, it won't. You will hit stack first.

That's not actually true on POWER in some cases.  See the process maps I 
posted here:

   <https://marc.info/?l=linuxppc-embedded&m=150988538106263&w=2>

Thanks,
Florian
