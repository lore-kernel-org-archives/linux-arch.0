Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20853 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935381AbXGMWhu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Jul 2007 18:37:50 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 0/7] Sparsemem Virtual Memmap V5
Date: Fri, 13 Jul 2007 15:37:47 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01EA65B9@scsmsx411.amr.corp.intel.com>
In-Reply-To: <Pine.LNX.4.64.0707131510350.25753@schroedinger.engr.sgi.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

> How many tests were done and on what platform?

Andy's part 0/7 post starts off with the performance numbers.  He
didn't say which ia64 platform was used for the tests.

Looking my logs for the last few kernel builds (some built on a
tiger_defconfig kernel which uses CONFIG_VIRTUAL_MEM_MAP=y, and
some with the new CONFIG_SPARSEMEM_VMEMMAP) I'd have a tough time
saying whether there was a regression or not).

-Tony
