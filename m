Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 23 Feb 2005 00:36:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Consolidate compat_sys_waitid
Message-Id: <20050223003651.115d05ef.sfr@canb.auug.org.au>
In-Reply-To: <20050218162229.63d69935.sfr@canb.auug.org.au>
References: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
	<20050215184307.GQ29917@parcelfarce.linux.theplanet.co.uk>
	<20050218162229.63d69935.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: matthew@wil.cx
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 18 Feb 2005 16:22:29 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Tue, 15 Feb 2005 18:43:07 +0000 Matthew Wilcox <matthew@wil.cx> wrote:
> >
> > On Tue, Feb 15, 2005 at 02:01:49PM +1100, Stephen Rothwell wrote:
> > 
> > > +asmlinkage long compat_sys_waitid(u32 which, u32 pid,
> > > +		struct compat_siginfo __user *uinfo, u32 options,
> > > +		struct compat_rusage __user *uru)
> > 
> > Some subtle differences which I feel incompetent to diagnose ... ours
> > looks like:
> > 
> > asmlinkage int compat_sys_waitid(int which, pid_t pid,
> >                                  compat_siginfo_t __user *infop, int options,
> >                                  struct compat_rusage __user *ru)
> 
> They are u32 in my version because we decided that the kernel zero extends
> the compat syscall parameters.

On second thoughts, I think we should be more consistent with other
compat_sys_ routines.  New patch following.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
