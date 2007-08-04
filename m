Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:50088 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbXH1IJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Aug 2007 04:09:44 -0400
From: Nick Piggin <npiggin@suse.de>
Date: Sun, 05 Aug 2007 06:28:20 +1000
Message-Id: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
Subject: [patch 0/8] lock bitops and some bitops fixes
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Here is a new set of bitops patches that can hopefully get into the
next merge window.

I'm not sending the intrusive part of the patchset (the page lock and
buffer lock conversions), so that you'll hopefully apply these bits
and get them some early testing. I've just converted bit_spinlock
over to use the lock bitops, in order to get a bit of test coverage.

I've spotted some potential bugs in alpha and mips bitops functions,
but would like acks from maintainers for _those_ specific patches.

Thanks,
Nick
