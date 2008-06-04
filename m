From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:47:14 +0100
Message-ID: <20080604124714.55dbce65@core>
References: <1211852026.3286.36.camel@pasglop>
	<Pine.LNX.4.64.0806031130130.3242@t2.domain.actdsltmp>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806041205.45833.nickpiggin@yahoo.com.au>
	<alpine.LFD.1.10.0806031932370.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760727AbYFDMDT@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806031932370.3473@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Trent Piepho <tpiepho@freescale.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> Anyway, Intel certainly seems to document that WC memory is serialize=
d by=20
> any access to UC memory.

I don't believe that is actually true on Pentium Pro at least.

>   So what started out as a "we can do accesses to the frame buffer mo=
re=20
>   efficiently without anybody ever even having to know or care" has=20
>   turned into a whole nightmare of people using it for other things, =
and=20
>   then you very much _do_ have to care! ]

Notably graphics where 3Dfx lined the registers up specifically to make
this work. We were also using it with I=C2=B2O where it gave a small
performance gain.

Alan
