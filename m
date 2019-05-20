From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Date: Mon, 20 May 2019 18:02:05 +0200
Message-ID: <20190520160205.GD771@redhat.com>
References: <20190520060018.25569-1-hch@lst.de>
 <20190520060018.25569-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520060018.25569-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
List-Id: linux-arch.vger.kernel.org

On 05/20, Christoph Hellwig wrote:
>
> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.

Acked-by: Oleg Nesterov <oleg@redhat.com>
