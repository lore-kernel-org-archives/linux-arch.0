From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
Date: Fri, 26 Nov 2010 07:52:04 +1100
Message-ID: <1290718324.32570.127.camel@pasglop>
References: <1290607413.12457.44.camel@concordia>
	 <1290692075.689.20.camel@concordia>
	 <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46512 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab0KYUwm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Nov 2010 15:52:42 -0500
In-Reply-To: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: michael@ellerman.id.au, linux-arch <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org

On Thu, 2010-11-25 at 15:01 +0100, Geert Uytterhoeven wrote:
> 
> I always read it as "for each child-OF-node", so I would rename it to
> "dt_for_each_child_node".

Well, it was meant to be for_child_of_node not _OF_node :-)

Cheers,
Ben.
