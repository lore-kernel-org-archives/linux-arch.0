Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:59671 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbXJVTLg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2007 15:11:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
Date: Mon, 22 Oct 2007 21:10:34 +0200
References: <20071020235546.GB1825@martell.zuzino.mipt.ru> <20071022152912.GA841@linux-mips.org> <20071022112110.105b8e11.akpm@linux-foundation.org>
In-Reply-To: <20071022112110.105b8e11.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200710222110.34768.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@ftp.linux.org.uk>, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 22 October 2007, Andrew Morton wrote:
> Yes, it's always been ugly that we use unsigned long for this rather than
> abstracting it properly.
> 
> However I'd prefer that we have some really good reason for introducing
> irq_flags_t now.  Simply so that I don't needlessly spend the next two
> years wrestling with literally thousands of convert-to-irq_flags_t patches
> and having to type "please use irq_flags_t here" in hundreds of patch
> reviews. (snivel, wimper)

On a related note, should we encourage the use of spin_lock() and
spin_lock_irq() instead of spin_lock_irqsave() where possible?

On some architectures, accessing the interrupt flag is a heavyweight
operation, especially when running under a hypervisor, so a number
of drivers could benefit from being converted to not save the flags
at all instead of just changing the type of the flags variable.

	Arnd <><
