Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 30 Jun 2005 10:42:55 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task
Message-ID: <20050630084255.GC13890@bragg.suse.de>
References: <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk> <20050628.134736.45885284.davem@davemloft.net> <20050629164127.58e97376.sfr@canb.auug.org.au> <20050629121228.GH21575@bragg.suse.de> <20050630175741.0fba8049.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630175741.0fba8049.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Jun 30, 2005 at 05:57:41PM +1000, Stephen Rothwell wrote:
> On Wed, 29 Jun 2005 14:12:28 +0200 Andi Kleen <ak@suse.de> wrote:
> >
> > I think for the particular input case it would be still better
> > to just define ->compat_write at the VFS level.
> > 
> > This would require a new compat_sys_write() wrapper, but that would
> > be straight forward.
> 
> You mean something like this?

Yes, but ...

>  
> -ssize_t vfs_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
> +static ssize_t do_vfs_write(struct file *file, const char __user *buf,
> +		size_t count, loff_t *pos, int compat)

Instead of the flag I would move the code figuring out the call vector
into the caller.

-Andi
