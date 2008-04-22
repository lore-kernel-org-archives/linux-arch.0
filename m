From: "Will Newton" <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 16:16:17 +0100
Message-ID: <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <20080422081211.e85989ec.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422081211.e85989ec.randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Apr 22, 2008 at 4:12 PM, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, 22 Apr 2008 13:13:39 +0100 Will Newton wrote:
>
>  > Hi,
>  >
>  > This patch introduces a __ARCH_WANT_SYS_SYSFS #define for
>  > architectures that support the sysfs(2) system call. At the moment
>  > that's everybody but blackfin, but future architectures may want to
>  > save the (admittedly small) code size that it adds to the kernel as
>  > well.
>  >
>  > (patch attached as well as inline because gmail seems to mangle my whitespace)
>  >
>  > ---
>  > >From d0746366e8ccb5fbaa6c9945540cecbe0c421222 Mon Sep 17 00:00:00 2001
>  > From: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>  > Date: Tue, 22 Apr 2008 12:57:03 +0100
>  > Subject: [PATCH] Introduce __ARCH_WANT_SYS_SYSFS.
>  >
>  > Signed-off-by: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>  >
>  > All arches that want the sysfs(2) system call should define this symbol.
>  > Arches such as blackfin that do not implement the system call don't compile
>  > the code and save some small amount of space.
>
>  Is there any reason that this couldn't (and shouldn't) be done
>  in the Kconfig space and done as documented in
>  Documentation/kbuild/kconfig-language.txt ?

It can be done with Kconfig. Whether it should be or not depends on
your point of view, hence RFC. Currently __ARCH_WANT macros is the way
syscalls are enabled and disabled across architectures. If there's
consensus that it should be done via Kconfig that could certainly be
implmented, but that's a different patch.
