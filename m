Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:34471 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1945920AbWBOMnL
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Feb 2006 07:43:11 -0500
Date: Wed, 15 Feb 2006 05:43:09 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [Fwd: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK]
Message-ID: <20060215124309.GO12822@parisc-linux.org>
References: <43F2C7B6.3020102@yahoo.com.au> <20060215081002.GB10026@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215081002.GB10026@mellanox.co.il>
Sender: linux-arch-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>, Hugh Dickins <hugh@veritas.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 15, 2006 at 10:10:02AM +0200, Michael S. Tsirkin wrote:
> I assume that the values are different on different architectures
> because of legacy/backward compatibility concerns, but I dont see
> compelling reasons to mess up new values.
> Why is it important to keep the MADV_ numbers densely packed?  We have 32 bit
> for these, dont we?

Efficiency.  GCC does much better with densely packed numbers in a
switch statement.
