Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59163 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab0IAJQK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Sep 2010 05:16:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20100831193924.102875973@chello.nl>
References: <20100831193924.102875973@chello.nl> <20100831192617.441439071@chello.nl>
Subject: Re: [RFC][PATCH 1/5] mm: strictly nested kmap_atomic
Date: Wed, 01 Sep 2010 10:15:08 +0100
Message-ID: <32752.1283332508@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>, Chris Metcalf <cmetcalf@tilera.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20100901091508.c-W4afHYNgUWHjxe75V9riw0pneZJPPzsnYapzDEGos@z>

Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Ensure kmap_atomic usage is strictly nested
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Reviewed-by: Rik van Riel <riel@redhat.com>

Acked-by: David Howells <dhowells@redhat.com>
