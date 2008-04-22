From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 08:12:11 -0700
Message-ID: <20080422081211.e85989ec.randy.dunlap@oracle.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87a5b0800804220513t75690ceao938a288596b5ad0c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 22 Apr 2008 13:13:39 +0100 Will Newton wrote:

> Hi,
> 
> This patch introduces a __ARCH_WANT_SYS_SYSFS #define for
> architectures that support the sysfs(2) system call. At the moment
> that's everybody but blackfin, but future architectures may want to
> save the (admittedly small) code size that it adds to the kernel as
> well.
> 
> (patch attached as well as inline because gmail seems to mangle my whitespace)
> 
> ---
> >From d0746366e8ccb5fbaa6c9945540cecbe0c421222 Mon Sep 17 00:00:00 2001
> From: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Date: Tue, 22 Apr 2008 12:57:03 +0100
> Subject: [PATCH] Introduce __ARCH_WANT_SYS_SYSFS.
> 
> Signed-off-by: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> 
> All arches that want the sysfs(2) system call should define this symbol.
> Arches such as blackfin that do not implement the system call don't compile
> the code and save some small amount of space.

Is there any reason that this couldn't (and shouldn't) be done
in the Kconfig space and done as documented in
Documentation/kbuild/kconfig-language.txt ?

<quote:>
Adding common features and make the usage configurable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
It is a common idiom to implement a feature/functionality that are
relevant for some architectures but not all.
The recommended way to do so is to use a config variable named HAVE_*
that is defined in a common Kconfig file and selected by the relevant
architectures.
An example is the generic IOMAP functionality.

We would in lib/Kconfig see:

# Generic IOMAP is used to ...
config HAVE_GENERIC_IOMAP

config GENERIC_IOMAP
	depends on HAVE_GENERIC_IOMAP && FOO

And in lib/Makefile we would see:
obj-$(CONFIG_GENERIC_IOMAP) += iomap.o

For each architecture using the generic IOMAP functionality we would see:

config X86
	select ...
	select HAVE_GENERIC_IOMAP
	select ...



---
~Randy
