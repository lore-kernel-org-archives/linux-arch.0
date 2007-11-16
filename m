Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5141 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759883AbXKPXee convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 18:34:34 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 07/30] cpu alloc: IA64 support
Date: Fri, 16 Nov 2007 15:32:41 -0800
Message-ID: <617E1C2C70743745A92448908E030B2A02F944FB@scsmsx411.amr.corp.intel.com>
In-Reply-To: <20071116231103.808561432@sgi.com>
References: <20071116230920.278761667@sgi.com> <20071116231103.808561432@sgi.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

+# Maximum of 128 MB cpu_alloc space per cpu
+config CPU_AREA_ORDER
+	int
+	default "13"

Comment only matches code when page size is 16K ... and we are (slowly)
moving to 64k as the default (which with order 13 allocation would mean
512M)

-Tony
