From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] asm-generic: default BUG_ON(x) to "if(x) BUG()"
Date: Mon, 23 Nov 2015 16:37:50 +0000
Message-ID: <20151123163750.GT8644@n2100.arm.linux.org.uk>
References: <5868782.RxZY0W5S4d@wuerfel>
 <20151123163359.GC768@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:50519 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbKWQh4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2015 11:37:56 -0500
Content-Disposition: inline
In-Reply-To: <20151123163359.GC768@1wt.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, josh@joshtriplett.org

On Mon, Nov 23, 2015 at 05:33:59PM +0100, Willy Tarreau wrote:
> I think you could do better by simply calling panic("BUG!") instead as
> BUG() does. It will avoid the printk() call and pushing the file/line
> number onto the stack. It will also probably not inflate the rodata this
> way.

Does that not depend on the architectures BUG() implementation?  If an
architecture implements it as a signalling illegal instruction and a
lookup table, changing it to be a panic() would probably be more code.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
