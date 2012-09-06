Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43242 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759828Ab2IFUav (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Sep 2012 16:30:51 -0400
Received: by dady13 with SMTP id y13so1318607dad.19
        for <linux-arch@vger.kernel.org>; Thu, 06 Sep 2012 13:30:51 -0700 (PDT)
Date: Thu, 6 Sep 2012 13:28:16 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 0/3] Turn CONFIG_HOTPLUG always on.
Message-ID: <20120906202815.GA6732@kroah.com>
References: <20120904234803.554552301@clark.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120904234803.554552301@clark.kroah.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20120906202816.qwyig5nEDs1bG3Zr4ShfO4oi6aWfrWqi20nQTrdERgU@z>

On Tue, Sep 04, 2012 at 05:01:05PM -0700, Greg Kroah-Hartman wrote:
> From: Greg KH <gregkh@linuxfoundation.org>
> 
> The CONFIG_HOTPLUG variable is tough to turn off, and almost all arches
> default to it on.
> 
> If you turn it off, it saves you a big 200 or so bytes, and then starts
> to cause all sorts of problems as the code paths if the option is
> disabled is never really tested, and memory segments start to get thrown
> away that driver authors assume will always be present.
> 
> So, as part of trying to get rid of the option entirely, let's just turn
> the option always on.
> 
> Note, to do this properly, I found two duplicate definitions of the
> option, in the Tile and Xtensa arch files, this patch series removes
> those duplicates first.
> 
> Anyone object to me just taking these three patches through my
> driver-core tree for 3.7?  After this set, I'll start unwinding the
> places where CONFIG_HOTPLUG is used and remove the parts that are not
> used anymore now that the option can not be turned off.

Given the lack of objection, I've now queued these up for 3.7 and will
start unwinding the CONFIG_HOTPLUG mess.

thanks,

greg k-h
