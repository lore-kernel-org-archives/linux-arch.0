Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <41F78364.6060409@yahoo.com.au>
Date: Wed, 26 Jan 2005 22:47:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: (resend) Converting architectures to 4 level page tables
References: <41F2EB0E.30407@yahoo.com.au> <20050125195043.45fed74b.davem@davemloft.net>
In-Reply-To: <20050125195043.45fed74b.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller wrote:
> On Sun, 23 Jan 2005 11:08:46 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>* replace
>>     #include <asm-generic/4level-fixup.h>
>>   in asm/pgtable.h with
>>     #include <asm-generic/pgtable-nopud.h>
> 
> 
> This breaks platforms like sparc64 because PTRS_PER_PMD is not
> a compile time constant.  It is actually dependant upon whether
> the current thread is using a 32-bit or 64-bit address space.
> 

Not sure I follow.... Oh, if it is just a matter of that
breaking the conditional compilation then OK, hmm.

These functions will simply never be called if the relevant
PTRS_PER_XXX is 1. Actually it is dependant on p?d_none
always being false.

So you shouldn't even need that runtime check there I think.
The #if was just a small space saving, but you could simply
remove that and be done with it I think. Or have I missed
something?
