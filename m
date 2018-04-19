Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753477AbeDSOVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Apr 2018 10:21:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JEKRDU145005
        for <linux-arch@vger.kernel.org>; Thu, 19 Apr 2018 10:21:03 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hevep9aps-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 19 Apr 2018 10:21:03 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 19 Apr 2018 15:21:01 +0100
Date: Thu, 19 Apr 2018 16:20:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH] s390: add arch_change_pid for arch updates after
 task pid change
In-Reply-To: <20180419140729.GA19917@redhat.com>
References: <1524120286-19066-1-git-send-email-schwidefsky@de.ibm.com>
        <20180419140729.GA19917@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20180419162056.6b657d71@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, 19 Apr 2018 16:07:29 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 04/19, Martin Schwidefsky wrote:
> >
> > In a multi-threaded program any thread can call execve(). If this
> > is not done by the thread group leader, the de_thread() function
> > replaces the pid of the task that calls execve() with the pid of
> > thread group leader. If the task reaches user space again without
> > going over __switch_to() the sampling tag is still set to the old
> > pid.  
> 
> If this is the only reason for arch_change_pid() hook, then perhaps
> it would be better/simpler to add it into de_thread() right after
> change_pid(tsk, PIDTYPE_PID, task_pid(leader)) ?
> 
> note also that this way arch_change_pid() doesn't need any checks and
> any arguments, you can simply do
> 
> void arch_change_pid(void)
> {
> 	S390_lowcore.current_pid = current->pid;
> 	if (test_facility(40))
> 		lpp(&S390_lowcore.lpp);
> }

Yeah, the first patch I created to verify that this indeed the problem
basically looked like your proposal. But then why not make it a more
general hook for any kind of PID change? Dunno if this is a worthwhile
approach, the simpler version for sure works as well.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
