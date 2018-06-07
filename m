Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932843AbeFGQhh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 12:37:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57GYVgw089378
        for <linux-arch@vger.kernel.org>; Thu, 7 Jun 2018 12:37:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf85a0t3b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 12:37:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 17:37:34 +0100
Date: Thu, 07 Jun 2018 22:07:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812783350.10068.4690566636762511152.stgit@devbox>
        <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
        <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
In-Reply-To: <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Message-ID: <1528389409.62iyaqw9yn.naveen@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180607163726.uS3OsKuEBuP1jVxYeCZL3xvkVJBEhBFO_F0Q4LuXHrY@z>

Masami Hiramatsu wrote:
> On Thu, 07 Jun 2018 17:07:00 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> Masami Hiramatsu wrote:
>> > Don't call the ->break_handler() from the arm kprobes code,
>> 					    ^^^ powerpc
>> 
>> > because it was only used by jprobes which got removed.
>> > 
>> > This also makes skip_singlestep() a static function since
>> > only ftrace-kprobe.c is using this function.
>> > 
>> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > ---
>> >  arch/powerpc/include/asm/kprobes.h   |   10 ----------
>> >  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
>> >  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------------
>> >  3 files changed, 14 insertions(+), 43 deletions(-)
>> 
>> With 2 small comments...
> 
> 2 ? or 1 ?

Two, with one in the commit log above :)

- Naveen
