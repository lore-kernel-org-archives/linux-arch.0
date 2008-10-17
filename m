From: David Miller <davem@davemloft.net>
Subject: Re: [RFC patch 03/15] get_cycles() : sparc64 HAVE_GET_CYCLES
 (update)
Date: Thu, 16 Oct 2008 19:57:22 -0700 (PDT)
Message-ID: <20081016.195722.148509014.davem@davemloft.net>
References: <20081016232729.699004293@polymtl.ca>
	<20081016234655.893647148@polymtl.ca>
	<20081017024824.GB32468@Krystal>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40339
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751976AbYJQC5q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Oct 2008 22:57:46 -0400
In-Reply-To: <20081017024824.GB32468@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mathieu.desnoyers@polymtl.ca
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org, a.p.zijlstra@chello.nl, tglx@linutronix.de, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Thu, 16 Oct 2008 22:48:24 -0400

> This patch selects HAVE_GET_CYCLES and makes sure get_cycles_barrier() and
> get_cycles_rate() are implemented.
> 
> Changelog :
> - Use tb_ticks_per_usec * 1000000 in get_cycles_rate().
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

Yep, that'll work:

Acked-by: David S. Miller <davem@davemloft.net>
