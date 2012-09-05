From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [patch 0/3] Turn CONFIG_HOTPLUG always on.
Date: Tue,  4 Sep 2012 17:01:05 -0700
Message-ID: <20120904234803.554552301@clark.kroah.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65016 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2IEABY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Sep 2012 20:01:24 -0400
Received: by dady13 with SMTP id y13so4738848dad.19
        for <linux-arch@vger.kernel.org>; Tue, 04 Sep 2012 17:01:23 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Zankel <chris@zankel.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>

The CONFIG_HOTPLUG variable is tough to turn off, and almost all arches
default to it on.

If you turn it off, it saves you a big 200 or so bytes, and then starts
to cause all sorts of problems as the code paths if the option is
disabled is never really tested, and memory segments start to get thrown
away that driver authors assume will always be present.

So, as part of trying to get rid of the option entirely, let's just turn
the option always on.

Note, to do this properly, I found two duplicate definitions of the
option, in the Tile and Xtensa arch files, this patch series removes
those duplicates first.

Anyone object to me just taking these three patches through my
driver-core tree for 3.7?  After this set, I'll start unwinding the
places where CONFIG_HOTPLUG is used and remove the parts that are not
used anymore now that the option can not be turned off.

thanks,

greg k-h
