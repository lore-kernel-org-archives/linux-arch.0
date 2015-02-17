Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:54336 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752058AbbBQJqY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Feb 2015 04:46:24 -0500
Message-ID: <1424166381.7082.27.camel@x220>
Subject: Re: [PATCH v3 10/15] h8300: Build scripts
From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 17 Feb 2015 10:46:21 +0100
In-Reply-To: <87vbj1kmvy.wl-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
	 <1423986573-2329-11-git-send-email-ysato@users.sourceforge.jp>
	 <1424028184.9418.99.camel@x220> <87vbj1kmvy.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150217094621.DsCrpm7j0JGl8gBcXjVT-rNyhnjfW_a6M5lID6sI880@z>

On Tue, 2015-02-17 at 16:39 +0900, Yoshinori Sato wrote:
> At Sun, 15 Feb 2015 20:23:04 +0100,
> Paul Bolle wrote:
> > On Sun, 2015-02-15 at 16:49 +0900, Yoshinori Sato wrote:
> > > diff --git a/arch/h8300/Kconfig.debug b/arch/h8300/Kconfig.debug
> > > new file mode 100644
> > > index 0000000..eb72b01
> > > --- /dev/null
> > > +++ b/arch/h8300/Kconfig.debug
> > > @@ -0,0 +1,23 @@
> > > +menu "Kernel hacking"
> > > +
> > > +source "lib/Kconfig.debug"
> > > +
> > > +config FULLDEBUG
> > > +	bool "Full Symbolic/Source Debugging support"
> > > +	help
> > > +	  Enable debugging symbols on kernel build.
> > > +
> > > +config HIGHPROFILE
> > > +	bool "Use fast second timer for profiling"
> > > +	help
> > > +	  Use a fast secondary clock to produce profiling information.
> > > +
> > > +config NO_KERNEL_MSG
> > > +	bool "Suppress Kernel BUG Messages"
> > > +	help
> > > +	  Do not output any debug BUG messages within the kernel.
> > > +
> > > +config SH_STANDARD_BIOS
> > > +       def_bool n
> > > +
> > 
> > I don't think this entry is needed.
> 
> This entry using sh-sci. 

This entry will always set SH_STANDARD_BIOS to 'n', and a line reading
    # CONFIG_SH_STANDARD_BIOS is not set

will always be included in the generated .config for h8300. But for the
three lines in drivers/tty/serial/sh-sci.c reading
    #ifdef CONFIG_SH_STANDARD_BIOS
            sh_bios_gdb_detach();
    #endif

that line has no effect. Even if there's no entry for SH_STANDARD_BIOS
the preprocessor will still remove that call of sh_bios_gdb_detach().

> > > +endmenu

Thanks,


Paul Bolle

