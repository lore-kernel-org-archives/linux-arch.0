From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Thu, 02 Sep 2010 11:20:07 +0100
Message-ID: <19747.1283422807@redhat.com>
References: <4C7F0204.4030804@snapgear.com> <4C7DF3B7.7010305@snapgear.com> <4C7B59E1.6010904@snapgear.com> <20100827015905.27277.39167.stgit@warthog.procyon.org.uk> <20100827020038.27277.27239.stgit@warthog.procyon.org.uk> <26799.1283201411@redhat.com> <15143.1283340624@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752092Ab0IBKUW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 06:20:22 -0400
In-Reply-To: <4C7F0204.4030804@snapgear.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


Aha!  I can now (mostly) compile the m68knommu defconfig target.  The only
errors I now see are:

arch/m68knommu/platform/coldfire/head.S: Assembler messages:
arch/m68knommu/platform/coldfire/head.S:177: Error: operands mismatch -- statement `movec %d0,%ACR0' ignored
arch/m68knommu/platform/coldfire/head.S:177: Error: operands mismatch -- statement `movec %d0,%ACR1'

I think my compiler may be too old.

My respun patches will follow shortly.

David
