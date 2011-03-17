From: Christoph Lameter <cl@linux.com>
Subject: Re: Poll about irqsafe_cpu_add and others
Date: Thu, 17 Mar 2011 09:40:33 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.1103170932430.12540@router.home>
References: <1300371834.6315.93.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp103.prem.mail.ac4.yahoo.com ([76.13.13.42]:33962 "HELO
	smtp103.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754897Ab1CQRw0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Mar 2011 13:52:26 -0400
In-Reply-To: <1300371834.6315.93.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, netdev <netdev@vger.kernel.org>, Netfilter Development Mailinglist <netfilter-devel@vger.kernel.org>

On Thu, 17 Mar 2011, Eric Dumazet wrote:

> irqsafe_cpu_{dec|inc} are used in network stack since 2.6.37 (commit
> 29b4433d991c88), and I would like to use irqsafe_cpu_add() in netfilter
> fast path too, and SNMP counters eventually (to lower ram needs by 50%)
>
> Initial support of irqsafe_ was given by Christoph in 2.6.34
>
> It seems only x86 arch is using a native and efficient implementation.

I have some draft(y old) patches for IA64 that use fetchadd together with
a per cpu virtual address range mapped differently for each processor but
in general the problem with other arches is that they do not have
instructions that avoid the expensive bus arbitration for a cacheline nor
do they have segment overrides.

The segment override effect of implicit relocation of the address to the
correct percpu area within one instruction can also be accomplished (like
in the IA64 case) if we have per cpu page tables for the kernel and map
the same virtual addres to different physical addresses for each cpu. Then
the address given to a percpu instruction is constant and the relocation
is performed implicitly by the MMU. Thus the relocation and the RMW
operation are "atomic". Either both occur or none.

The other aspect is that the arch must have cheap increment (and other
RMW) instructions that avoids expensive in cpu processing to establish a
coherent state of the cacheline.

> What about defining a HAVE_FAST_IRQSAFE_ADD ?

Useful at some point I think.
