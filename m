Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 12 Jul 2005 21:19:42 +0000
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] net: add a top-level Networking menu to *config
Message-ID: <20050712211942.GA9972@mars.ravnborg.org>
References: <20050708003831.GB9883@mars.ravnborg.org> <20050708100211.5a1aebdf.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708100211.5a1aebdf.rdunlap@xenotime.net>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-arch@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

> 
> Hi Sam,
> 
> I tested this on 2.6.13-rc2, using menuconfig, xconfig, and
> gconfig, with various ARCH=arches.
Thanks!

> Looking good to me, but I have one small change request.
> 
> Can the NETPOLL options that are under
>   Networking support  + Networking options
> (that depend on NETCONSOLE) and the NETCONSOLE option that is under
>   Device Drivers + Network device support
> be moved to the same area?  I don't really care which area,
> but it's a hassle to have to move between them to enable/disable
> them.
I would be glad if you could do this patch. You have better net/
knowledge than I do - and now that Davem applied my patch it should be
a much less intrusive patch to rearrange net/Kconfig.
It would be fine if you could address some of the other inconsistencies
too.

	Sam
