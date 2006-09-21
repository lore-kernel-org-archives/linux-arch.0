Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:32207 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751142AbWIUMfa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Sep 2006 08:35:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17682.34548.763586.32814@cargo.ozlabs.ibm.com>
Date: Thu, 21 Sep 2006 22:35:00 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 2/3] Directed yield: direct yield of spinlocks for powerpc.
In-Reply-To: <20060919111950.GD21713@skybase>
References: <20060919111950.GD21713@skybase>
Sender: linux-arch-owner@vger.kernel.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
List-ID: <linux-arch.vger.kernel.org>

Martin Schwidefsky writes:

> Powerpc already has a directed yield for CONFIG_PREEMPT="n". To make
> it work with CONFIG_PREEMPT="y" as well the _raw_{spin,read,write}_relax
> primitives need to be defined to call __spin_yield() for spinlocks and
> __rw_yield() for rw-locks.

Acked-by: Paul Mackerras <paulus@samba.org>
