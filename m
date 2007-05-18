Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2545 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbXERUhM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2007 16:37:12 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [rfc] increase struct page size?!
Date: Fri, 18 May 2007 13:37:09 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A017BCA67@scsmsx411.amr.corp.intel.com>
In-Reply-To: <Pine.LNX.4.64.0705181112250.11881@schroedinger.engr.sgi.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> I wonder if there are other uses for the free space?

	unsigned long moreflags;

Nick and Hugh were just sparring over adding a couple (or perhaps 8)
flag bits.  This would supply 64 new bits ... maybe that would keep
them happy for a few more years.

-Tony
