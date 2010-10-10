From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Sun, 10 Oct 2010 16:30:02 +0300
Message-ID: <AANLkTimuGDY2OCf9YPH1=ai+K4Vf2HQUBUEWWe-dFTQu@mail.gmail.com>
References: <20100930221351.682772535@linutronix.de>
	<20101003112312.GB9844@angua.secretlab.ca>
	<20101003112920.GB32736@n2100.arm.linux.org.uk>
	<AANLkTingVuhgdaLZ8U3bM+F2vZJ_kScwKqNtHW=g6DcH@mail.gmail.com>
	<alpine.LFD.2.00.1010031544340.14550@localhost6.localdomain6>
	<alpine.LFD.2.00.1010051219580.2556@localhost6.localdomain6>
	<4CACFC23.4080504@kernel.org>
	<alpine.LFD.2.00.1010070050410.17015@localhost6.localdomain6>
	<4CAD082B.40908@kernel.org>
	<4CAD1154.3080403@kernel.org>
	<alpine.LFD.2.00.1010070559480.17015@localhost6.localdomain6>
	<4CAD4EC3.5060809@kernel.org>
	<alpine.LFD.2.00.1010082346310.13094@localhost6.localdomain6>
	<alpine.LFD.2.00.1010082351450.13094@localhost6.localdomain6>
	<4CAFEEFA.1070000@kernel.org>
	<4CB00122.3030301@kernel.org>
	<alpine.LFD.2.00.1010090829150.13094@localhost6.localdomain6>
	<4CB014F5.5080209@kernel.org>
	<alpine.LFD.2.00.1010101130160.2413@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45695 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab0JJNaF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 10 Oct 2010 09:30:05 -0400
In-Reply-To: <alpine.LFD.2.00.1010101130160.2413@localhost6.localdomain6>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>

>Folded in the other fix and pushed out an updated tree.

Testing: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-2.6-sparse-irq.git
master

Running new kernel for 10 minutes. No problems here (Intel Core Duo machine).
