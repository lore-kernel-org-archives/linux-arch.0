Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268368AbUHLBCl@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42213 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268488AbUHLBCU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Aug 2004 21:02:20 -0400
Date: Wed, 11 Aug 2004 18:01:22 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: clear_user_highpage()
Message-Id: <20040811180122.428a9e61.davem@redhat.com>
In-Reply-To: <20040812004654.GX11200@holomorphy.com>
References: <20040811161537.5e24c2b6.davem@redhat.com>
	<Pine.LNX.4.58.0408111635160.1839@ppc970.osdl.org>
	<20040812004654.GX11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 11 Aug 2004 17:46:54 -0700
William Lee Irwin III <wli@holomorphy.com> wrote:

> The scheduling latency aspect is due to the fact that many cpus have
> caching semantics that require extremely slow uncached accesss to
> prevent cache pollution, and that page zeroing is slow enough of an
> operation to noticeably stall rescheduling userspace.

This wouldn't be an issue on sparc64, as I've previously stated
an entire page can be zero'd out, cache bypassed on miss, in 4400
cycles even when the L2 cache misses for the whole page.

That would add less to rescheduling latency than that
obtained from simply taking a hardware interrupt.
