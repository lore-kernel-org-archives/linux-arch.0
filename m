From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v10 27/27] mm: display pkey in smaps if
 arch_pkeys_enabled() is true
Date: Fri, 19 Jan 2018 08:50:50 -0800
Message-ID: <20180119165050.GK5612@ram.oc3035372033.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
 <1516326648-22775-28-git-send-email-linuxram@us.ibm.com>
 <87shb1de4a.fsf@xmission.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755772AbeASQvO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jan 2018 11:51:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0JGnOCZ011227
        for <linux-arch@vger.kernel.org>; Fri, 19 Jan 2018 11:51:14 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fkhk5g41n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 19 Jan 2018 11:51:13 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <linuxram@us.ibm.com>;
        Fri, 19 Jan 2018 16:51:11 -0000
Content-Disposition: inline
In-Reply-To: <87shb1de4a.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com

On Fri, Jan 19, 2018 at 10:09:41AM -0600, Eric W. Biederman wrote:
> Ram Pai <linuxram@us.ibm.com> writes:
> 
> > Currently the  architecture  specific code is expected to
> > display  the  protection  keys  in  smap  for a given vma.
> > This can lead to redundant code and possibly to divergent
> > formats in which the key gets displayed.
> >
> > This  patch  changes  the implementation. It displays the
> > pkey only if the architecture support pkeys.
> >
> > x86 arch_show_smap() function is not needed anymore.
> > Delete it.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> >  arch/x86/kernel/setup.c |    8 --------
> >  fs/proc/task_mmu.c      |   11 ++++++-----
> >  2 files changed, 6 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 8af2e8d..ddf945a 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1326,11 +1326,3 @@ static int __init register_kernel_offset_dumper(void)
> >  	return 0;
> >  }
> >  __initcall(register_kernel_offset_dumper);
> > -
> > -void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> > -{
> > -	if (!boot_cpu_has(X86_FEATURE_OSPKE))
> > -		return;
> > -
> > -	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > -}
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 0edd4da..4b39a94 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/page_idle.h>
> >  #include <linux/shmem_fs.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/pkeys.h>
> >  
> >  #include <asm/elf.h>
> >  #include <asm/tlb.h>
> > @@ -728,10 +729,6 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
> >  }
> >  #endif /* HUGETLB_PAGE */
> >  
> > -void __weak arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
> > -{
> > -}
> > -
> >  static int show_smap(struct seq_file *m, void *v, int is_pid)
> >  {
> >  	struct proc_maps_private *priv = m->private;
> > @@ -851,9 +848,13 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
> >  			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
> >  
> >  	if (!rollup_mode) {
> > -		arch_show_smap(m, vma);
> > +#ifdef CONFIG_ARCH_HAS_PKEYS
> > +		if (arch_pkeys_enabled())
> > +			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > +#endif
> 
> Would it be worth it making vma_pkey a noop on architectures that don't
> support protection keys so that we don't need the #ifdef here?

You mean something like this?
	#define vma_pkey(vma)  
It will lead to compilation error.


I can make it
	#define vma_pkey(vma)  0

and that will work and get rid of the #ifdef

RP
