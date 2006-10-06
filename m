Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45707 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932512AbWJFAwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2006 20:52:54 -0400
Message-ID: <4525A8D8.9050504@garzik.org>
Date: Thu, 05 Oct 2006 20:52:40 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing
 to IRQ handlers
References: <20061002132116.2663d7a3.akpm@osdl.org>  <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com>
In-Reply-To: <18975.1160058127@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

The overwhelming majority of irq handlers don't use the 'irq' argument 
either...  the driver-supplied pointer is what drivers use, exclusively, 
to differentiate between different instances.

If we are going to break all the irq handlers, I'd suggest going ahead 
and removing that one too.

	Jeff


