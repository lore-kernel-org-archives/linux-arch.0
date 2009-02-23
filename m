From: "Carlos O'Donell" <carlos@systemhalted.org>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Sun, 22 Feb 2009 21:43:36 -0500
Message-ID: <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
References: <200902222252.45051.sf@sfritsch.de>
	 <20090222224924.GA13157@bombadil.infradead.org>
	 <20090223014224.GB13157@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-hppa=debian-hppa=m.gmane.org@lists.debian.org>
Sender: patofiero@gmail.com
In-Reply-To: <20090223014224.GB13157@bombadil.infradead.org>
Resent-Message-ID: <0mJPdg5jKmD.A.FJ.51goJB@liszt>
List-Post: <mailto:debian-hppa@lists.debian.org>
List-Help: <mailto:debian-hppa-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-hppa-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-hppa-request@lists.debian.org?subject=unsubscribe>
To: Kyle McMartin <kyle@infradead.org>
Cc: linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 22, 2009 at 8:42 PM, Kyle McMartin <kyle@infradead.org> wrote:
>> Definitely a kernel bug, if posix says it should return EWOULDBLOCK...

flock is not POSIX, it's an interface invented by 4.2BSD, and was
previously emulated by glibc. The glibc wrapper implemented flock with
fcntl and made sure to return EWOULDBLOCK.

> This is really going to suck, it looks like a lot of the locking
> primitives used EAGAIN and EWOULDBLOCK interchangeably... The fcntl
> manpage says 'EAGAIN or EWOULDBLOCK' so is flock(2) the only problem
> here? From a quick glance at posix, fcntl(2) returning EAGAIN is
> correct.

I would warn you that the linux man pages are often incorrect.

I use http://www.opengroup.org/onlinepubs/009695399/ for check POSIX
requirements.

> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
> index 71b3195..18e8542 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -156,6 +156,17 @@ asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
>
>  /* Fucking broken ABI */
>
> +asmlinkage long parisc_flock(unsigned int fd, unsigned int cmd)
> +{
> +       long ret;
> +
> +       ret = sys_flock(fd, cmd);
> +       if (ret == -EAGAIN)
> +               ret = -EWOULDBLOCK;     /* fuck you HPUX */

A more robust solution would be?

if ((ret == -EAGAIN) || (ret == -EWOULDBLOK))
        ret = -EWOULDBLOCK

This covers our ass since POSIX says that EAGAIN and EWOULDBLOCK *may*
be the same.

> but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
> is going to reveal latent problems in this part of the kernel I would
> rather not delve into...

The ABI is fixed, so all we can do is cleanup the uses in the kernel,
and make sure we adhere to the documented APIs.

Don't get too upset ;-)

Cheers,
Carlos.
