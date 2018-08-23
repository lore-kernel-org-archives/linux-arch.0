Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728333AbeHWPCV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Aug 2018 11:02:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBT0qe082018
        for <linux-arch@vger.kernel.org>; Thu, 23 Aug 2018 07:33:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1ugn9nfx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 23 Aug 2018 07:33:02 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <vaibhav@linux.ibm.com>;
        Thu, 23 Aug 2018 12:33:01 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [Skiboot] [PATCH] opal/hmi: Wakeup the cpu before reading core_fir
In-Reply-To: <20180821133842.1b13e972@roar.ozlabs.ibm.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop> <20180820223618.22319-1-paul.burton@mips.com> <20180820223618.22319-2-paul.burton@mips.com> <20180820140605.11846-1-vaibhav@linux.ibm.com> <20180821133842.1b13e972@roar.ozlabs.ibm.com>
Date: Thu, 23 Aug 2018 17:02:51 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <877ekhnwrg.fsf@vajain21.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, Stewart Smith <stewart@linux.ibm.com>, Linux-MIPS <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180823113251.aP4bP9HVopV32kfLnWTTwlEDVCXJ2d0lgBeIcVpjZAg@z>

Thanks for reviewing this patch Nick

Nicholas Piggin <npiggin@gmail.com> writes:
>
> Would it be feasible to enumerate the ranges of scoms that require
> special wakeup and check for those in xscom_read/write, and warn if
> spwkup was not set?
>
I think that might be racy (Vaidy please correct if I am wrong) as a
core can change its state when we read its sleep state and when we do
the actual xscom to read the core_fir.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
