Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34688 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751004AbWIOKgy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 06:36:54 -0400
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.62.0609151000480.4692@pademelon.sonytel.be>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
	 <Pine.LNX.4.62.0609151000480.4692@pademelon.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 11:58:36 +0100
Message-Id: <1158317916.29932.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, spyro@f2s.com, tony.luck@intel.com, Roman Zippel <zippel@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>

Ar Gwe, 2006-09-15 am 10:06 +0200, ysgrifennodd Geert Uytterhoeven:
> The same can be said about not initializing local variables, using delete vs.
> delete [], ...: sometimes it works, sometimes it fails. It's still an
> application bug to rely on `may' behavior.

And as a result programmers have to resort to tools like valgrind. Even
valgrind can't save you in this case and AFAIK there is no debugging
tool for this problem.

Programming is *hard* (correct programming), don't make it any harder
when it is easy to make it more predictable. Murphy's law says that the
user who hits the actual bug will be on the other side of the globe,
busy and not speak the same language...

Alan

