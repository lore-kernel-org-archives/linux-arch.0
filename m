Return-Path: <ak@suse.de>
Received: from cantor.suse.de ([195.135.220.2]:47576 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261179AbUEQMmr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 May 2004 08:42:47 -0400
Date: Mon, 17 May 2004 14:39:40 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Allow arch override for kmem_bufctl_t
Message-ID: <20040517123940.GB27281@wotan.suse.de>
References: <40A60984.1070202@colorfullife.com> <Pine.GSO.4.58.0405171111300.19405@waterleaf.sonytel.be> <20040517153952.A11307@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517153952.A11307@jurassic.park.msu.ru>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@digeo.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 17, 2004 at 03:39:52PM +0400, Ivan Kokshaysky wrote:
> On Mon, May 17, 2004 at 11:11:59AM +0200, Geert Uytterhoeven wrote:
> > 16-bit is no problem for m68k, so feel free to switch it.
> 
> Ditto for Alpha.

x86_64 has no problems with 16 bit neither.

-Andi
