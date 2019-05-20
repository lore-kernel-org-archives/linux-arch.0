Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387964AbfETQCP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 May 2019 12:02:15 -0400
Date: Mon, 20 May 2019 18:02:05 +0200
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Message-ID: <20190520160205.GD771@redhat.com>
References: <20190520060018.25569-1-hch@lst.de>
 <20190520060018.25569-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520060018.25569-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Message-ID: <20190520160205.x4qMW_5AebK1X6UKdL0Y5Umx6t5gaXs6ftPhtqGjWCY@z>

On 05/20, Christoph Hellwig wrote:
>
> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.

Acked-by: Oleg Nesterov <oleg@redhat.com>
