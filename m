From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/2] Run interrupt handlers always with interrupts
 disabled
Date: Thu, 25 Mar 2010 20:34:14 -0700 (PDT)
Message-ID: <20100325.203414.149691680.davem@davemloft.net>
References: <20100326000325.917127328@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42662
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753848Ab0CZDdv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Mar 2010 23:33:51 -0400
In-Reply-To: <20100326000325.917127328@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, mingo@elte.hu, peterz@infradead.org, alan@lxorguk.ukuu.org.uk, andi@firstfloor.org, gregkh@suse.de, acme@redhat.com

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 26 Mar 2010 00:06:44 -0000

> The following patch series removes the IRQF_DISABLED functionality
> from the core interrupt code and runs all interrupt handlers with
> interrupts disabled.
> 
> IRQF_DISABLED is kept as a define and scheduled for feature removal.
> 
> I booted and stressed that patches w/o any obvious fallout on more
> than 20 different systems in my arsenal of test machines which
> includes various embedded non x86 systems.
> 
> To debug eventual latency issues we (admittedly I talked acme into
> looking at that) want to extend perf with a top like tool to monitor
> the maximum runtime of interrupt handlers with the already existing
> tracepoints.

Acked-by: David S. Miller <davem@davemloft.net>
