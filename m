From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 05 Dec 2008 12:08:14 -0800 (PST)
Message-ID: <20081205.120814.51226316.davem@davemloft.net>
References: <20081205.002701.172921476.davem@davemloft.net>
	<20081205084233.GE2030@elte.hu>
	<87ej0mx0c0.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33248
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754052AbYLEUIO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2008 15:08:14 -0500
In-Reply-To: <87ej0mx0c0.fsf@basil.nowhere.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: andi@firstfloor.org
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, paulus@samba.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, rostedt@goodmis.org

From: Andi Kleen <andi@firstfloor.org>
Date: Fri, 05 Dec 2008 13:39:43 +0100

> Given these are more obscure features, but not being able to fit
> them easily into your model from the start isn't a very promising sign
> for the long term extensibility of the design.

Another thing I'm interested in is if this new stuff will work with
performance counters that lack an overflow interrupt.

We have several chips that are like this, and perfmon supported that
on the kernel side, and also provided overflow emulation for such
hardware in userspace (where such complexity belongs).
