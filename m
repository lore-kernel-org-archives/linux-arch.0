Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cabal.ca ([134.117.69.58]:51643 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1030225AbWAXAZG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jan 2006 19:25:06 -0500
Date: Mon, 23 Jan 2006 19:23:20 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [RFC] is_compat_task helper
Message-ID: <20060124002320.GE5604@quicksilver.road.mcmartin.ca>
References: <20060124000753.GC5604@quicksilver.road.mcmartin.ca> <200601240113.39825.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601240113.39825.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jan 24, 2006 at 01:13:39AM +0100, Andi Kleen wrote:
> I don't think this particular patch is a good idea. PER_LINUX32 means
> something completely different than you think on many architectures.
> You can't do a default for it.
>

Hmm, I like the way x86-64 handles this. Perhaps it would be better
to not do anything by default at all. I thought about using thread_info
flags, but those are not nearly consistent.

Cheers,
	Kyle
