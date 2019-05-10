Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbfEJQdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 12:33:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AGLYuq020645
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 12:33:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sdb4xcrha-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 12:33:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 10 May 2019 17:33:08 +0100
Date: Fri, 10 May 2019 18:32:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing
 addresses
In-Reply-To: <20190510122401.21a598f6@gandalf.local.home>
References: <20190510081635.GA4533@jagdpanzerIV>
        <20190510084213.22149-1-pmladek@suse.com>
        <20190510122401.21a598f6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20190510183258.1f6c4153@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Message-ID: <20190510163258.qn3246r2dHdhqWhvmxZO4mIbhuwcSMjfnXQQlH0ZaHs@z>

On Fri, 10 May 2019 12:24:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 10 May 2019 10:42:13 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> >  static const char *check_pointer_msg(const void *ptr)
> >  {
> > -	char byte;
> > -
> >  	if (!ptr)
> >  		return "(null)";
> >  
> > -	if (probe_kernel_address(ptr, byte))
> > +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> >  		return "(efault)";
> >    
> 
> 
> 	< PAGE_SIZE ?
> 
> do you mean: < TASK_SIZE ?

The check with < TASK_SIZE would break on s390. The 'ptr' is
in the kernel address space, *not* in the user address space.
Remember s390 has two separate address spaces for kernel/user
the check < TASK_SIZE only makes sense with a __user pointer.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
