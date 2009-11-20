Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ultrahosting.com ([74.213.174.254]:36711 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZKTP7K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2009 10:59:10 -0500
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 047D882C340
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 10:50:57 -0500 (EST)
Received: from smtp.ultrahosting.com ([74.213.174.254])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XsL6SO2I4Ul for <linux-arch@vger.kernel.org>;
	Fri, 20 Nov 2009 10:50:50 -0500 (EST)
Received: from V090114053VZO-1 (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 83F4A82C551
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 10:47:02 -0500 (EST)
Date: Fri, 20 Nov 2009 10:43:36 -0500 (EST)
From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 0/6] Numa: Use Generic Per-cpu Variables for
 numa_*_id()
In-Reply-To: <20091113211714.15074.29078.sendpatchset@localhost.localdomain>
Message-ID: <alpine.DEB.1.10.0911201041170.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com
Message-ID: <20091120154336.e19xQjNj1sZOZhLPWvHsMqiWugB6so0-R4G9PF0FVoc@z>

On Fri, 13 Nov 2009, Lee Schermerhorn wrote:

> Ad hoc measurements on x86_64 using:  hackbench 400 process 200
>
> 2.6.32-rc5+mmotm-091101		no patch	this series
> x86_64 avg of 40:		  4.605		  4.628  ~0.5%

Instructions become more efficient here.

> Ia64 showed ~1.2% longer time with the series applied.

IA64 can use the per cpu TLB entry to get to the numa node id with the
platform specific per cpu handling. The per cpu implementation
currently requires fallback. IA64 percpu ops could be reworked to avoid
consulting the per cpu offset arrray which would make it equivalent to the
current implementation.


