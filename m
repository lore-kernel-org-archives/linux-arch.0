From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fls: Change parameter to unsigned int
Date: Mon, 5 Nov 2018 23:29:55 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1811052328440.1659@nanos.tec.linutronix.de>
References: <20181105221117.31828-1-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105221117.31828-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 5 Nov 2018, Matthew Wilcox wrote:

> When testing in userspace, UBSAN pointed out that shifting into the sign
> bit is undefined behaviour.  It doesn't really make sense to ask for the
> highest set bit of a negative value, so just turn the argument type into
> an unsigned int.
> 
> Some architectures (eg ppc) already had it declared as an unsigned int,
> so I don't expect too many problems.
>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
