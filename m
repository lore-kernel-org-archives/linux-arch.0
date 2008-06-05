From: Jes Sorensen <jes@sgi.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 05 Jun 2008 10:40:48 +0200
Message-ID: <4847A690.302@sgi.com>
References: <1211852026.3286.36.camel@pasglop> <4843C3D7.7000609@sgi.com> <200806031433.12460.nickpiggin@yahoo.com.au> <200806030952.10360.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:52992 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751713AbYFEIky (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 5 Jun 2008 04:40:54 -0400
In-Reply-To: <200806030952.10360.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Jeremy Higdon <jeremy@sgi.com>, Roland Dreier <rdreier@cisco.com>, benh@kernel.crashing.org, Arjan van de Ven <arjan@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com, linuxppc-dev@ozlabs.org, scottwood@freescale.com, torvalds@linux-foundation.org, David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk

Jesse Barnes wrote:
> Now, in hindsight, using a PIO write set & test flag approach in 
> writeX/spin_unlock (ala powerpc) might have been a better approach, but iirc 
> that never came up in the discussion, probably because we were focused on PCI 
> posting and not uncached vs. cached ordering.

Hi Jesse,

I am going to take a stab at implementing this so we can see how much
of an impact it will have.

Cheers,
Jes
