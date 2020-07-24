From: Sean Christopherson <sean.j.christopherson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Date: Thu, 23 Jul 2020 21:50:59 -0700
Message-ID: <20200724045059.GN21891@linux.intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200723162531.GF21891@linux.intel.com>
 <2e9806a3-7485-a0d0-b63d-f112fcff954c@intel.com>
 <20200723165649.GG21891@linux.intel.com>
 <f38b5b34-8432-9531-01b5-d0ae924ffafe@intel.com>
 <d15816d6172ea770b63e52443aced5607f1e35c1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d15816d6172ea770b63e52443aced5607f1e35c1.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 23, 2020 at 08:40:33PM -0700, Yu-cheng Yu wrote:
> On Thu, 2020-07-23 at 11:41 -0700, Dave Hansen wrote:
> > On 7/23/20 9:56 AM, Sean Christopherson wrote:
> > > On Thu, Jul 23, 2020 at 09:41:37AM -0700, Dave Hansen wrote:
> > > > On 7/23/20 9:25 AM, Sean Christopherson wrote:
> > > > > How would people feel about taking the above two patches (02 and 03 in the
> > > > > series) through the KVM tree to enable KVM virtualization of CET before the
> > > > > kernel itself gains CET support?  I.e. add the MSR and feature bits, along
> > > > > with the XSAVES context switching.  The feature definitons could use "" to
> > > > > suppress displaying them in /proc/cpuinfo to avoid falsely advertising CET
> > > > > to userspace.
> > > > > 
> > > > > AIUI, there are ABI issues that need to be sorted out, and that is likely
> > > > > going to drag on for some time. 
> > > > > 
> > > > > Is this a "hell no" sort of idea, or something that would be feasible if we
> > > > > can show that there are no negative impacts to the kernel?
> > > > Negative impacts like bloating every task->fpu with XSAVE state that
> > > > will never get used? ;)
> > > Gah, should have qualified that with "meaningful or measurable negative
> > > impacts".  E.g. the extra 40 bytes for CET XSAVE state seems like it would
> > > be acceptable overhead, but noticeably increasing the latency of XSAVES
> > > and/or XRSTORS would not be acceptable.
> > 
> > It's 40 bytes, but it's 40 bytes of just pure, unadulterated waste.  It
> > would have no *chance* of being used.  It's also quite precisely
> > measurable on a given system:
> > 
> > 	cat /proc/slabinfo | grep task_struct | awk '{print $3 * 40}'
> 
> If there is value in getting these two patches merged first, we can move
> XFEATURE_MASK_CET_USER to XFEATURE_MASK_SUPERVISOR_UNSUPPORTED for now, until
> CET is eventually merged.  That way, there is no space wasted.

Merging them as disabled wouldn't help, KVM needs the features enabled so
that context switching the guest state works as expected. 
