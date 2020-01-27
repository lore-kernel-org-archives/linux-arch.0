From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Date: Mon, 27 Jan 2020 19:12:45 +0530
Message-ID: <523015f1-99d0-3974-8f4a-44f54d4280c2@linux.ibm.com>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
 <20200127081134.GI14914@hirez.programming.kicks-ass.net>
 <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
 <20200127130503.GG14879@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgA0NnA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 08:43:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RDfhmH118377
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 08:42:59 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrffynsrw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2020 08:42:59 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Mon, 27 Jan 2020 13:42:57 -0000
In-Reply-To: <20200127130503.GG14879@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>

On 1/27/20 6:35 PM, Peter Zijlstra wrote:
> On Mon, Jan 27, 2020 at 01:43:34PM +0530, Aneesh Kumar K.V wrote:
> 
>> I did send a change to fix that. it is to drop !SMP change in the patch
>>
>> https://lore.kernel.org/linux-mm/87v9p9mhnr.fsf@linux.ibm.com
> 
> Indeed you did. Did those patches land anywhere, or is it all still up
> in the air? (I was hoping to find those patches in a tree somewhere)
> 

Andrew did pick the series. I am not sure whether he got to pick the 
build fix.

Guenter,

Can you confirm that patch did fix the build issue?


-aneesh
