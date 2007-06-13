Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:47843 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756078AbXFMKOy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Jun 2007 06:14:54 -0400
Message-Id: <20070613100334.635756997@chello.nl>
Date: Wed, 13 Jun 2007 12:03:34 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [patch 0/3] no MAX_ARG_PAGES -v2
Sender: linux-arch-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: Ollie Wild <aaw@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>


This patch-set aims at removing the current limit on argv+env space aka.
MAX_ARG_PAGES.

The new mm is created before the binfmt code runs, the stack is placed at the
highest address supported by that architecture.

The argv+env data is then copied from the old mm into the new mm (which is
inactive at that time - this introduces some cache coherency issues).

Then we run the binfmt code, which will compute the final stack address. The
existing stack will be moved downwards (or upwards on PA-RISC) to the desired
place.

This 'trick' heavily relies on the MMU, so for no-MMU archs we stay with the
old approach.

---

Plenty of changes all around, changes listed in the individual patches. We hope
to have addressed all issues raised.

