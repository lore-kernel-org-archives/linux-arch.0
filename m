From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 14:52:12 +0100
Message-ID: <20160812135212.GZ1041@n2100.armlinux.org.uk>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk>
 <20160812231503.3e2e059b@roar.ozlabs.ibm.com>
 <CAKv+Gu-Ek0NEPP9f2Jp+3ZxwRAP8rqPwwwRa56b2Bz4i=7h=Jw@mail.gmail.com>
 <CAKv+Gu_vmpg5ks4hPRYhJGEDBxy4oQW6wDGu1fjKSzEwW7y2uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33863 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbcHLNwU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2016 09:52:20 -0400
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_vmpg5ks4hPRYhJGEDBxy4oQW6wDGu1fjKSzEwW7y2uw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Aug 12, 2016 at 03:50:17PM +0200, Ard Biesheuvel wrote:
> $ objdump -dr vmlinux |grep -A1 -E \\sb\.w |less
> 
> I get numerous instances of b.w that are not covered by any
> relocations, so i assume that will be the case for modules as well.

Not surprising.  vmlinux is fully linked.  There's no relocations.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
