Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753703AbdLNSVU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Dec 2017 13:21:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20171211070805.07adcb43@canb.auug.org.au>
References: <20171211070805.07adcb43@canb.auug.org.au> <151274828194.9961.4230316917108602662.stgit@warthog.procyon.org.uk> <10228.1512748600@warthog.procyon.org.uk>
Subject: Re: Adding init_task consolidation patches to linux-next
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18930.1513275676.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 14 Dec 2017 18:21:16 +0000
Message-ID: <18931.1513275676@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Message-ID: <20171214182116.ttVTVC8fUG-T0cJDDHdFyqphJLabs7jxnl7Y73hAu2M@z>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I'd be much happier if these patches had any Reviewd-by or Tested-by tags ...

They've now got:

	Tested-by: Tony Luck <tony.luck@intel.com>
	Tested-by: Will Deacon <will.deacon@arm.com> (arm64)

attached.  I've also added riscv support.

David
