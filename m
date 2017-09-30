Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751357AbdI3JUP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 30 Sep 2017 05:20:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8U9JQeb018090
        for <linux-arch@vger.kernel.org>; Sat, 30 Sep 2017 05:20:14 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2da7smskj6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 30 Sep 2017 05:20:14 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Sat, 30 Sep 2017 10:20:12 +0100
Date: Sat, 30 Sep 2017 11:20:02 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH REBASED 3/6] s390: Add __down_read_killable()
References: <150670038738.23930.7190484711222807884.stgit@localhost.localdomain>
 <150670117817.23930.13068785028558453848.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150670117817.23930.13068785028558453848.stgit@localhost.localdomain>
Message-ID: <20170930092002.GA4623@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com, davem@davemloft.net, rientjes@google.com, viro@zeniv.linux.org.uk
Message-ID: <20170930092002.9V64rRfnohWu-mVf1h5dFx_S85bVq5fQn9KgSCl-H9Y@z>

On Fri, Sep 29, 2017 at 07:06:18PM +0300, Kirill Tkhai wrote:
> Similar to __down_write_killable(), and read killable primitive.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  arch/s390/include/asm/rwsem.h |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/rwsem.h b/arch/s390/include/asm/rwsem.h

FWIW, while looking into this patch I realized that we never optimized our
rwsem primitives to make use of new atomic instructions.

The generic rwsem header file however does, since it uses atomic ops which
we did optimize. Even when compiling for old machines the generic version
generates better code. Therefore I will remove the 15 years old s390
implementation and switch to the generic version instead.

The same might be true for alpha and ia64...
