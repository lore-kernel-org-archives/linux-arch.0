Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49357 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751449AbcKHMFu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2016 07:05:50 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA8C3we9092971
        for <linux-arch@vger.kernel.org>; Tue, 8 Nov 2016 07:05:49 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26kd9m5nsh-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 08 Nov 2016 07:05:49 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 8 Nov 2016 12:05:48 -0000
Date: Tue, 8 Nov 2016 13:05:42 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] mm: only enable sys_pkey* when ARCH_HAS_PKEYS
References: <1477958904-9903-1-git-send-email-mark.rutland@arm.com>
 <20161104234459.GA18760@remoulade>
 <20161108093042.GC3528@osiris>
 <1596342.1rV5HksyDO@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596342.1rV5HksyDO@wuerfel>
Message-ID: <20161108120542.GG3528@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, Russell King <rmk+kernel@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org
Message-ID: <20161108120542.Z2QdSXEli2L-nrUEpV9BkmfUHJN4w3ssq564zxxymkw@z>

On Tue, Nov 08, 2016 at 12:39:28PM +0100, Arnd Bergmann wrote:
> On Tuesday, November 8, 2016 10:30:42 AM CET Heiko Carstens wrote:
> > Three architectures (parisc, powerpc, s390) decided to ignore the system
> > calls completely, but still have the pkey code linked into the kernel
> > image.
> 
> Wouldn't it actually make sense to hook this up to the storage keys
> in the s390 page tables?

We have storage keys per _physical_ page. Not per page within the the table
entries. So this doesn't work unfortunately.

