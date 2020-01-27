From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Date: Mon, 27 Jan 2020 13:43:34 +0530
Message-ID: <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
 <20200127081134.GI14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727754AbgA0INs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 03:13:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00R8AIAM103565
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 03:13:46 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrg61rffy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 03:13:46 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 27 Jan 2020 08:13:44 -0000
In-Reply-To: <20200127081134.GI14914@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>

On 1/27/20 1:41 PM, Peter Zijlstra wrote:
> On Sun, Jan 26, 2020 at 07:52:05AM -0800, Guenter Roeck wrote:
>> On Thu, Dec 12, 2019 at 10:32:05AM +0100, Peter Zijlstra wrote:
>>> As described in the comment, the correct order for freeing pages is:
>>>
>>>   1) unhook page
>>>   2) TLB invalidate page
>>>   3) free page
>>>
>>> This order equally applies to page directories.
>>>
>>> Currently there are two correct options:
>>>
>>>   - use tlb_remove_page(), when all page directores are full pages and
>>>     there are no futher contraints placed by things like software
>>>     walkers (HAVE_FAST_GUP).
>>>
>>>   - use MMU_GATHER_RCU_TABLE_FREE and tlb_remove_table() when the
>>>     architecture does not do IPI based TLB invalidate and has
>>>     HAVE_FAST_GUP (or software TLB fill).
>>>
>>> This however leaves architectures that don't have page based
>>> directories but don't need RCU in a bind. For those, provide
>>> MMU_GATHER_TABLE_FREE, which provides the independent batching for
>>> directories without the additional RCU freeing.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>
>> Various sparc64 builds (allnoconfig, tinyconfig, as well as builds
>> with SMP disabled):
>>
>> mm/mmu_gather.c: In function '__tlb_remove_table_free':
>> mm/mmu_gather.c:101:3: error: implicit declaration of function '__tlb_remove_table'; did you mean 'tlb_remove_table'?
> 
> Thanks; I'll respin these patches against Aneesh' pile and make sure to
> look into this when I do so.
> 
> 

I did send a change to fix that. it is to drop !SMP change in the patch

https://lore.kernel.org/linux-mm/87v9p9mhnr.fsf@linux.ibm.com


-aneesh
