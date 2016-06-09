From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] bitmap_equal memcmp optimization for s390
Date: Thu, 09 Jun 2016 15:26:47 +0100
Message-ID: <28415.1465482407@warthog.procyon.org.uk>
References: <201606070837.u578Y1R5037289@mx0a-001b2d01.pphosted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47540 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbcFIO0u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Jun 2016 10:26:50 -0400
In-Reply-To: <201606070837.u578Y1R5037289@mx0a-001b2d01.pphosted.com>
Content-ID: <28414.1465482407.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> I hesitate to put another CONFIG_S390 into common code, alternatively
> __HAVE_ARCH_MEMCMP could be used. There are 7 architectures with the
> define: arc, arm64, blackfin, frv, powerpc, s390 and sparc.
> Of those I guess only powerpc, s390 and sparc will have configs with
> (NR_CPUS > BITS_PER_LONG). For (NR_CPUS <= BITS_PER_LONG) the xor
> optimization is used.

FRV doesn't have __HAVE_ARCH_MEMCMP for __KERNEL__.

David
