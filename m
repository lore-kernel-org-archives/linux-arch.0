From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Sat, 5 Mar 2016 12:42:29 +0100
Message-ID: <20160305114229.GB7259@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <CAB=NE6VFGUjDToW5zHgXOgfm9y77DGePe+mGAj=jvHEb8bHcGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34633 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbcCELme (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Mar 2016 06:42:34 -0500
Content-Disposition: inline
In-Reply-To: <CAB=NE6VFGUjDToW5zHgXOgfm9y77DGePe+mGAj=jvHEb8bHcGA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Toshi Kani <toshi.kani@hpe.com>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Julia Lawall <julia.lawall@lip6.fr>


* Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> On Fri, Mar 4, 2016 at 10:18 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> > On Fri, 2016-03-04 at 10:44 +0100, Ingo Molnar wrote:
> >> * Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> >>
> >> Could you outline a specific case where it's done intentionally - and the
> >> purpose behind that intention?
> >
> > The term "overlapping" is a bit misleading.
> 
> To the driver author its overlapping, its overlapping on the physical address.

Guys please stop this crazy talk - when the same physical address is mapped to 
multiple virtual addresses is called 'aliasing' - the term 'overlapping' is used 
when memory ranges overlap ...

Thanks,

	Ingo
