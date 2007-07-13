Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:57422 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937853AbXGMWy1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 18:54:27 -0400
Date: Fri, 13 Jul 2007 15:54:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: RE: [PATCH 0/7] Sparsemem Virtual Memmap V5
In-Reply-To: <617E1C2C70743745A92448908E030B2A01EA65B9@scsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0707131553120.26572@schroedinger.engr.sgi.com>
References: <617E1C2C70743745A92448908E030B2A01EA65B9@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 13 Jul 2007, Luck, Tony wrote:

> > How many tests were done and on what platform?
> 
> Andy's part 0/7 post starts off with the performance numbers.  He
> didn't say which ia64 platform was used for the tests.
> 
> Looking my logs for the last few kernel builds (some built on a
> tiger_defconfig kernel which uses CONFIG_VIRTUAL_MEM_MAP=y, and
> some with the new CONFIG_SPARSEMEM_VMEMMAP) I'd have a tough time
> saying whether there was a regression or not).

I'd be very surprised if there is any difference because the IA64 code for 
virtual memmap is the source of ideas and implementation for SPARSE_VIRTUAL.

