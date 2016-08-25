From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/19] compat ABI: use non-compat openat and
 open_by_handle_at variants
Date: Thu, 25 Aug 2016 17:52:11 +0200
Message-ID: <3771388.9SFlpYVFmp@wuerfel>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <mvmwplbkr8l.fsf@hawking.suse.de> <20160815143028.GA7193@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160815143028.GA7193@yury-N73SV>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-doc@vger.kernel.org, szabolcs.nagy@arm.com, catalin.marinas@arm.com, heiko.carstens@de.ibm.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, linux-arch@vger.kernel.org, Prasun.Kapoor@caviumnetworks.com, Andreas Schwab <schwab@suse.de>, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, linux-arm-kernel@lists.infradead.org, maxim.kuvyrkov@linaro.org, libc-alpha@sourceware.org, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

On Monday, August 15, 2016 5:30:28 PM CEST Yury Norov wrote:
> On Mon, Jun 27, 2016 at 09:47:38AM +0200, Andreas Schwab wrote:
> > Yury Norov <ynorov@caviumnetworks.com> writes:
> > 
> > > The only difference is that non-compat version forces O_LARGEFILE,
> > > and it should be the default behaviour for all architectures, as
> > > we don't support 32-bit off_t. The only exception is tile32, that
> > > continues with compat version of syscalls.
> > >
> > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]
> > > ---
> > >  arch/tile/kernel/compat.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
> > > index 4912084..489ae19 100644
> > > --- a/arch/tile/kernel/compat.c
> > > +++ b/arch/tile/kernel/compat.c
> > > @@ -94,6 +94,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
> > >  #define compat_sys_readahead sys32_readahead
> > >  #define sys_llseek compat_sys_llseek
> > >  
> > > +#define sys_openat		compat_sys_openat
> > > +#define sys_open_by_handle_at	compat_sys_open_by_handle_at
> > > +
> > >  /* Call the assembly trampolines where necessary. */
> > >  #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
> > >  #define sys_clone _sys_clone
> > 
> > This is a no-op.  Did you mean to add this?  Without that the testsuite
> > of tar fails on ILP32.
> 
> The change you suggest below is what I originally sent at the end of
> December, but that chunk was lost after one of numerous rebases probably.
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1512.3/00510.html
> 
> IIRC, the only difference between this couple of syscalls and their
> compat versions is that non-compat syscalls set O_LARGEFILE depending
> on (BITS_PER_LONG != 32). Next patch of this series introduces
> ARCH_32BIT_OFF_T config option to force O_LARGEFILE for 64-bit arches,
> and all new 32-bit arches, as ARCH_32BIT_OFF_T is enabled for existing
> 32-bit arches explicitly.
> 
> O_LARGEFILE is controlled like this:
>         -#define force_o_largefile() (BITS_PER_LONG != 32)
>         +#define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> 
> So if I restore original patch, everything will work. But my question
> is: if ARCH_32BIT_OFF_T disables O_LARGEFILE for tile32 anyway, what
> for we redirect native syscall handlers to compat ones? They are
> looking identical...

I've lost context here, but let me try to recall what we had
discussed in the past:

- native 32-bit architectures are handled using CONFIG_ARCH_32BIT_OFF_T
- native 64-bit architectures keep setting the flag.
- compat 32-bit architectures need special cases, but the only one
  that exists is tile, which has to keep not setting O_LARGEFILE
  while new compat architectures (ilp32) should set it.
 
> If my understanding is correct, we can drop the change in
> arch/tile/kernel/compat.c and join this patch with next one in this
> series.
> 
> Chris, Arnd?

The change in arch/tile/kernel/compat.c can either come before the
below change, or in the same patch, but not later.

	Arnd

> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index a26415b..4dcc38d 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -178,7 +178,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
> >  #define __NR_fchown 55
> >  __SYSCALL(__NR_fchown, sys_fchown)
> >  #define __NR_openat 56
> > -__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
> > +__SYSCALL(__NR_openat, sys_openat)
> >  #define __NR_close 57
> >  __SYSCALL(__NR_close, sys_close)
> >  #define __NR_vhangup 58
> > @@ -676,8 +676,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
> >  #define __NR_name_to_handle_at         264
> >  __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
> >  #define __NR_open_by_handle_at         265
> > -__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
> > -	  compat_sys_open_by_handle_at)
> > +__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
> >  #define __NR_clock_adjtime 266
> >  __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
> >  #define __NR_syncfs 267
> 
