From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] arm64: fix current_thread_info()->addr_limit setup
Date: Fri, 13 May 2016 11:05:56 +0100
Message-ID: <20160513100556.GA27232@e104818-lin.cambridge.arm.com>
References: <1463069163-374-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512172203.GL11226@e104818-lin.cambridge.arm.com>
 <20160512175154.GA13383@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512175154.GA13383@yury-N73SV>
Sender: linux-kernel-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Thu, May 12, 2016 at 09:03:42PM +0300, Yury Norov wrote:
> On Thu, May 12, 2016 at 06:22:03PM +0100, Catalin Marinas wrote:
> > On Thu, May 12, 2016 at 07:06:03PM +0300, Yury Norov wrote:
> > > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > > index 24ed037..fda75ce 100644
> > > --- a/arch/arm64/include/asm/elf.h
> > > +++ b/arch/arm64/include/asm/elf.h
> > > @@ -138,7 +138,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
> > >   */
> > >  #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
> > >  
> > > -#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
> > > +#define SET_PERSONALITY(ex) do {					\
> > > +	clear_thread_flag(TIF_32BIT);					\
> > > +	set_fs(TASK_SIZE_64);						\
> > > +} while (0)
> > >  
> > >  #define ARCH_DLINFO							\
> > >  do {									\
> > > @@ -181,7 +184,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
> > >  					 ((x)->e_flags & EF_ARM_EABI_MASK))
> > >  
> > >  #define compat_start_thread		compat_start_thread
> > > -#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
> > > +#define COMPAT_SET_PERSONALITY(ex) do {					\
> > > +	set_thread_flag(TIF_32BIT);					\
> > > +	set_fs(TASK_SIZE_32);						\
> > > +} while (0)
> > > +
> > >  #define COMPAT_ARCH_DLINFO
> > >  extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
> > >  				      int uses_interp);
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index 0685d74..5b269e6 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -60,7 +60,7 @@ extern int fixup_exception(struct pt_regs *regs);
> > >  #define KERNEL_DS	(-1UL)
> > >  #define get_ds()	(KERNEL_DS)
> > >  
> > > -#define USER_DS		TASK_SIZE_64
> > > +#define USER_DS		TASK_SIZE
> > 
> > We can avoid the USER_DS change as long as SET_PERSONALITY updates the
> > thread's addr_limit. There are very few explicit set_fs(USER_DS) calls
> > and they are on the thread exit path (or exec).
> > 
> > That's unless we try to make a generic set_fs(USER_DS) addition to
> > something like setup_new_exec() and we wouldn't need the SET_PERSONALITY
> > changes:
> 
> I think we'd better leave it fixed. Just because it's correct. Now it
> looks like we have fixed early usages (before SET_PERSONALITY()) of
> set_fs() explicitly, and normal usages (and possible in future) by
> fixing USER_DS.

Thinking some more, let's first try to change USER_DS to the dynamic
TASK_SIZE and add a generic set_fs(USER_DS) call in setup_new_exec() as
below:

> > diff --git a/fs/exec.c b/fs/exec.c
> > index c4010b8207a1..54cc537f5986 100644
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -1226,6 +1226,9 @@ EXPORT_SYMBOL(would_dump);
> >  
> >  void setup_new_exec(struct linux_binprm * bprm)
> >  {
> > +	/* set the address limit for the new executable */
> > +	set_fs(USER_DS);
> > +
> >  	arch_pick_mmap_layout(current->mm);
> >  
> >  	/* This is the point of no return */
> > 

Cc'ing Al Viro for his opinion here.

In summary: access_ok() behaves differently on native 32-bit kernels vs
64-bit + compat applications because for the latter USER_DS is always
set to the maximum 64-bit TASK_SIZE (x86 and powerpc seem to do
something similar). Changing USER_DS alone in the arch code does not
help since the set_fs(USER_DS) in flush_old_exec() is called prior to
COMPAT_SET_PERSONALITY().

(it's not a serious bug, just some LTP tests failing when they test an
address range going beyond the 4GB limit)

Thanks.

-- 
Catalin
