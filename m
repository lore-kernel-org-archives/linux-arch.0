Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:35008 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFXHXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 03:23:18 -0400
Date: Mon, 24 Jun 2019 09:23:02 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: remove asm-generic/ptrace.h v3
In-Reply-To: <20190624054728.30966-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
References: <20190624054728.30966-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190624072302.DfF-gsc2FbrDoTOjbhmru6EuMcKMToBYUzutpZJHaLA@z>

On Mon, 24 Jun 2019, Christoph Hellwig wrote:
> 
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.
> 
> I'm not sure which tree is the right place, but may this can go through
> the asm-generic tree since it removes an asm-generic header?

Makes sense.

Thanks,

	tglx
