Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:28310 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932464AbWH1Hqs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Aug 2006 03:46:48 -0400
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200608280941.10965.arnd@arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
	 <20060827215637.555365000@klappe.arndb.de> <p73ac5pe2iy.fsf@verdi.suse.de>
	 <200608280941.10965.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 09:46:17 +0200
Message-Id: <1156751177.3034.158.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-08-28 at 09:41 +0200, Arnd Bergmann wrote:
> On Monday 28 August 2006 09:35, Andi Kleen wrote:
> > I would prefer to keep them on i386/x86-64 at least because
> > a lot of my test programs are using them.
> > 
> Hmm, maybe we should have an asm-generic/unistd.h then
> containing something like


we or the (g)libc headers ?



