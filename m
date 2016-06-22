From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Wed, 22 Jun 2016 23:05:59 +0200
Message-ID: <20160622210559.GX30909@twins.programming.kicks-ass.net>
References: <f43656af-050c-82b3-e10d-66be072be320@mellanox.com>
 <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
 <20160621185048.GR30909@twins.programming.kicks-ass.net>
 <3813680.TbHyagWbHe@wuerfel>
 <cea1e8b0-f0ca-7985-39f5-b66cfed50a9a@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48049 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbcFVVGT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2016 17:06:19 -0400
Content-Disposition: inline
In-Reply-To: <cea1e8b0-f0ca-7985-39f5-b66cfed50a9a@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Jun 22, 2016 at 04:43:15PM -0400, Chris Metcalf wrote:
> It turns out there were a few places where we were #include'ing Linux
> headers in the gcc build (asm/unistd.h, arch/icache.h, arch/spr_def.h).
> I patched gcc to provide inline copies of what was needed (pretty simple
> stuff and won't ever change) and asked our lead compiler guy to upstream
> it back up to gcc, so using buildall.git should get easier for tilepro/tilegx.

tilegx actually built without issue (although I think it needed
--disable-gdb for binutils).

But thanks! Much appreciated.

I'll try and make a few patches for Segher to update buildall and reduce
the number of hacks/patches I have to carry around on that.
