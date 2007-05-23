Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:47793 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756044AbXEWFMR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2007 01:12:17 -0400
Date: Tue, 22 May 2007 22:12:15 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 5/8] IA64: SPARSEMEM_VMEMMAP 16K page size support
In-Reply-To: <E1HqdLD-0003fb-PF@hellhawk.shadowen.org>
Message-ID: <Pine.LNX.4.64.0705222209250.3180@schroedinger.engr.sgi.com>
References: <exportbomb.1179873917@pinky> <E1HqdLD-0003fb-PF@hellhawk.shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

Works fine as is with patch on top of 2.6.22-rc2 here...
