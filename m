From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Date: Mon, 24 Jun 2019 09:22:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906240922270.32342@nanos.tec.linutronix.de>
References: <20190624054728.30966-1-hch@lst.de>
 <20190624054728.30966-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190624054728.30966-5-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
