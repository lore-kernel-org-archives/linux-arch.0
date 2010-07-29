Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:60127 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756898Ab0G2Kry (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 29 Jul 2010 06:47:54 -0400
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 0/2] Documentation: DMA API updates
Date: Thu, 29 Jul 2010 19:45:06 +0900
Message-ID: <1280400308-16114-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, fujita.tomonori@lab.ntt.co.jp
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100729104506.g4DuCfnoPz0yOtXFrcJCH8nC29pbRDEM1mnayJpHUTo@z>

The first patch adds the description of how to support multiple types
of IOMMUs (i.e. include/asm-generic/dma-mapping-common.h).

The second patch adds PCI DMA unamp state API to
feature-removal-schedule.txt. It was replaced with the DMA unamp state
API (which can be used for any bus). There is no users of PCI DMA
unamp state API in linux-next. August 2012 is long enough, I suppose.

=
 Documentation/DMA-API-HOWTO.txt            |   10 ++++++++++
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
