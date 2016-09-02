From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 12/18] arm64: ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Fri, 2 Sep 2016 16:04:53 +0300
Message-ID: <20160902130453.GA14229@yury-N73SV>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
 <1471434403-25291-13-git-send-email-ynorov@caviumnetworks.com>
 <57C9587B.9080006@huawei.com>
 <6815916.BISHOLF1Ut@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <libc-alpha-return-73048-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <6815916.BISHOLF1Ut@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>
Cc: libc-alpha@sourceware.org, Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 02, 2016 at 02:55:34PM +0200, Arnd Bergmann wrote:
> On Friday, September 2, 2016 6:46:19 PM CEST Bamvor Jian Zhang wrote:
> > diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
> > index 043d17a..78bea1d 100644
> > --- a/arch/arm64/include/uapi/asm/unistd.h
> > +++ b/arch/arm64/include/uapi/asm/unistd.h
> > @@ -16,4 +16,9 @@
> > 
> >  #define __ARCH_WANT_RENAMEAT
> > 
> > +/* We need to make sure it works for both userspace and kernel(sys_ilp32.c) */
> > +#if defined(__ILP32__) || defined(__SYSCALL_COMPAT)
> > +#define __ARCH_WANT_SYNC_FILE_RANGE2
> > +#endif
> > +
> >  #include <asm-generic/unistd.h>
> > diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
> > index 10fc0ca..13c9c9d 100644
> > --- a/arch/arm64/kernel/sys_ilp32.c
> > +++ b/arch/arm64/kernel/sys_ilp32.c
> > @@ -42,7 +42,7 @@
> >  #define compat_sys_pwrite64            compat_sys_pwrite64_wrapper
> >  #define compat_sys_readahead           compat_sys_readahead_wrapper
> >  #define compat_sys_shmat               sys_shmat
> > -#define compat_sys_sync_file_range     compat_sys_sync_file_range2_wrapper
> > +#define compat_sys_sync_file_range2    compat_sys_sync_file_range2_wrapper
> >  #define compat_sys_truncate64          compat_sys_truncate64_wrapper
> >  #define sys_mmap2                      compat_sys_mmap2_wrapper
> >  #define sys_ptrace                     compat_sys_ptrace
> > 
> 
> Looks good to me.
> 
> 	Arnd

Thank you. I'll take it.

Yury.
