Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <41F78453.9090907@yahoo.com.au>
Date: Wed, 26 Jan 2005 22:51:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: (resend) Converting architectures to 4 level page tables
References: <41F2EB0E.30407@yahoo.com.au>	<20050125195043.45fed74b.davem@davemloft.net> <20050125210703.01329f10.davem@davemloft.net>
In-Reply-To: <20050125210703.01329f10.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller wrote:
> Ok, here is the full set of changes to convert sparc64.
> It includes the PTRS_PER_* compile time fixup for mm/memory.c
> I posted earlier tonight.
> 
> It's running just fine on my main devel machine.
> 
> I may convert sparc64 to have a real 4th level to it's
> page tables some day.
> 
> It was pretty painless and worked on first boot.  I may
> give sparc32 a shot but that is a little bit more involved
> since each MMU type defines it's own page table ops via
> function pointers.
> 

Great! Looks pretty sane from a quick glance (pending
the resolution of your mm/memory.c problem in the other
thread).
