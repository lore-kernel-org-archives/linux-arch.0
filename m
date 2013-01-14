From: James Hogan <james.hogan@imgtec.com>
Subject: Re: early init dt for earlyprintk (was Re: [RFC PATCH v1 25/31] ARC:
 [plat-arcfpga] Hooking up platform to ARC UART)
Date: Mon, 14 Jan 2013 09:48:49 +0000
Message-ID: <50F3D481.4000806@imgtec.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-26-git-send-email-vgupta@synopsys.com> <201211071416.08012.arnd@arndb.de> <50F3B54D.7010801@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56784 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755986Ab3ANJsx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jan 2013 04:48:53 -0500
In-Reply-To: <50F3B54D.7010801@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>

Hi Vineet

On 14/01/13 07:35, Vineet Gupta wrote:
> 2. We really need a Documentation/dt-for-new-linux-arches.txt, as the existing
> refs - while very helpful - fail to mention subtleties such as you absolutely need
> a intc instance and a default irq domain ..... before the driver can start using
> the DT.

Sounds like a good idea. I'm curious about what you say about default
IRQ domains though. Do you mean irq_set_default_host? In what way is
that required to use DT?

Cheers
James
