Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:34686 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbXFYJDZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 05:03:25 -0400
Subject: Re: [PATCH] cross-architecture ELF clean up
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070620230902.387008536@goop.org>
References: <20070620230854.246399397@goop.org>
	 <20070620230902.387008536@goop.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 10:02:46 +0100
Message-Id: <1182762166.12109.19.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Aubrey Li <aubrey.li@analog.com>, Mikael Starvik <starvik@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andi Kleen <ak@suse.de>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Matthew Wilcox <matthew@wil.cx>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Miles Bader <uclinux-v850@lsi.nec.co.jp>, Chris Zankel <chris@zankel.net>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-06-20 at 16:08 -0700, Jeremy Fitzhardinge wrote:
> This patch cleans up the ELF headers and their users.  It does several
> related things:

Looks good. We can get away with exporting a lot less of this to
userspace too, can't we?

-- 
dwmw2

