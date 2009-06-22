From: David Miller <davem@davemloft.net>
Subject: Re: handle_mm_fault() calling convention cleanup..
Date: Sun, 21 Jun 2009 19:20:01 -0700 (PDT)
Message-ID: <20090621.192001.46889618.davem@davemloft.net>
References: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <alpine.LFD.2.01.0906211331480.3240@localhost.localdomain>
Sender: owner-linux-mm@kvack.org
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org, hugh@veritas.com, npiggin@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org, fengguang.wu@intel.com, mingo@elte.hu
List-Id: linux-arch.vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jun 2009 13:42:35 -0700 (PDT)

> I fixed up all architectures that I noticed (at least microblaze had been 
> added since the original patches in April), but arch maintainers should 
> double-check. Arch maintainers might also want to check whether the 
> mindless conversion of
> 
> 	'is_write' => 'is_write ? FAULT_FLAGS_WRITE : 0'
> 
> might perhaps be written in some more natural way (for example, maybe 
> you'd like to get rid of 'iswrite' as a variable entirely, and replace it 
> with a 'fault_flags' variable).
> 
> It's pushed out and tested on x86-64, but it really was such a mindless 
> conversion that I hope it works on all architectures. But I thought I'd 
> better give people a shout-out regardless.

Sparc looks good, and sparc64 seems to work fine.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
