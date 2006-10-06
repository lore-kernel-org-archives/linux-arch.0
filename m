Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48944 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932437AbWJFQV3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Oct 2006 12:21:29 -0400
Received: by ug-out-1314.google.com with SMTP id o38so342543ugd
        for <linux-arch@vger.kernel.org>; Fri, 06 Oct 2006 09:21:27 -0700 (PDT)
Message-ID: <d120d5000610060921q493a3f58n45285e6dcc037156@mail.gmail.com>
Date: Fri, 6 Oct 2006 12:21:27 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH, RAW] IRQ: Maintain irq number globally rather than passing to IRQ handlers
In-Reply-To: <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <4525A8D8.9050504@garzik.org>
	 <1160133932.1607.68.camel@localhost.localdomain>
	 <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu>
	 <45263D9C.9030200@garzik.org> <452673AC.1080602@garzik.org>
	 <Pine.LNX.4.64.0610060841320.3952@g5.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

On 10/6/06, Linus Torvalds <torvalds@osdl.org> wrote:

> In contrast, the irq argument itself is really no different from the
> cookie we pass in on registration - it's just passing it back to the
> driver that requested the thing. So unlike "regs", there's not really
> anything strange about it, and there's nothing really "wrong" with having
> it there.
>
> So I'm not at all as convinced about this one.

But drivers rarely care about exact IRQ that caused their interrupt
routines to be called. I looked at some of them and they normally use
it just to print warnings which is not critical (and data can still be
retrieved form elsewhere). And without it the only argument can very
nicely be passed via a register (if regparm is allowed).

Drivers that truly need to know IRQ can have it added to dev_id cookie
and use separate dev_ids.

-- 
Dmitry
