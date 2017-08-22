From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC v6 35/62] powerpc: Deliver SEGV signal on pkey violation
Date: Tue, 22 Aug 2017 11:06:37 -0700
Message-ID: <20170822180637.GA17106@ram.oc3035372033.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
 <1500177424-13695-36-git-send-email-linuxram@us.ibm.com>
 <87d17rnzll.fsf@xmission.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <87d17rnzll.fsf@xmission.com>
Sender: owner-linux-mm@kvack.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 19, 2017 at 02:09:58PM -0500, Eric W. Biederman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index d4e545d..fe1e7c7 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/sched/debug.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> > +#include <linux/pkeys.h>
> >  #include <linux/stddef.h>
> >  #include <linux/unistd.h>
> >  #include <linux/ptrace.h>
> > @@ -247,6 +248,15 @@ void user_single_step_siginfo(struct task_struct *tsk,
> >  	info->si_addr = (void __user *)regs->nip;
> >  }
> >  
> > +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> > +static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
> > +{
> > +	if (si_code != SEGV_PKUERR)
> > +		return;
> 
> Given that SEGV_PKUERR is a signal specific si_code this test is
> insufficient to detect an pkey error.  You also need to check
> that signr == SIGSEGV

true. will make it a more precise check.

Thanks
RP

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
