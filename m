From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Date: Sat, 3 May 2008 18:55:11 +0200
Message-ID: <20080503165511.GA21967@elte.hu>
References: <1209832169.6929.42.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47110 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760060AbYECQzh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 3 May 2008 12:55:37 -0400
Content-Disposition: inline
In-Reply-To: <1209832169.6929.42.camel@lappy>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Guillaume Chazarain <guichaz@gmail.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Mike Galbraith <efault@gmx.de>, Dhaval Giani <dhaval@linux.vnet.ibm.com>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> it _DOESN'T_ boot ;-/ [...]

FYI, the merged version against sched-devel.git does boot fine here and 
the clock does seem to advance as expected.

	Ingo
