Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932188AbeFGLbe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jun 2018 07:31:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w57BTSmg032223
        for <linux-arch@vger.kernel.org>; Thu, 7 Jun 2018 07:31:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jf1yx5j8c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 07 Jun 2018 07:31:33 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 7 Jun 2018 12:31:31 +0100
Date: Thu, 07 Jun 2018 17:01:23 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 07/27] powerpc/kprobes: Remove jprobe powerpc
 implementation
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812751377.10068.6090934299713110701.stgit@devbox>
In-Reply-To: <152812751377.10068.6090934299713110701.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Message-ID: <1528370755.shi1gq6h7g.naveen@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20180607113123.2T6dxjKeXomLMZqZWZl-qUlrYU_jAFKm3YzIjVEkHi4@z>

Masami Hiramatsu wrote:
> Remove arch dependent setjump/longjump functions
> and unused fields in kprobe_ctlblk for jprobes
> from arch/powerpc. This also reverts commits
> related __is_active_jprobe() function.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/include/asm/kprobes.h             |    2 -
>  arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
>  arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
>  4 files changed, 5 insertions(+), 105 deletions(-)

LGTM.

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen
