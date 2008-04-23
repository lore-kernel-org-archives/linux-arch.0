From: "Mike Frysinger" <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 13:59:05 -0400
Message-ID: <8bd0f97a0804231059w76592878s3f6bf4a488b3ddea@mail.gmail.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <20080422081211.e85989ec.randy.dunlap@oracle.com>
	 <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
	 <20080422152426.GG19802@phobos.i.cabal.ca>
	 <87a5b0800804220834q4d6daec1x4146d211115ab5c@mail.gmail.com>
	 <20080422153849.GH19802@phobos.i.cabal.ca>
	 <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
	 <20080423154038.GL19802@phobos.i.cabal.ca>
	 <87a5b0800804230850y4d577ff2taf1689f4af26b274@mail.gmail.com>
	 <8bd0f97a0804230905x19fd96aevc8f225d241e59369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8bd0f97a0804230905x19fd96aevc8f225d241e59369-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Apr 23, 2008 at 12:05 PM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, Apr 23, 2008 at 11:50 AM, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>  > On Wed, Apr 23, 2008 at 4:40 PM, Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org> wrote:
>  >  > On Wed, Apr 23, 2008 at 03:36:23PM +0100, Will Newton wrote:
>  >  >  > +config ARCH_HAS_SYS_SYSFS
>  >  >  > +     bool
>  >  >  > +     default y
>  >  >  > +
>  >  >  >  source "init/Kconfig"
>  >  >  >
>  >  >
>  >  >  Sorry, I meant something more like
>  >  >
>  >  >
>  >  >  config ARCH_HAS_SYS_SYSFS
>  >  >         def_bool !BLACKFIN
>  >  >         help
>  >  >           Obsolete sys_sysfs syscall
>  >  >
>  >  >  in init/Kconfig
>  >  >
>  >  >  But, it's your patch, you can do it however you like. :)
>  >
>  >  That's definitely shorter - but it feels a bit more like #ifdef
>  >  CONFIG_BLACKFIN which is explicitly what I don't want to do, because
>  >  I'm not actually interested in blackfin. ;-)
>
>  i'd have to agree that updating asm/unistd.h fits better with existing
>  paradigm.  if we want to talk about converting *all cases* to Kconfig,
>  we can do it in a separate thread.  splitting the design between two
>  different files is simply confusing to everyone involved as they spend
>  their time going "well which way am *i* supposed to do it".

thinking about this some more ... we actually have three choices here,
not just two.  checksyscalls.sh introduced a new form in asm/unistd.h:
#define __IGNORE_sysfs
perhaps we should be unifying the __ARCH_WANT_XXX and the __IGNORE_XXX
-mike
