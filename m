Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:11414 "EHLO
	triton.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbYCORcg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Mar 2008 13:32:36 -0400
Date: Sat, 15 Mar 2008 18:29:14 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [0/3] Improve generic fls64 for 64-bit machines
Message-ID: <20080315172913.GA21648@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20080315172914.pU7WmYLR3kzwqvEv9nhH_52wuLtN4NCTJUGBZXJwLDA@z>

This series of patches:

[1/3] adds __fls.h to asm-generic
[2/3] modifies asm-*/bitops.h for 64-bit archs to implement __fls
[3/3] modifies asm-generic/fls64.h to make use of __fls

I have compiled i386 and x86_64, and they generate the same code as
before the change. The changes to the other archs are a best effort.
Please comment.

If this patch series is accepted, it will make one tiny bit of
the x86-unification a tiny bit cleaner. The patches are against
Linus' current tree.

Andrew, if no concensus can be reached that this is a bad patch
series, would you be willing to add this to your tree?

Greetings,
	Alexander
