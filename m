From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-RFC 0/2] tile: switch to generic pci_iomap
Date: Tue, 29 Nov 2011 20:54:05 +0200
Message-ID: <cover.1322592494.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab1K2Swl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Nov 2011 13:52:41 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>, "Michael S. Tsirkin" <mst@redhat.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Paul Mundt <lethal@linux-sh.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Here's a completely untested patch to switch tile
over to the new pci_iomap (in -mm).

This is on top of pci: use generic pci_iomap in most architectures,
and converts just the tile architecture.

Seems straightforward enough but completely untested - could someone
with access to appropriate systems respond and say whether
the first patch in the series is OK?
The second one should then be trivial.

-- 
1.7.5.53.gc233e
