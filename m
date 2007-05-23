Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:47885 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755861AbXEWFP1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2007 01:15:27 -0400
Date: Tue, 22 May 2007 22:15:26 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 3/8] Generic Virtual Memmap support for SPARSEMEM V4
In-Reply-To: <E1HqdKD-0003dU-5r@hellhawk.shadowen.org>
Message-ID: <Pine.LNX.4.64.0705222214590.5218@schroedinger.engr.sgi.com>
References: <exportbomb.1179873917@pinky> <E1HqdKD-0003dU-5r@hellhawk.shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

I get a couple of warnings:

mm/sparse.c:423: warning: '__kmalloc_section_memmap' defined but not used
mm/sparse.c:453: warning: '__kfree_section_memmap' defined but not used

when building on IA64


