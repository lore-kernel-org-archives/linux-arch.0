Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57488
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1767293AbXDTWju (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 18:39:50 -0400
Date: Fri, 20 Apr 2007 15:39:51 -0700 (PDT)
Message-Id: <20070420.153951.91208263.davem@davemloft.net>
Subject: Re: Better local_t implementation needed
From: David Miller <davem@davemloft.net>
In-Reply-To: <200704202325.06301.zippel@linux-m68k.org>
References: <200704201256.13008.ak@suse.de>
	<200704202325.06301.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: zippel@linux-m68k.org
Cc: ak@suse.de, linux-arch@vger.kernel.org, clameter@sgi.com
List-ID: <linux-arch.vger.kernel.org>

From: Roman Zippel <zippel@linux-m68k.org>
Date: Fri, 20 Apr 2007 23:25:04 +0200

> On Friday 20 April 2007 12:56, Andi Kleen wrote:
> 
> > There used to be a portable implementation of local.h
> > that instead defines local_t as a two value array
> > indexed by in_interrupt(). I'm considering to add that back.
> 
> That doesn't really work in general, interrupts can interrupt other 
> interrupts.

That's correct for hardware interrupts.  It will, however, work for
soft interrupts and similar contexts.
