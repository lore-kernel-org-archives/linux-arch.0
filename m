Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab0IAKn2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Sep 2010 06:43:28 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4C7DF3B7.7010305@snapgear.com>
References: <4C7DF3B7.7010305@snapgear.com> <4C7B59E1.6010904@snapgear.com> <20100827015905.27277.39167.stgit@warthog.procyon.org.uk> <20100827020038.27277.27239.stgit@warthog.procyon.org.uk> <26799.1283201411@redhat.com>
Subject: Re: [PATCH 18/22] Fix M68K irqflags
Date: Wed, 01 Sep 2010 11:43:13 +0100
Message-ID: <2084.1283337793@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Ungerer <gerg@snapgear.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100901104313.HkNSu-7QgQi2XosU_erLZFZs4w51d_E6sbhZquCU5dE@z>

Greg Ungerer <gerg@snapgear.com> wrote:

> Here is a spin of the same patch, only with a single irqflags.h.
> It is closely modeled on the mm version, merging (and cleaning)
> the non-mmu bits as needed. There is a fair bit of common code
> in here.

Thanks!

I can compile test, but I can't run test (no h/w).

David
