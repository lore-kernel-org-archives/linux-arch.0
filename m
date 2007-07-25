Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55829
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758690AbXGYTfD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 15:35:03 -0400
Date: Wed, 25 Jul 2007 12:35:01 -0700 (PDT)
Message-Id: <20070725.123501.71119586.davem@davemloft.net>
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
From: David Miller <davem@davemloft.net>
In-Reply-To: <46A78A31.10506@goop.org>
References: <alpine.LFD.0.999.0707251018280.3607@woody.linux-foundation.org>
	<20070725172542.GG27237@ftp.linux.org.uk>
	<46A78A31.10506@goop.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: jeremy@goop.org
Cc: viro@ftp.linux.org.uk, torvalds@linux-foundation.org, hpa@zytor.com, kaos@ocs.com.au, xyzzy@speakeasy.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Wed, 25 Jul 2007 10:36:49 -0700

> I tried that, but there's still no way of getting a pointer to the ud2a
> instruction in there.  gcc just generates garbage if you try to use use
> the &&label syntax on a label which isn't (potentially) the target of a
> goto (it just gets placed somewhere random).
> 
> But there's a bigger problem than that.  If the BUG is in code which can
> be replicated (ie inlined or unrolled), then it would also require
> replicating the static variable...

Another issue is that if you have a conditional trap instruction on
your cpu, and you try the __label__ trick, GCC no longer converts:

	BUG_ON(test)

into just a:

	set condition codes;
	conditional_trap;

sequence because the "stuff" inside the basic block is something
more than just the __builtin_trap().

The holy grail would be being able to get the perfect conditional
trap sequence, plus the annotations in a seperate section.
