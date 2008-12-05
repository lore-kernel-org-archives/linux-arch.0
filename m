From: David Miller <davem@davemloft.net>
Subject: Re: [patch 2/3] performance counters: documentation
Date: Thu, 04 Dec 2008 19:26:50 -0800 (PST)
Message-ID: <20081204.192650.193940655.davem@davemloft.net>
References: <18744.30427.440468.829807@cargo.ozlabs.ibm.com>
	<20081204.163741.48585912.davem@davemloft.net>
	<20081204185002.5faded25@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60601
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbYLED0u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Dec 2008 22:26:50 -0500
In-Reply-To: <20081204185002.5faded25@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arjan@infradead.org
Cc: paulus@samba.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, mingo@elte.hu, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, hpa@zytor.com, a.p.zijlstra@chello.nl, rostedt@goodmis.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Thu, 4 Dec 2008 18:50:02 -0800

> I would like to respectfully disagree with this some. The kernel needs
> to abstract hardware to some degree for userspace. The problem in this
> case is that userspace can't really do a better job, in fact it can
> only do a worse job since it lacks the coordination capability of
> knowing it has full control of all the hardware registers. 

The perfmon context abstraction dealt with that.  Code using the
perfmon interfaces provided a set of counter and control register
values to the kernel.

The kernel merely loaded and unloaded them when a process (or group of
processes) ran.

The kernel is a validity checker, and that minimal stuff is exactly
what the perfmon kernel component implemented.
