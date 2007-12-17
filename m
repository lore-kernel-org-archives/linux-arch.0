Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55031 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761288AbXLQKeG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Dec 2007 05:34:06 -0500
Date: Mon, 17 Dec 2007 02:33:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: RFC: remove __read_mostly
Message-Id: <20071217023339.ce3da56c.akpm@linux-foundation.org>
In-Reply-To: <p73tzmmf72u.fsf@bingen.suse.de>
References: <20071213222044.GH21616@stusta.de>
	<20071213235432.GA26669@fattire.cabal.ca>
	<p73tzmmf72u.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, 14 Dec 2007 01:33:45 +0100 Andi Kleen <andi@firstfloor.org> wrote:

> Kyle McMartin <kyle@mcmartin.ca> writes:
> 
> > I'd bet, in the __read_mostly case at least, that there's no
> > improvement in almost all cases.
> 
> I bet you're wrong. Cache line behaviour is critical, much more
> than pipeline behaviour (which unlikely affects). That is because
> if you eat a cache miss it gets really expensive, which e.g.
> a mispredicted jump is relatively cheap in comparison. We're talking
> one or more orders of magnitude.

So...  once we've moved all read-mostly variables into __read_mostly, what
is left behind in bss?

All the write-often variables.  All optimally packed together to nicely
maximise cacheline sharing.
