From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 11/24] C6X: interrupt handling
Date: Mon, 22 Aug 2011 17:08:22 -0400
Message-ID: <1314047303.2404.23.camel@deneb.redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-12-git-send-email-msalter@redhat.com>
	 <2384053.HX3gjK1Rxm@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:20903 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab1HVVIg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 17:08:36 -0400
In-Reply-To: <2384053.HX3gjK1Rxm@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, 2011-08-22 at 22:58 +0200, Arnd Bergmann wrote:
> On Monday 22 August 2011 16:09:32 Mark Salter wrote:
> > 
> > Most of the code in arch/c6x/kernel/irq.c which supports mapping of hardware
> > interrupts to virtual kernel interrupts was taken as-is from powerpc. Very
> > few changes were necessary for C6X, so separating that out into the generic
> > kernel interrupt code may be worthwhile for cases where other architectures
> > may want to use it.
> 
> What's the status on this? Did you talk about this with Thomas and/or BenH?
> 

No. That paragraph was a reminder to myself as much as anything and I
meant to CC thomas on that patch but, uh, forgot.

*sigh*

--Mark
