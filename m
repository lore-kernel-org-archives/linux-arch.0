Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267984AbUHKHgL@vger.kernel.org>
Received: from holomorphy.com ([207.189.100.168]:42625 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267979AbUHKHfu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 03:35:50 -0400
Date: Wed, 11 Aug 2004 00:35:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: copy_page_range()
Message-ID: <20040811073546.GQ11200@holomorphy.com>
References: <20040807000529.5ca6e8fe.davem@redhat.com> <20040807080751.GX17188@holomorphy.com> <20040811000708.6e31969d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811000708.6e31969d.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 7 Aug 2004 01:07:51 -0700 William Lee Irwin III wrote:
>> The number of levels can be abstracted easily. Something to give an
>> idea of how might be something like this:

On Wed, Aug 11, 2004 at 12:07:08AM -0700, David S. Miller wrote:
> I hacked up something slightly different today.  I only
> have it being used by clear_page_range() but it is extremely
> effective.
> Things like fork+exit latencies on my 750Mhz sparc64 box went
> from ~490 microseconds to ~367 microseconds.  fork+execve
> latency went down from ~1595 microseconds to ~1351 microseconds.

Nice results!


On Wed, Aug 11, 2004 at 12:07:08AM -0700, David S. Miller wrote:
> Two issues:
> 1) I'm not terribly satisfied with the interface.  I think
>    with some improvements it can be applies to the two other
>    routines this thing really makes sense for, namely copy_page_range
>    and unmap_page_range

I think this involves discriminating between walking in tandem
(over instantiated ptes in one and creation in the other),
single walking to instantiate new ptes in an address range, and walking
over instantiated ptes in an address range, possibly a fourth case for
destruction.


On Wed, Aug 11, 2004 at 12:07:08AM -0700, David S. Miller wrote:
> 2) I don't think it will collapse well for 2-level page tables,
>    someone take a look?

This is one of the reasons why I wanted to have the struct to put the
handling of levels in the arch bits of the walking. That way, 2-level
pagetables can be done without maintaining the extraneous pointer or
the extra level of calls.


On Wed, Aug 11, 2004 at 12:07:08AM -0700, David S. Miller wrote:
> It's easy to toy with the sparc64 optimization on other platforms,
> just add the necessary hacks to pmd_set and pgd_set, allocation
> of pmd and pgd tables, use "PAGE_SHIFT - 5" instead of "PAGE_SHIFT - 6"
> on 32-bit platforms, and then copy the asm-sparc64/pgwalk.h bits over
> into your platforms asm-${ARCH}/pgwalk.h
> I just got also reminded that we walk these damn pagetables completely
> twice every exit, once to unmap the VMAs pte mappings, once again to
> zap the page tables.  It might be fruitful to explore combining
> those two steps, perhaps not.

We really need to be freeing up pagetables during unmapping better,
since they do "leak" a bit. This is causing pain elsewhere (hugetlb).
Once we do that, clear_page_tables() is a nop and all its work is done
while unmapping all the vmas. I vaguely remember some patches
(associated with the shpte efforts) to do something like this having
gone around before, though those were specifically directed at exit()
and not at general munmap().


On Wed, Aug 11, 2004 at 12:07:08AM -0700, David S. Miller wrote:
> Anyways, comments and improvment suggestions welcome.  Particularly
> interesting would be if this thing helps a lot on other platforms
> too, such as x86_64, ia64, alpha and ppc64.

I need to play with it a little to see what I can do.


-- wli
