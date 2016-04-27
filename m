Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:53428 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbcD0KIe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2016 06:08:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: char: legacy RTC cleanups
Date: Wed, 27 Apr 2016 12:07:29 +0200
Message-ID: <4937900.aITlOE9vLo@wuerfel>
In-Reply-To: <20160427094410.GJ3264@piout.net>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <20160427094410.GJ3264@piout.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony.luck@intel.com, geert@linux-m68k.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, rth@twiddle.net, ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, x86@kernel.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org
Message-ID: <20160427100729.LnZFfDF5rHNlv15fN4LjVrzunxqO-CKrg71JTpPUC_4@z>

On Wednesday 27 April 2016 11:44:10 Alexandre Belloni wrote:
> On 26/04/2016 at 23:44:04 +0200, Arnd Bergmann wrote :
> > I've had these patches in my tree for a while, after the first one
> > had a few issues that are fixed in this new version. The old-style
> > PC RTC driver is now also disabled on m68k (as pointed out by
> > Geert), ppc (it was also blacklisted), and m32r (I showed that
> > it did not build).
> > 
> > For the genrtc driver, rearranging the headers makes it simpler
> > to use and reduces duplication. In case of alpha and mn10300,
> > I've shown that the genrtc and rtc drivers are doing the same
> > thing, so we don't need them both. The remaining three
> > architectures (m68k, parisc, powerpc) actually all support
> > the newer rtc-generic driver, so we could remove genrtc completely
> > if we want to.
> > 
> 
> Personally, I'd go for the kill and remove genrtc instead of cleaning it up.

Right, so we could skip patches 5 and 6, and instead remove the two
headers as we remove the driver. Let's see what the architecture
maintainers think about it, at least powerpc actually enables gen_rtc
in its defconfig, so it might take a while to move it over.

	Arnd
