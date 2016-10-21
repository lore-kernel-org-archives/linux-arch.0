Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755913AbcJUPJC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Oct 2016 11:09:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9LF4Ysw124105
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2016 11:09:01 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2675yjprtu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2016 11:09:01 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 21 Oct 2016 16:08:59 +0100
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <20161021.105727.140184460493941551.davem@davemloft.net>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Oct 2016 17:08:54 +0200
MIME-Version: 1.0
In-Reply-To: <20161021.105727.140184460493941551.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-ID: <2cf23cb7-05c5-0a2d-2ed5-aa90d582f802@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: peterz@infradead.org, npiggin@gmail.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, noamc@ezchip.com, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, KVM list <kvm@vger.kernel.org>
Message-ID: <20161021150854.fbPyINSv9RGiXIbeN7yRJ7MyqnEwgRrfQHJj0OTqMW4@z>

On 10/21/2016 04:57 PM, David Miller wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> Date: Fri, 21 Oct 2016 13:58:53 +0200
> 
>> For spinning loops people did often use barrier() or cpu_relax().
>> For most architectures cpu_relax and barrier are the same, but on
>> some architectures cpu_relax can add some latency. For example on s390
>> cpu_relax gives up the time slice to the hypervisor. On power cpu_relax
>> tries to give some of the CPU to the neighbor threads. To reduce the
>> latency another variant cpu_relax_lowlatency was introduced. Before this
>> is used in more and more places, lets revert the logic of provide a new
>> function cpu_relax_yield that can spend some time and for s390 yields
>> the guest CPU.
> 
> Sparc64, fwiw, behaves similarly to powerpc.

As sparc currently defines cpu_relax_lowlatency to cpu_relax, this patch set
should be a no-op then for sparc, correct?

My intend was that cpu_relax should not add a huge latency but can certainly
push some cpu power to hardware threads of the same core. This seems to be
the case for sparc/power and some arc variants. 

Christian



