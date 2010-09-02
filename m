Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([72.1.168.231]:6124 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab0IBQxd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Sep 2010 12:53:33 -0400
Message-ID: <4C7FD548.5030109@tilera.com>
Date: Thu, 2 Sep 2010 12:48:08 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH 2/5] mm: stack based kmap_atomic
References: <20100831192617.441439071@chello.nl> <20100831193924.157667156@chello.nl>
In-Reply-To: <20100831193924.157667156@chello.nl>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>
Message-ID: <20100902164808.LZwKAoZ0Jfl288hI5do4W30El4Ue7uFfH7bIrI3A6pc@z>

 Acked-by: Chris Metcalf <cmetcalf@tilera.com>
for the series.

Note that in patch 4/5 you can also remove the pte_*map_nested() #defines
in arch/tile/include/asm/pgtable.h.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

