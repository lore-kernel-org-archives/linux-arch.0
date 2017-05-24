Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S937631AbdEXJQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 May 2017 05:16:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v4O98bk6116043
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2017 05:16:07 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2an78mrckg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 24 May 2017 05:16:06 -0400
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 24 May 2017 03:16:05 -0600
Subject: Re: is alpha jensen support dead?
References: <20170521085848.GA14559@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 24 May 2017 11:16:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170521085848.GA14559@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-ID: <11c44626-d496-ec77-c294-1d734d6125aa@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20170524091601.jxiH-j7a7pKdif6KvDPLC-6gDGhvCZuJS0mvIyKJ_jg@z>

On 05/21/2017 10:58 AM, Christoph Hellwig wrote:
> Hi all,
> 
> it seems like the Alpha Jense build (the only one using pci-noop.c)
> and thus being a different build than all the later PCI capable
> system has been broken since at least:
> 
> commit 6aca0503847f6329460b15b3ab2b0e30bb752793
> Author: Christian Borntraeger <borntraeger@de.ibm.com>
> Date:   Tue Feb 2 21:46:33 2016 -0800
> 
>     alpha/dma: use common noop dma ops
> 

Hi Christoph,

are you providing a fix (or a jensen removal) or do you expect a fix from me?


> which switches pci-noop.c to use generic code, but fat fingered a symbol
> and didn't wire up the Kconfig.
> 
> Is there any value in keeping it alive?  Especially as there probably
> isn't any build coverage..
> 
> Btw, how well is alpha working these days?  It looks like there hasn't
> been any maintainer activity for about two years.
> 
