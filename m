From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 11/18] arm64: ilp32: share aarch32 syscall handlers
Date: Tue, 6 Dec 2016 13:02:57 +0530
Message-ID: <20161206073257.GB18470@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-12-git-send-email-ynorov@caviumnetworks.com>
 <20161205171242.GH14429@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161205171242.GH14429@e104818-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, arnd@arndb.de, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

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

Current glibc implementation becomes broken for 64-bit off_t if
if I'll do what you want.
sysdeps/unix/sysv/linux/generic/wordsize-32/mmap.c
28 __ptr_t
29 __mmap (__ptr_t addr, size_t len, int prot, int flags, int fd, off_t offset)
30 {
31   if (offset & (MMAP_PAGE_UNIT - 1))
32     {
33       __set_errno (EINVAL);
34       return MAP_FAILED;
35     }
36   return (__ptr_t) INLINE_SYSCALL (mmap2, 6, addr, len, prot, flags, fd,
37                                    offset / MMAP_PAGE_UNIT);
38 }
39 
40 weak_alias (__mmap, mmap)

So it requires changes both in glibc and in kernel. I can do it. But
I'd like to collect opinions of kernel and glibc developers before
starting it. 

Yury
