From: "J. Bruce Fields" <bfields-uC3wQj2KruNg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] All Arch: remove linkage for sys_nfsservctl system call
Date: Fri, 26 Aug 2011 19:52:01 -0400
Message-ID: <20110826235201.GD18699@fieldses.org>
References: <1312810169.2591.1153.camel@deadeye>
 <20110808155538.GB904@fieldses.org>
 <20110808180658.GC29924@decadent.org.uk>
 <20110826220311.GA18140@fieldses.org>
 <20110826233258.GE24107@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110826233258.GE24107-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Neil Brown <neilb-l3A5Bk7waGM@public.gmane.org>, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 27, 2011 at 12:32:58AM +0100, Ben Hutchings wrote:
> On Fri, Aug 26, 2011 at 06:03:11PM -0400, J. Bruce Fields wrote:
> [...]
> > diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
> > index f566518..c9296ab 100644
> > --- a/arch/sparc/kernel/systbls_64.S
> > +++ b/arch/sparc/kernel/systbls_64.S
> > @@ -145,7 +145,7 @@ sys_call_table:
> >  	.word sys_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
> >  /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
> >  	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys_sched_rr_get_interval, sys_nanosleep
> > -/*250*/	.word sys_64_mremap, sys_sysctl, sys_getsid, sys_fdatasync, sys_nfsservctl
> > +/*250*/	.word sys_64_mremap, sys_sysctl, sys_getsid, sys_fdatasync, sys_nis_syscall
> [...]
>           	                                                                  ^
> This seems to be a typo for 'sys_ni_syscall'.

Is it?  On a quick skim, both seem to occur.  sys_nis_syscall seems to
point to c_sys_nis_syscall(), which prints a warning and returns
-ENOSYS.  I can't tell what sys_ni_syscall does.

--b.
--
To unsubscribe from this list: send the line "unsubscribe linux-nfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
