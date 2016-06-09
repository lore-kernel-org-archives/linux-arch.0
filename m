From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] bitmap_equal memcmp optimization for s390
Date: Thu, 9 Jun 2016 16:45:32 +0200
Message-ID: <20160609164532.23f05026@mschwide>
References: <201606070837.u578Y1R5037289@mx0a-001b2d01.pphosted.com>
	<28415.1465482407@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <28415.1465482407@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Thu, 09 Jun 2016 15:26:47 +0100
David Howells <dhowells@redhat.com> wrote:

> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> 
> > I hesitate to put another CONFIG_S390 into common code, alternatively
> > __HAVE_ARCH_MEMCMP could be used. There are 7 architectures with the
> > define: arc, arm64, blackfin, frv, powerpc, s390 and sparc.
> > Of those I guess only powerpc, s390 and sparc will have configs with
> > (NR_CPUS > BITS_PER_LONG). For (NR_CPUS <= BITS_PER_LONG) the xor
> > optimization is used.
> 
> FRV doesn't have __HAVE_ARCH_MEMCMP for __KERNEL__.

Yes indeed. How strange to define __HAVE_ARCH_xxx for user space only.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
