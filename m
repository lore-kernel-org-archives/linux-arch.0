Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261543AbUJXQpL@vger.kernel.org>
Received: from phoenix.infradead.org ([81.187.226.98]:18444 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261533AbUJXPyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 24 Oct 2004 11:54:47 -0400
Date: Sun, 24 Oct 2004 16:54:43 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: generic hardirq code in 2.6.10-rc1
Message-ID: <20041024155443.GA25013@infradead.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>   o generic irq subsystem: core
>   o generic irq subsystem: x86 port
>   o generic irq subsystem: x86_64 port
>   o generic irq subsystem: ppc port
>   o generic irq subsystem: ppc64 port

Btw, it would be nice if all architectures that have more or less
a copy of the i386 irq.c could switch to the generic code.

That would be:  alpha,ia64, m32r, mips, sh, sh64, um, v850

and possibly cris (it currently has a simplified version)
