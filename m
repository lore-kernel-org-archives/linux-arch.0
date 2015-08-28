Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33355 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbbH1Hal (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2015 03:30:41 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: fix various asm-generic abuses
Date: Fri, 28 Aug 2015 09:27:13 +0200
Message-ID: <1440746842-19029-1-git-send-email-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: mitake@dcl.info.waseda.ac.jp, dhowells@redhat.com, herbert@gondor.apana.org.au, oded.gabbay@amd.com, eli@mellanox.com, james_p_freyensee@linux.intel.com, linux-gpio@vger.kernel.org, drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150828072713.84EAxDsUXZftboAD6t3NhEyLDhy_xWsqMCwUjeT48QA@z>

This fixes two trivial classes of asm-generic abuse.  First two headers
that are intended for drivers are moved to include/linux, and second
various drivers that incorrectly use asm-generic headers directly are
switched over to use the proper public headers.  There are a few more
asm-generic abuse, but they aren't quite as trivial so they will take
a little more effort to fix.

