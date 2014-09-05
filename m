Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:40865 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaIECJU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Sep 2014 22:09:20 -0400
Message-ID: <54091B30.7080100@zytor.com>
Date: Thu, 04 Sep 2014 19:08:48 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>	 <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com> <1409824374.4246.62.camel@pasglop> <5408E458.3@zytor.com> <54090AF4.7060406@hurleysoftware.com>
In-Reply-To: <54090AF4.7060406@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Hurley <peter@hurleysoftware.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Laight <David.Laight@ACULAB.COM>
Cc: Jakub Jelinek <jakub@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>, linux-alpha@vger.kernel.org
Message-ID: <20140905020848.3LPiQmNLjyXb3Y9VMpmDOV6jHpvwIm0gEMkBxsariqU@z>

On 09/04/2014 05:59 PM, Peter Hurley wrote:
> I have no idea how prevalent the ev56 is compared to the ev5.
> Still we're talking about a chip that came out in 1996.

Ah yes, I stand corrected.  According to Wikipedia, the affected CPUs
were all the 2106x CPUs (EV4, EV45, LCA4, LCA45) plus the 21164 with no
suffix (EV5).  However, we're still talking about museum pieces here.

I wonder what the one I have in my garage is... I'm sure I could emulate
it faster, though.

	-hpa


