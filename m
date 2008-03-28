Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44494 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011AbYC1Cy5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Mar 2008 22:54:57 -0400
Date: Fri, 28 Mar 2008 03:54:55 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: [patch 0/2]: lockless get_user_pages patchset
Message-ID: <20080328025455.GA8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328025455.lFSJwylF1IRhj5FMwyRA_wPcu0l05N6IYNJUw6rlmPI@z>

Hi,

This patchset It impoves our well known oltp performance thingy by 10% on DB2
on a modest 2 socket x86 system. For a sense of scale, remember numbers being
tossed around like direct-IO giving a 12% improvement; or hugepages giving a 9%
improvement... heh.

I have a powerpc patch as well, but it needs benh to find me a bit in their pte
to use.

These patches are on top of the previous 7 patches just sent.

Nick

