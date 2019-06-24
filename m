Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:34992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFXHXB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 03:23:01 -0400
Date: Mon, 24 Jun 2019 09:22:39 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
In-Reply-To: <20190624054728.30966-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1906240922270.32342@nanos.tec.linutronix.de>
References: <20190624054728.30966-1-hch@lst.de> <20190624054728.30966-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Message-ID: <20190624072239.V8qPtXqo--gc94qX1BnbFWP_2m-Wzu7jYUafTSOCDZo@z>

On Mon, 24 Jun 2019, Christoph Hellwig wrote:

> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.
> 
> Note that only the helpers actually used are implemented now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
