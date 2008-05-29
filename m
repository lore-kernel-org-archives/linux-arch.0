From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] Kill unused parameter to smp_call_function and
 friends
Date: Thu, 29 May 2008 11:41:32 +0100
Message-ID: <20080529114132.663eff4b@core>
References: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59018 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751021AbYE2L0r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 07:26:47 -0400
In-Reply-To: <1212051661-12733-1-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, npiggin@suse.de, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu, paulmck@linux.vnet.ibm.com

On Thu, 29 May 2008 11:00:59 +0200
Jens Axboe <jens.axboe@oracle.com> wrote:

> Hi,
> 
> It bothers me how the smp call functions accept a 'nonatomic' or 'retry'
> parameter (depending on who you ask), but don't do anything with it.
> So kill that silly thing.
> 
> Two patches here, one for smp_call_function*() and one for on_each_cpu().
> This patchset applies on top of the generic-ipi patchset just sent out.

Which leads to notice that we seem to have acquired a bug somewhere on
the way. smp_call_function on x86 is it seems to me implemented as
"smp_call_function and occasionally run it multiple times"

One of the joys of the older x86 APIC setups is the APIC messaging bus.
This can get checksum errors in which case the message is retransmitted:

In the specific case a message is retransmitted and there are at least
three parties on the bus (2 CPU APICs and an IOAPIC is enough) you can
get a situation where one receiver gets the message the second receiver
errors it and the retransmit causes the IPI to be repeated which causes
the IPI to be redelivered.

This used to turn up now and then - particularly on 440BX boards.

Alan
Gnome #331: Early SMP Implementation Archive Office
