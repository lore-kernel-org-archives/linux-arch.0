From: Andrew Morton <akpm@linux-foundation.org>
Subject: PAGE_KERNEL_RO
Date: Wed, 12 Jan 2011 16:07:22 -0800
Message-ID: <20110112160722.6486a6c2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37881 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755712Ab1AMAID (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Jan 2011 19:08:03 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>


drivers/firewire/ohci.c now needs PAGE_KERNEL_RO, but many
architectures don't implement it.  Broke my sparc64 build.
