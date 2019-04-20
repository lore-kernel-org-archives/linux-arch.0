Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:51065 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTLAb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 20 Apr 2019 07:00:31 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] [v2] x86/mpx: fix recursive munmap() corruption
In-Reply-To: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
References: <20190419194747.5E1AD6DC@viggo.jf.intel.com>
Date: Sat, 20 Apr 2019 21:00:21 +1000
Message-ID: <878sw5szzu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: rguenther@suse.de, hjl.tools@gmail.com, yang.shi@linux.alibaba.com, mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net, x86@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, benh@kernel.crashing.org, paulus@samba.org, linux-arch@vger.kernel.org, gxt@pku.edu.cn, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Message-ID: <20190420110021.QSLCW5aTkbpiy1N-MRGC12IYJBql9DcNkAWULQdiBnU@z>

Dave Hansen <dave.hansen@linux.intel.com> writes:
> Changes from v1:
>  * Fix compile errors on UML and non-x86 arches
>  * Clarify commit message and Fixes about the origin of the
>    bug and add the impact to powerpc / uml / unicore32
>
> --
>
> This is a bit of a mess, to put it mildly.  But, it's a bug
> that only seems to have showed up in 4.20 but wasn't noticed
> until now because nobody uses MPX.
>
> MPX has the arch_unmap() hook inside of munmap() because MPX
> uses bounds tables that protect other areas of memory.  When
> memory is unmapped, there is also a need to unmap the MPX
> bounds tables.  Barring this, unused bounds tables can eat 80%
> of the address space.
>
> But, the recursive do_munmap() that gets called vi arch_unmap()
> wreaks havoc with __do_munmap()'s state.  It can result in
> freeing populated page tables, accessing bogus VMA state,
> double-freed VMAs and more.
>
> To fix this, call arch_unmap() before __do_unmap() has a chance
> to do anything meaningful.  Also, remove the 'vma' argument
> and force the MPX code to do its own, independent VMA lookup.
>
> == UML / unicore32 impact ==
>
> Remove unused 'vma' argument to arch_unmap().  No functional
> change.
>
> I compile tested this on UML but not unicore32.
>
> == powerpc impact ==
>
> powerpc uses arch_unmap() well to watch for munmap() on the
> VDSO and zeroes out 'current->mm->context.vdso_base'.  Moving
> arch_unmap() makes this happen earlier in __do_munmap().  But,
> 'vdso_base' seems to only be used in perf and in the signal
> delivery that happens near the return to userspace.  I can not
> find any likely impact to powerpc, other than the zeroing
> happening a little earlier.

Yeah I agree.

> powerpc does not use the 'vma' argument and is unaffected by
> its removal.
>
> I compile-tested a 64-bit powerpc defconfig.

Thanks.

cheers
