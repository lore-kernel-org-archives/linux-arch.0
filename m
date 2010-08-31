From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Tue, 31 Aug 2010 17:00:15 +0100
Message-ID: <11403.1283270415@redhat.com>
References: <AANLkTikJ5pio3WYmZFAyWpD32hssZoDxX7XSTXN_qV09@mail.gmail.com> <20100827015905.27277.39167.stgit@warthog.procyon.org.uk> <20100827020038.27277.27239.stgit@warthog.procyon.org.uk> <4C7B59E1.6010904@snapgear.com> <26799.1283201411@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34641 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909Ab0HaQAj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 31 Aug 2010 12:00:39 -0400
In-Reply-To: <AANLkTikJ5pio3WYmZFAyWpD32hssZoDxX7XSTXN_qV09@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: dhowells@redhat.com, Greg Ungerer <gerg@snapgear.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Indeed, m68k doesn't use generic hardirqs yet, m68knommu does.

That's orthogonal to this patch series, however.  I'm dealing with IRQ flags
management, not hardirq support.

Out of interest, will the m68knommu arch be integrated into the m68k arch at
some point?  It's certainly possible to have an arch that is bimodal in this
aspect (FRV has CONFIG_MMU as a config option).

David
