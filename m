Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43303 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759933AbZJHX0x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 19:26:53 -0400
Message-ID: <20091008232226.768382977@chello.nl>
Date: Fri, 09 Oct 2009 01:22:26 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 0/4] stack based kmap_atomic -v2
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "hugh.dickins" <hugh.dickins@tiscali.co.uk>, Ingo Molnar <mingo@elte.hu>, David Howells <dhowells@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20091008232226.K8TqHNqI_-fTaVqI2I33GFLJue7Z-PnbgAbg82Oy1T0@z>

Latest bits..

Maybe FRV can do a kind of kmap-stack switch on (soft)irq enter/exit
in order to stay below 5 entries.

Will continue prodding tomorrow, sleep time here.


