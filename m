From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [patch 0/3] IRQ disable vs NMI
Date: Tue, 06 Apr 2010 15:28:07 +0200
Message-ID: <20100406132807.698467930@chello.nl>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49335 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab0DFNjK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Apr 2010 09:39:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@elte.hu, David Miller <davem@davemloft.net>, acme@redhat.com, paulus@samba.org, Mike Galbraith <efault@gmx.de>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@l>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>


This patch set tries to solve the local_irq_disable() vs NMI problem
that SPARC has by providing new arch hooks and instrumenting the
existing interface to WARN on conflicting usage.
