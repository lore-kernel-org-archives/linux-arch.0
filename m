From: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Wed, 23 Apr 2008 11:40:38 -0400
Message-ID: <20080423154038.GL19802@phobos.i.cabal.ca>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422081211.e85989ec.randy.dunlap@oracle.com> <87a5b0800804220816y72a7f4f9gec2111df08a1a57f@mail.gmail.com> <20080422152426.GG19802@phobos.i.cabal.ca> <87a5b0800804220834q4d6daec1x4146d211115ab5c@mail.gmail.com> <20080422153849.GH19802@phobos.i.cabal.ca> <87a5b0800804230736k340e7fe9mffbd72b5b8164015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87a5b0800804230736k340e7fe9mffbd72b5b8164015-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Apr 23, 2008 at 03:36:23PM +0100, Will Newton wrote:
> +config ARCH_HAS_SYS_SYSFS
> +	bool
> +	default y
> +
>  source "init/Kconfig"
> 

Sorry, I meant something more like

config ARCH_HAS_SYS_SYSFS
	def_bool !BLACKFIN
	help
	  Obsolete sys_sysfs syscall

in init/Kconfig

But, it's your patch, you can do it however you like. :)

regards, Kyle
