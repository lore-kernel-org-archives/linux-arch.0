Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 23 Mar 2005 14:51:32 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] consolidate shmat usage
Message-ID: <20050323145132.GJ21986@parcelfarce.linux.theplanet.co.uk>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au> <20050323174810.17df4440.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323174810.17df4440.sfr@canb.auug.org.au>
Sender: <willy@www.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Mar 23, 2005 at 05:48:10PM +1100, Stephen Rothwell wrote:
> This patch creates sys_shmat and sys_smhatcall and uses them wherever possible - this tidies up sys_ipc a bit in most cases.  I have not touched um arch.

The concept is great, but I'd quibble over the details ...

> I am eventually aiming at consolidating (as much as possible of) sys_ipc
> and doing compat_sys_ipc.

Great, but please remember not all architectures have a sys_ipc (looks like
alpha, ia64, parisc and x86_64 according to a fairly recent version of glibc).

> +++ linus-compat_sys_ipc.2/arch/parisc/kernel/sys_parisc.c	2005-03-23 16:41:53.000000000 +1100
> @@ -163,13 +163,7 @@
>  
>  long sys_shmat_wrapper(int shmid, char __user *shmaddr, int shmflag)
>  {
> -	unsigned long raddr;
> -	int r;
> -
> -	r = do_shmat(shmid, shmaddr, shmflag, &raddr);
> -	if (r < 0)
> -		return r;
> -	return raddr;
> +	return sys_shmatcall(shmid, shmaddr, shmflag);
>  }

I don't see the need for a wrapper function in sys_parisc.c -- would
make sense to just call the sys_shmatcall() directly.  I suspect the same
goes for Alpha's osf_shmat() function.

> diff -ruN linus-compat_sys_ipc.1/ipc/shm.c linus-compat_sys_ipc.2/ipc/shm.c
> --- linus-compat_sys_ipc.1/ipc/shm.c	2005-03-18 04:08:16.000000000 +1100
> +++ linus-compat_sys_ipc.2/ipc/shm.c	2005-03-23 17:18:28.000000000 +1100
> +asmlinkage long sys_shmat(int shmid, char __user *shmaddr, int shmflg,
> +		unsigned long __user *addr)
> +asmlinkage long sys_shmatcall(int shmid, char __user *shmaddr, int shmflg)
> +{
> +	ulong raddr;
> +	long ret;
> +
> +	ret = do_shmat(shmid, shmaddr, shmflg, &raddr);
> +	return ret ? ret : raddr;
> +}

I dislike the naming here.  The manpage for shmat is the three-argument
version.  The only reason we have the four-argument version is because
of the silly sys_ipc multiplexer.  So I think sys_shmat() should be
the three-argument form and we should rename the existing sys_shmat()
to something like ipc_shmat().  Does it need to be asmlinkage?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
