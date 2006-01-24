Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46308
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964974AbWAXFKb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jan 2006 00:10:31 -0500
Date: Mon, 23 Jan 2006 21:07:55 -0800 (PST)
Message-Id: <20060123.210755.31638992.davem@davemloft.net>
Subject: Re: [RFC] is_compat_task helper
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200601240113.39825.ak@suse.de>
References: <20060124000753.GC5604@quicksilver.road.mcmartin.ca>
	<200601240113.39825.ak@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ak@suse.de
Cc: kyle@parisc-linux.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Andi Kleen <ak@suse.de>
Date: Tue, 24 Jan 2006 01:13:39 +0100

> On Tuesday 24 January 2006 01:07, Kyle McMartin wrote:
> 
> > +/* Arches may override __is_compat_task from asm/compat.h */
> > +#ifndef __is_compat_task
> > +#define __is_compat_task(x)	(personality(x->personality) == PER_LINUX32)
> 
> I don't think this particular patch is a good idea. PER_LINUX32 means
> something completely different than you think on many architectures.
> You can't do a default for it.

Indeed, it is definitely preferable to just flat out break
the build than give a bogus default.

If the build breaks, you see the failure and the platform
maintainer makes sure the correct implementation is made.
If it silently just builds, you end up with potential silent
failures which just sucks :)
