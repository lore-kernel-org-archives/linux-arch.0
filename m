From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 16:34:49 +0000
Message-ID: <20151123163449.GS8644@n2100.arm.linux.org.uk>
References: <5868782.RxZY0W5S4d@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:50504 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbbKWQe5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 11:34:57 -0500
Content-Disposition: inline
In-Reply-To: <5868782.RxZY0W5S4d@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, josh@joshtriplett.org

On Mon, Nov 23, 2015 at 05:25:28PM +0100, Arnd Bergmann wrote:
> This patch picks the second choice, and changes the NOP to BUG(), which
> normally stops the execution of the current thread in some form (endless
> loop or a trap). This follows the logic we applied in a4b5d580e078 ("bug:
> Make BUG() always stop the machine").

I think this is a very good thing.  It changes things from "something went
wrong, we'll silently continue as if nothing happened and possibly corrupt
your data" to "something went wrong, halt or reboot the system" (depending
on the config choices and kernel configuration.)

IMHO, for a closed box device, the latter has _always_ got to be better
than the former.

I think people who argue against this forget that BUG() is only supposed
to be used when a serious error which results in data corruption has
occurred.  It isn't a general purpose reimplementation of userspace
assert(), which commonly gets used by programmers as a subsitute for
proper error handling.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
