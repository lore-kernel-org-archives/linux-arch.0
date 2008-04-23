From: "Will Newton" <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 16:50:36 +0100
Message-ID: <87a5b0800804230850y4d577ff2taf1689f4af26b274@mail.gmail.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
	 <20080422081211.e85989ec.randy.dunlap@oracle.com>
	 <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com>
	 <20080422152426.GG19802@phobos.i.cabal.ca>
	 <87a5b0800804220834q4d6daec1x4146d211115ab5c@mail.gmail.com>
	 <20080422153849.GH19802@phobos.i.cabal.ca>
	 <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
	 <20080423154038.GL19802@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080423154038.GL19802-EK4dZfYtfFRW/gs8oUvUg/d9D2ou9A/h@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Cc: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Apr 23, 2008 at 4:40 PM, Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org> wrote:
> On Wed, Apr 23, 2008 at 03:36:23PM +0100, Will Newton wrote:
>  > +config ARCH_HAS_SYS_SYSFS
>  > +     bool
>  > +     default y
>  > +
>  >  source "init/Kconfig"
>  >
>
>  Sorry, I meant something more like
>
>
>  config ARCH_HAS_SYS_SYSFS
>         def_bool !BLACKFIN
>         help
>           Obsolete sys_sysfs syscall
>
>  in init/Kconfig
>
>  But, it's your patch, you can do it however you like. :)

That's definitely shorter - but it feels a bit more like #ifdef
CONFIG_BLACKFIN which is explicitly what I don't want to do, because
I'm not actually interested in blackfin. ;-)
