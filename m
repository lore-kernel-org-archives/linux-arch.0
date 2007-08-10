Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:1600 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbXHJOlF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Aug 2007 10:41:05 -0400
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 0/5] vmemmap updates to V7
Message-ID: <exportbomb.1186756801@pinky>
Date: Fri, 10 Aug 2007 15:40:01 +0100
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-arch.vger.kernel.org>

Following this email are a five patches which represent the second
batch of feedback on version V5.  These represent a significant
simplification in the configuration options.  There is still the
issue of the contents of memory_model.h to deal with, will look at
that next.

The thrust of this set of changes is to standardise the architecture
interface to vmemmap at the vmemmap_populate() function.  All
architectures implementing this sparsemem variant must implement
this function.  As part of this sparsemem offers several vmemmap
related helper functions to help initialise PUD, PGD, PMD and
PTE pages.  It also offers a standard basepage initialiser.

vmemmap-generify-initialisation-via-helpers
  conversion of the main infrastructure over to a helper based
  system.  General helpers for initialising pte pages are supplied,
  plus a general helper for architectures using base pages.

vmemmap-x86_64-convert-to-new-helper-based-initialisation
vmemmap-ppc64-convert-to-new-config-options
vmemmap-sparc64-convert-to-new-config-options
vmemmap-ia64-convert-to-new-helper-based-initialisation
  conversion of each of the supported architectures to the new helper
  system.  These remain broken out in the expectation that they would
  merge with the main architecture implementations in -mm.

All against 2.6.23-rc2-mm2, in addition to the patches already there.
Again, they are split by architecture as I am assuming they will
slot into the current vmemmap stack before merging up.  They are
not bisectable otherwise.

Andrew please consider for -mm.

-apw
