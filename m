Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:29195 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422682AbWJFOHl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Oct 2006 10:07:41 -0400
Received: by ug-out-1314.google.com with SMTP id o38so321310ugd
        for <linux-arch@vger.kernel.org>; Fri, 06 Oct 2006 07:07:39 -0700 (PDT)
Message-ID: <d120d5000610060707p13a9e97fkcb1219164da3f2d1@mail.gmail.com>
Date: Fri, 6 Oct 2006 10:07:39 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
In-Reply-To: <20061006112550.GA21733@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002132116.2663d7a3.akpm@osdl.org>
	 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <18975.1160058127@warthog.cambridge.redhat.com>
	 <4525A8D8.9050504@garzik.org>
	 <1160133932.1607.68.camel@localhost.localdomain>
	 <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu>
	 <45263D9C.9030200@garzik.org> <20061006112550.GA21733@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

On 10/6/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Jeff Garzik <jeff@garzik.org> wrote:
>
> > >but pt_regs is alot less frequently used than irq - and where it's
> > >used they arent "drivers" but mostly arch level code like hw-timer
> > >handlers.
> >
> > Nonetheless the -vast majority- of drivers don't use the argument at
> > all, and the minority that do use it are not modern drivers.
>
> i'm all for changing that too :)
>

What drivers use irq argument? I know i8042 does but only to detect
whether interrupt routine was called because irq was raised or it was
called manually and I can use dev_id for that...

-- 
Dmitry
