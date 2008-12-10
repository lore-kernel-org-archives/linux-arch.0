From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Wed, 10 Dec 2008 19:23:36 +0900
Message-ID: <20081210102335.GA30942@linux-sh.org>
References: <20081205.002701.172921476.davem@davemloft.net> <20081205084233.GE2030@elte.hu> <87ej0mx0c0.fsf@basil.nowhere.org> <20081205.120814.51226316.davem@davemloft.net> <20081210034824.GA27217@linux-sh.org> <20081210102819.GF23556@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:42936 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751838AbYLJKZn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 05:25:43 -0500
Content-Disposition: inline
In-Reply-To: <20081210102819.GF23556@one.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: David Miller <davem@davemloft.net>, mingo@elte.hu, a.p.zijlstra@chello.nl, paulus@samba.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, rostedt@goodmis.org

On Wed, Dec 10, 2008 at 11:28:19AM +0100, Andi Kleen wrote:
> > Oprofile has been a pretty bad fit for them, and while I'm slightly more
> 
> You could always use a extension of timer mode that reads them
> periodically? 
> 
This is what I do today, but it is not an ideal solution. It would be
nice if these sorts of use cases could be supported by newer frameworks
without every platform with similar requirements having to implement
workarounds hanging off of the timer IRQ.
