From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH REBASED 3/6] s390: Add __down_read_killable()
Date: Sat, 30 Sep 2017 12:39:46 +0200
Message-ID: <20170930123946.7bb586c2@mschwideX1>
References: <150670038738.23930.7190484711222807884.stgit@localhost.localdomain>
        <150670117817.23930.13068785028558453848.stgit@localhost.localdomain>
        <20170930092002.GA4623@osiris>
        <20170930123612.0fb250fe@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751160AbdI3Kj6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 30 Sep 2017 06:39:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8UAcw8H096696
        for <linux-arch@vger.kernel.org>; Sat, 30 Sep 2017 06:39:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2da7dvvmw6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sat, 30 Sep 2017 06:39:57 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Sat, 30 Sep 2017 11:39:55 +0100
In-Reply-To: <20170930123612.0fb250fe@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, linux-ia64@vger.kernel.org, avagin@virtuozzo.com, peterz@infradead.org, hpa@zytor.com, gorcunov@virtuozzo.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, mingo@redhat.com, mattst88@gmail.com, fenghua.yu@intel.com, arnd@arndb.de, ink@jurassic.park.msu.ru, tglx@linutronix.de, rth@twiddle.net, tony.luck@intel.com, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, davem@davemloft.net, rientjes@google.com, viro@zeniv.linux.org.uk

On Sat, 30 Sep 2017 12:36:12 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Sat, 30 Sep 2017 11:20:02 +0200
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > On Fri, Sep 29, 2017 at 07:06:18PM +0300, Kirill Tkhai wrote:  
> > > Similar to __down_write_killable(), and read killable primitive.
> > > 
> > > Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> > > ---
> > >  arch/s390/include/asm/rwsem.h |   18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/s390/include/asm/rwsem.h b/arch/s390/include/asm/rwsem.h    
> > 
> > FWIW, while looking into this patch I realized that we never optimized our
> > rwsem primitives to make use of new atomic instructions.
> > 
> > The generic rwsem header file however does, since it uses atomic ops which
> > we did optimize. Even when compiling for old machines the generic version
> > generates better code. Therefore I will remove the 15 years old s390
> > implementation and switch to the generic version instead.  
> 
> Take care not to conflict with the queued spinlock/rwlock patches on the
> features branch. 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=eb3b7b848fb3dd00f7a57d633d4ae4d194aa7865
> 
> Me thinks that what you have in mind is already done.

Argh, pitfall rwlock != rwsem. Using the atomic_ops for the rwsem code makes
a lot of sense. Yes, please..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
