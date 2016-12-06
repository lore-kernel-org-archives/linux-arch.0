From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [Question] New mmap64 syscall?
Date: Wed, 7 Dec 2016 00:24:40 +0530
Message-ID: <20161206185440.GA4654@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: libc-alpha@sourceware.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

Hi all,

(Sorry if there is similar discussion, and I missed it. I didn't
find something in LKML in last half a year.)

In aarch64/ilp32 discussion Catalin wondered why we don't pass offset
in mmap() as 64-bit value (in 2 registers if needed). Looking at kernel
code I found that there's no generic interface for it. But almost all
architectures provide their own implementations, like this:

SYSCALL_DEFINE6(mips_mmap, unsigned long, addr, unsigned long, len,
                unsigned long, prot, unsigned long, flags, unsigned long,
                fd, off_t, offset)
{
        unsigned long result;

        result = -EINVAL;
        if (offset & ~PAGE_MASK)
                goto out;

        result = sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);

out:
        return result;
}

On glibc side things are even worse. There's no mmap() implementation
that allows to pass 64-bit offset in 32-bit architecture. mmap64() which 
is supposed to do this is simply broken:
void *
__mmap64 (void *addr, size_t len, int prot, int flags, int fd, off64_t
                offset)
{
        [...]
        void *result;
        result = (void *) INLINE_SYSCALL (mmap2, 6, addr,
                                         len, prot, flags, fd,
                                         (off_t) (offset >> page_shift));
        return result;
}

It explicitly declares offset as 64-bit value, but casts it to 32-bit
before passing to the kernel, which is wrong for me. Even if arch has
64-bit off_t, like aarch64/ilp32, the cast will take place because
offset is passed in a single register, which is 32-bit.

I see 3 solutions for my problem:
1. Reuse aarch64/lp64 mmap code for ilp32 in glibc, but wrap offset with
SYSCALL_LL64() macro - which converts offset to the pair for 32-bit
ports. This is simple but local solution. And most probably it's enough.

2. Add new flag to mmap, like MAP_OFFSET_IN_PAIR. This will also work.
The problem here is that there are too much arches that implement
their custom sys_mmap2(). And, of course, this type of flags is
looking ugly.

3. Introduce new mmap64() syscall like this:
sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
(The pointer here because otherwise we have 7 args, if simply pass off_hi and
off_lo in registers.)

With new 64-bit interface we can deprecate mmap2(), and generalize all
implementations in kernel.

I think we can discuss it because 64-bit is the default size for off_t 
in all new 32-bit architectures. So generic solution may take place.

The last question here is how important to support offsets bigger than
2^44 on 32-bit machines in practice? It may be a case for ARM64 servers,
which are looking like main aarch64/ilp32 users. If no, we can leave
things as is, and just do nothing.

Yury

On Mon, Dec 05, 2016 at 05:12:43PM +0000, Catalin Marinas wrote:
> On Fri, Oct 21, 2016 at 11:33:10PM +0300, Yury Norov wrote:
> > off_t is  passed in register pair just like in aarch32.
> > In this patch corresponding aarch32 handlers are shared to
> > ilp32 code.
> [...]
> > +/*
> > + * Note: off_4k (w5) is always in units of 4K. If we can't do the
> > + * requested offset because it is not page-aligned, we return -EINVAL.
> > + */
> > +ENTRY(compat_sys_mmap2_wrapper)
> > +#if PAGE_SHIFT > 12
> > +	tst	w5, #~PAGE_MASK >> 12
> > +	b.ne	1f
> > +	lsr	w5, w5, #PAGE_SHIFT - 12
> > +#endif
> > +	b	sys_mmap_pgoff
> > +1:	mov	x0, #-EINVAL
> > +	ret
> > +ENDPROC(compat_sys_mmap2_wrapper)
> 
> For compat sys_mmap2, the pgoff argument is in multiples of 4K. This was
> traditionally used for architectures where off_t is 32-bit to allow
> mapping files to 2^44.
> 
> Since off_t is 64-bit with AArch64/ILP32, should we just pass the off_t
> as a 64-bit value in two different registers (w5 and w6)?
