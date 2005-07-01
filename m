Return-Path: <linux-arch-owner@vger.kernel.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050701145642.6a3d6542.sfr@canb.auug.org.au> 
References: <20050701145642.6a3d6542.sfr@canb.auug.org.au>  <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050628111828.GL5200@parcelfarce.linux.theplanet.co.uk> <20050628.134736.45885284.davem@davemloft.net> <20050629164127.58e97376.sfr@canb.auug.org.au> <20050629121228.GH21575@bragg.suse.de> <20050630175741.0fba8049.sfr@canb.auug.org.au> <20050630084255.GC13890@bragg.suse.de> <20050701003806.1de72653.sfr@canb.auug.org.au> <20050701012857.6b6de8f9.sfr@canb.auug.org.au> <20050630154904.GQ13890@bragg.suse.de> 
Subject: Re: [PATCH, for review 1/3] compat_sys_{read,write} 
Date: Fri, 01 Jul 2005 08:58:25 +0100
Message-ID: <9482.1120204705@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, davem@davemloft.net, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This patch introduces compatibility syscalls for read and write and the
> equivalent hooks in struct file_operations.  These are neede to support
> the badly designed (i.e. broken) input layer evdev read and write
> interfaces.

Should this also extend to the pread/pwrite syscalls?

> +asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf,
> +		size_t count)
> +{
> +	return do_sys_write(fd, buf, count, 0);
> +}

I think my biggest objection to this is that it'll stick another "frame" on
the stack. For something like this the compiler probably can't tail-call, at
least not on archs like i386 where the extra argument is passed on the stack.
For an arch that passes at least the first four arguments in registers, it
probably can, but I don't know that it will. Have you waved this in front of
any compiler hackers?

David
