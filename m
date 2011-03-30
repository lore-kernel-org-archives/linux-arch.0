From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] unicore32 fix: remove arch-specific futex support
Date: Wed, 30 Mar 2011 14:17:19 +0200
Message-ID: <201103301417.20027.arnd@arndb.de>
References: <01eb01cbeeb7$30390460$90ab0d20$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62775 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab1C3MRc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2011 08:17:32 -0400
In-Reply-To: <01eb01cbeeb7$30390460$90ab0d20$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>, Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 30 March 2011, Guan Xuetao wrote:
> The futex functions in unicore32 are not used and verified,
> so just replaced by asm-generic version.
> 
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Note that the a working futex implementation would be really useful
to get efficient multithreaded applications. On uniprocessor
machines, this can easily be done by disabling interrupts, like
you also do for spinlock and atomic.

I believe we could actually copy the arch/sh/include/asm/futex-irq.h
implementation to include/asm-generic and use that whenever CONFIG_SMP
is disabled. That would also help a lot of other architectures.

	Arnd
