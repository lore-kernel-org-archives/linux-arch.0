Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp104.prem.mail.ac4.yahoo.com ([76.13.13.43]:22749 "HELO
	smtp104.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753825Ab1CQPY6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Mar 2011 11:24:58 -0400
Date: Thu, 17 Mar 2011 10:18:15 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
Subject: Re: Poll about irqsafe_cpu_add and others
In-Reply-To: <20110317.081420.71114992.davem@davemloft.net>
Message-ID: <alpine.DEB.2.00.1103171016270.12540@router.home>
References: <1300371834.6315.93.camel@edumazet-laptop> <20110317.081420.71114992.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: eric.dumazet@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Message-ID: <20110317151815.k5i-td7eiB9oiulsn37-xTMcio2Xkr7Cff_QFG3U5NI@z>

On Thu, 17 Mar 2011, David Miller wrote:

>
> I had been meaning to bring this up from another perspective.
>
> In networking, we often only ever access objects in base or
> BH context.  Therefore in BH context cases we can do just
> normal counter bumps without any of the special atomic or
> IRQ disabling code at all.

We have the __ functions for that purpose. __this_cpu_inc f.e. falls back
to a simply ++ operation if the arch cannot provide something better.
irqsafe_xx are only used if the context does not provide any protection
and if there is the potential of the counter being incremented from an
interrupt context.

