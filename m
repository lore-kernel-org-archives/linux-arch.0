Return-Path: <SRS0=zjVl=3K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUOmp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 09:42:45 -0500
Date: Tue, 21 Jan 2020 15:42:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200121144229.GN14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-4-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200121144229.5wAQertRZPmU0bsvgerlTf7sKML3eJz38z7b9LVBR0s@z>

On Mon, Dec 30, 2019 at 02:40:40PM -0500, Alex Kogan wrote:
> +#define pv_wait_head_or_lock		cna_pre_scan

Also inconsitent naming.

> +__always_inline u32 cna_pre_scan(struct qspinlock *lock,
> +				  struct mcs_spinlock *node)
> +{
> +	struct cna_node *cn = (struct cna_node *)node;
> +
> +	cn->pre_scan_result = cna_scan_main_queue(node, node);
> +
> +	return 0;
> +}

The thinking here is that we're trying to make use of the time otherwise
spend spinning on atomic_cond_read_acquire(), to search for a potential
unlock candidate?

Surely that deserves a comment.
