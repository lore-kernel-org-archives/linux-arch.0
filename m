Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:39359 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbbL3Urm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Dec 2015 15:47:42 -0500
Date: Wed, 30 Dec 2015 15:47:39 -0500 (EST)
Message-ID: <20151230.154739.2088097882831259841.davem@davemloft.net>
Subject: Re: [PATCH 07/34] sparc: reuse asm-generic/barrier.h
From: David Miller <davem@davemloft.net>
In-Reply-To: <20151230215303-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-8-git-send-email-mst@redhat.com>
	<20151230.125603.75638711551088484.davem@davemloft.net>
	<20151230215303-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, linux-arch@vger.kernel.org, andrew.cooper3@citrix.com, virtualization@lists.linux-foundation.org, stefano.stabellini@eu.citrix.com, mingo@kernel.org, mpe@ellerman.id.au, andreyknvl@google.com, sparclinux@vger.kernel.org
Message-ID: <20151230204739.NVcro6Cufb1hweW19mZpsNIaPz19251Ii9imTCvfeUo@z>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 30 Dec 2015 21:55:33 +0200

> The problem I had in the past is that vger rejects email with
> too many CC addresses.

I can't think of a patch set where a > 1024 character CC: list is
legitimate anyways, even if all interested parties are included.

> I'll look for better solutions next time - for now, would it help if I
> bounced the whole patchset to you?

Not necessary, I provided a reply to your 00/NN repost.
