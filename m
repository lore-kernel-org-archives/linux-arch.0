Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ultrahosting.com ([74.213.174.254]:35510 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbZKTQEK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2009 11:04:10 -0500
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 0621682C4D8
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 10:54:21 -0500 (EST)
Received: from smtp.ultrahosting.com ([74.213.174.254])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id embne41Ipet8 for <linux-arch@vger.kernel.org>;
	Fri, 20 Nov 2009 10:54:14 -0500 (EST)
Received: from V090114053VZO-1 (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 2D1E582C52E
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2009 10:53:32 -0500 (EST)
Date: Fri, 20 Nov 2009 10:50:15 -0500 (EST)
From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH/RFC 3/6] numa:  ia64:  use generic percpu var numa_node_id()
 implementation
In-Reply-To: <20091113211804.15074.12322.sendpatchset@localhost.localdomain>
Message-ID: <alpine.DEB.1.10.0911201049570.25879@V090114053VZO-1>
References: <20091113211714.15074.29078.sendpatchset@localhost.localdomain> <20091113211804.15074.12322.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, Mel Gorman <mel@csn.ul.ie>, Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com
Message-ID: <20091120155015.GBT9pQFcYvwQjGGiR7UDZCk-wVmc-pMv5Fjrwg8kypA@z>


Reviewed-by: Christoph Lameter <cl@linux-foundation.org>


