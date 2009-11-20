Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ultrahosting.com ([74.213.174.254]:34413 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbZKTQHQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2009 11:07:16 -0500
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id C7FEF82C506
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 11:07:22 -0500 (EST)
Received: from smtp.ultrahosting.com ([74.213.174.254])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lPMZiybPxZ6q for <linux-arch@vger.kernel.org>;
	Fri, 20 Nov 2009 11:07:16 -0500 (EST)
Received: from V090114053VZO-1 (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id ECBA882C302
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 10:50:19 -0500 (EST)
Date: Fri, 20 Nov 2009 10:46:49 -0500 (EST)
From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 1/6] numa: Use Generic Per-cpu Variables for
 numa_node_id()
In-Reply-To: <20091113211720.15074.99808.sendpatchset@localhost.localdomain>
Message-ID: <alpine.DEB.1.10.0911201044320.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain> <20091113211720.15074.99808.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com, Tejun Heo <tj@kernel.org>
Message-ID: <20091120154649.oejbBwWVGxbwF8i6g8Yz-HxT4e4B32Tp2tpXIV_vUtw@z>

On Fri, 13 Nov 2009, Lee Schermerhorn wrote:

> Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
> [Christoph's signoff here?]

Basically yes. The moving of the this_cpu ops to asm-generic is something
that is bothering me. Tejun?
