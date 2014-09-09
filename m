From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: bit fields && data tearing
Date: Tue, 09 Sep 2014 10:11:39 +0200
Message-ID: <2998968.X0xyWHN7fU@wuerfel>
References: <21512.10628.412205.873477@gargle.gargle.HOWL> <1410216228.2027.88.camel@jarvis.lan> <540E6582.9020403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56748 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbaIIIMS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Sep 2014 04:12:18 -0400
In-Reply-To: <540E6582.9020403@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Chris Metcalf <cmetcalf@tilera.com>, Peter Hurley <peter@hurleysoftware.com>, paulmck@linux.vnet.ibm.com, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jakub Jelinek <jakub@redhat.com>, Mikael Pettersson <mikpelinux@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Richard Henderson <rth@twiddle.net>, Oleg Nesterov <oleg@redhat.com>, Miroslav Franc <mfranc@redhat.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org

On Monday 08 September 2014 19:27:14 H. Peter Anvin wrote:
> On 09/08/2014 03:43 PM, James Bottomley wrote:
> > 
> > This was years ago (possibly decades).  We had to implement in-kernel
> > unaligned traps for the networking layer because it could access short
> > and int fields that weren't of the correct alignment when processing
> > packets.  It that's all corrected now, we wouldn't really notice (except
> > a bit of a speed up since an unaligned trap effectively places the
> > broken out instructions into the bit stream).

I believe the current line of thinking is to consider it a bug in
the device driver. Those bugs may still exist in some rare legacy
drivers, but anything you'd see in practice should not require unaligned
access any more.

> Well, ARM doesn't trap, it just silently gives garbage on unaligned
> memory references.

ARMv6/v7 (anything that really matters these days) has efficient unaligned
accesses that work. Older CPUs are normally set to trap on unaligned
access, originally for the reason James mentions above, but there are
some even older machines that rely on abusing unaligned accesses to do
byte swapping.

	Arnd
