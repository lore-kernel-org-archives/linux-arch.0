Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shoshil.marvell.com ([199.203.130.250]:20284 "EHLO
	il.marvell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbYCJJ3U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Mar 2008 05:29:20 -0400
Message-ID: <47D4F1DD.3090601@marvell.com>
Date: Mon, 10 Mar 2008 10:31:25 +0200
From: Tzachi Perelstein <tzachi@marvell.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7][RFC] Move Marvell MBUS window handling into drivers
References: <20080307101913.GA11918@xi.wantstofly.org>
In-Reply-To: <20080307101913.GA11918@xi.wantstofly.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-arch@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Dale Farnsworth <dale@farnsworth.org>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Message-ID: <20080310083125.-IplHkfYcXsKp2sfnadIDx5R-aPRDZwuUfW6yhDPjWI@z>

Lennert Buytenhek wrote:
> 
> This patch set is an initial attempt at moving programming of the
> MBUS register windows for the set of MBUS peripherals that we currently
> have in-tree drivers for from platform code into drivers.
> 
> With these patches, info about DRAM target/attribute IDs is prepared
> by the platform code as usual, but then passed into platform drivers
> via platform device data, instead of programming that data into the
> peripherals directly.
> 
> This avoids duplicating the window programming code across each
> platform that wants to use these peripherals, and avoids exposing
> internal peripheral register set details outside of their drivers.
> 
> Comments appreciated.
> 

At the beginning I had some hard time to agree with this concept 
of leaving the mbus windows to be handled at drivers level instead 
of the arch level, mainly because the mbus bits looks somehow 
different on every orion/discovery chips. My feeling was that this 
approach will either fail on some chips or will be very cumbersome.

Well, I was wrong. Reviewing the patches against orion/discovery 
specs shows that this patchset indeed handles all these bits 
differences correctly, and in a very simple and elegant manner. 
So I like it a lot ;) 

For the whole set --
Reviewed-by: Tzachi Perelstein <tzachi@marvell.com>

