Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:19689 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932196AbWGDNXl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Jul 2006 09:23:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Tue, 4 Jul 2006 17:23:32 +0200
References: <1151670404.11575.5.camel@localhost> <200607041442.03913.arnd@arndb.de> <Pine.LNX.4.62.0607041507350.13355@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0607041507350.13355@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041723.33550.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Matthew Wilcox <matthew@wil.cx>, schwidefsky@de.ibm.com, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 04 July 2006 15:08, Geert Uytterhoeven wrote:
> So why aren't readb() and friends in <asm/io.h> empty defines?

That's a bug, they should be ;-)
