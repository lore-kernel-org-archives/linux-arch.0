Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:36203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeKFHvy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 02:51:54 -0500
Date: Mon, 5 Nov 2018 23:29:55 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fls: Change parameter to unsigned int
In-Reply-To: <20181105221117.31828-1-willy@infradead.org>
Message-ID: <alpine.DEB.2.21.1811052328440.1659@nanos.tec.linutronix.de>
References: <20181105221117.31828-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
Message-ID: <20181105222955.AEES9Sl2osXAQ-u0jzjc2iz_YQk77UVfb79L7gGYRpk@z>

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
