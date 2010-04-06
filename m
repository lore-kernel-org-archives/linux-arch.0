Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35001
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757626Ab0DFXjt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 19:39:49 -0400
Date: Tue, 06 Apr 2010 16:39:51 -0700 (PDT)
Message-ID: <20100406.163951.115014932.davem@davemloft.net>
Subject: Re: [patch 0/3] IRQ disable vs NMI
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100406132807.698467930@chello.nl>
References: <20100406132807.698467930@chello.nl>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: a.p.zijlstra@chello.nl
Cc: mingo@elte.hu, acme@redhat.com, paulus@samba.org, efault@gmx.de, fweisbec@gmail.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100406233951.V-aIhG_ADP-lkg8GJKs7_rVdAIaSMpdeWxQF_TJKr9s@z>

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 06 Apr 2010 15:28:07 +0200

> This patch set tries to solve the local_irq_disable() vs NMI problem
> that SPARC has by providing new arch hooks and instrumenting the
> existing interface to WARN on conflicting usage.

Ok, two patches coming.

One which adds the sparc64 irqflags.h methods.

And one which annotates the ftrace functions, as needed.

With this I have the function tracer working.

Thanks!
