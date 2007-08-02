Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:3185 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbXHBJMe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 05:12:34 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 0/4] vmemmap updates to V6
Message-ID: <exportbomb.1186045945@pinky>
Date: Thu, 02 Aug 2007 10:24:33 +0100
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>

Following this email are a four patches which represent the first
batch of feedback on version V5.  I have some additional config
simplifications in test at the moment, and we probabally need to
move memory_model.h.

vmemmap-remove-excess-debugging -- remove some verbose and mostly
  unhelpful debugging.

vmemmap-simplify-initialisation-code-and-reduce-duplication -- clean
  up section initialisaion to simplify pulling out the vmemmap code.

vmemmap-pull-out-the-vmemmap-code-into-its-own-file -- pull out the
  vmemmap code into its own file.

vmemmap-ppc64-convert-VMM_*-macros-to-a-real-function -- replace
  some macros with an inline function to improve type safety.

The first three should be considered as fixes the patch below,
the last against the ppc64 support:

	generic-virtual-memmap-support-for-sparsemem

All against 2.6.23-rc1-mm2.

Andrew please consider for -mm.  (I found that merging the patch
below into its parent patch before sliding these into the tree made
the rejects must simpler.)

  fix-corruption-of-memmap-on-ia64-sparsemem-when-mem_section-is-not-a-power-of-2-fix.patch

-apw
