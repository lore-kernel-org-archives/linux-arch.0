From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] Revert "asm-generic: Remove unneeded
 __ARCH_WANT_SYS_LLSEEK macro"
Date: Fri, 30 Aug 2019 22:13:15 +0200
Message-ID: <20190830221315.4b3b8a74@kitsune.suse.cz>
References: <bb6d25c6baae315d05b571d8c508f0e8fa90027c.1567188299.git.msuchanek@suse.de>
 <20190830194651.31043-1-msuchanek@suse.de>
 <CAK8P3a16=ktJm5B3c5-XS7SqVuHBY5+E2FwVUqbdOdWK-AUgSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a16=ktJm5B3c5-XS7SqVuHBY5+E2FwVUqbdOdWK-AUgSA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>Linu
List-Id: linux-arch.vger.kernel.org

On Fri, 30 Aug 2019 21:54:43 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Fri, Aug 30, 2019 at 9:46 PM Michal Suchanek <msuchanek@suse.de> wrote:
> >
> > This reverts commit caf6f9c8a326cffd1d4b3ff3f1cfba75d159d70b.
> >
> > Maybe it was needed after all.
> >
> > When CONFIG_COMPAT is disabled on ppc64 the kernel does not build.
> >
> > There is resistance to both removing the llseek syscall from the 64bit
> > syscall tables and building the llseek interface unconditionally.
> >
> > Link: https://lore.kernel.org/lkml/20190828151552.GA16855@infradead.org/
> > Link: https://lore.kernel.org/lkml/20190829214319.498c7de2@naga/
> >
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>  
> 
> This seems like the right idea in principle.
> 
> > index 5bbf587f5bc1..2f3c4bb138c4 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -331,7 +331,7 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
> >  }
> >  #endif
> >
> > -#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
> > +#ifdef __ARCH_WANT_SYS_LLSEEK
> >  SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
> >                 unsigned long, offset_low, loff_t __user *, result,
> >                 unsigned int, whence)  
> 
> However, only reverting the patch will now break all newly added
> 32-bit architectures that don't define __ARCH_WANT_SYS_LLSEEK:
> at least nds32 and riscv32 come to mind, not sure if there is another.

AFAICT nds32 never had the syscall. Its headers were added without
__ARCH_WANT_SYS_LLSEEK before the define was removed.

The new architecture csky should be handled.

> 
> I think the easiest way however would be to combine the two checks
> above and make it
> 
> #if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT) ||
> defined(__ARCH_WANT_SYS_LLSEEK)
> 
> and then only set __ARCH_WANT_SYS_LLSEEK for powerpc.

Yes, that limits the use of __ARCH_WANT_SYS_LLSEEK, does not require
resurrecting the old headers, and may fix some architectures like nds32
that forgot to add it.

Thanks

Michal
