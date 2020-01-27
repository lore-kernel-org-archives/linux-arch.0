Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
 <20200127081134.GI14914@hirez.programming.kicks-ass.net>
 <33932bc9-1fca-66ae-8f55-6da2f131c5be@linux.ibm.com>
 <20200127130503.GG14879@hirez.programming.kicks-ass.net>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 27 Jan 2020 19:12:45 +0530
MIME-Version: 1.0
In-Reply-To: <20200127130503.GG14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <523015f1-99d0-3974-8f4a-44f54d4280c2@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200127134245.e83MJqK624mQ0_NQLGntewV1sHL32W6hM4SGQYuhuik@z>

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
