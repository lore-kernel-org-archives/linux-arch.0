From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 03/31] arm64: Exception handling
Date: Wed, 15 Aug 2012 01:47:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1208150146460.32033@ionos>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-4-git-send-email-catalin.marinas@arm.com> <20120814232907.GB19607@quad.lixom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:33897 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab2HNXrR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 19:47:17 -0400
In-Reply-To: <20120814232907.GB19607@quad.lixom.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>

On Tue, 14 Aug 2012, Olof Johansson wrote:
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > new file mode 100644
> > index 0000000..8712a8e
> > --- /dev/null
> > +++ b/arch/arm64/kernel/traps.c
> [...]
> > +DEFINE_SPINLOCK(die_lock);
> 
> Should probably be static.

And RAW_
