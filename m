From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
Date: Fri, 21 Mar 2008 15:10:51 +0100
Message-ID: <20080321141051.GA27591@uranus.ravnborg.org>
References: <20080319211714.8B14226F995@magilla.localdomain> <20080319212024.EA03126F995@magilla.localdomain> <alpine.LFD.1.00.0803191935080.3020@woody.linux-foundation.org> <20080320081658.0B23826F995@magilla.localdomain> <alpine.LFD.1.00.0803211441180.3781@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803211441180.3781@apollo.tec.linutronix.de>
Sender: linux-ia64-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Richard Henderson <rth@twiddle.net>, tony.luck@intel.com, linux-ia64@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 21, 2008 at 02:50:01PM +0100, Thomas Gleixner wrote:
> On Thu, 20 Mar 2008, Roland McGrath wrote:
> > > Wouldn't it be nicer to just let "arch_ptrace()" return a flag saying 
> > > whether it handled things or not?
> > 
> > It would certainly be nicer.  I would prefer:
> > 
> > extern int arch_ptrace(struct task_struct *child, long request,
> >        	    	       long addr, long data, long *retval);
> > 
> > where it returns an error code or it returns 0 and *retval is the value
> > or it returns 1 and it didn't do anything.
> >
> > So this ugliness seemed like a better bet than waiting for 20 more
> > arch sign-offs before any of it could go in.  You are certainly in a
> > position to just change the generic signature and make every arch do
> > the update (or fix your typos if you just tweak them all blind), and
> > let them grumble.  I did not presume to do so.
> 
> What about adding a CONFIG_ARCH_HAS_PTRACE2, which is set by the archs
> which are converted. For those which are not you add a fallback
> implementation:

HAVE_PTRACE2 or at least following the HAVE_* semnatic.
And then do:

config HAVE_PTRACE2
	def_bool n

In some common file.
Then arch files can do:
 config X86
	...
+	select HAVE_PTRACE2

	Sam
