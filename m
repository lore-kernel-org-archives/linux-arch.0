Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12370 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932069AbcFIOqP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2016 10:46:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u59Ehdks114639
	for <linux-arch@vger.kernel.org>; Thu, 9 Jun 2016 10:46:14 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23e9m4p0sq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 09 Jun 2016 10:46:13 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 9 Jun 2016 15:46:12 +0100
Date: Thu, 9 Jun 2016 16:45:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] bitmap_equal memcmp optimization for s390
In-Reply-To: <28415.1465482407@warthog.procyon.org.uk>
References: <201606070837.u578Y1R5037289@mx0a-001b2d01.pphosted.com>
	<28415.1465482407@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20160609164532.23f05026@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20160609144532.CQhrcQq0ctjdrPgC2rb7JrBT9_srTN17l7BZajURxt0@z>

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

