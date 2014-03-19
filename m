From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 00/31] Clean up smp_mb__ barriers
Date: Wed, 19 Mar 2014 09:55:05 +0000
Message-ID: <13632.1395222905@warthog.procyon.org.uk>
References: <20140319064729.660482086@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758137AbaCSJzl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2014 05:55:41 -0400
In-Reply-To: <20140319064729.660482086@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com


Shouldn't the mass-conversion patch (patch 31) go first?

David
