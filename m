Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:54817 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750733AbWIOIZM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 04:25:12 -0400
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id k8F8PBHt152566
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 08:25:11 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8F8RMq71482978
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 09:27:22 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8F8PAbH027570
	for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2006 09:25:10 +0100
Subject: Re: [PATCH] [2/5] Fix 'make headers_check' on s390 for 2.6.18
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <1158273343.4312.141.camel@pmac.infradead.org>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
	 <1158273343.4312.141.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 10:25:09 +0200
Message-Id: <1158308709.23993.0.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2006-09-14 at 23:35 +0100, David Woodhouse wrote:
> > asm-s390/debug.h requires linux/string.h, which does not exist
> > asm-s390/elf.h requires asm/system.h, which does not exist 
> 
> Move things around slightly so the right things end up within 
> #ifdef __KERNEL__ and thus don't pollute the exported headers.

Thanks David, looks good.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


