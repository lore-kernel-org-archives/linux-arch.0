Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:38876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750954AbdFABTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 May 2017 21:19:51 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 76576290232
        for <linux-arch@vger.kernel.org>; Thu,  1 Jun 2017 01:11:58 +0000 (UTC)
Date: Wed, 31 May 2017 21:11:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/12] trace: add the ability to parse sizeof()
Message-ID: <20170531211038.63faa76b@vmware.local.home>
In-Reply-To: <20170531215653.3240-1-jeremy.linton@arm.com>
References: <20170531215653.3240-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, rusty@rustcorp.com.au, jeyu@redhat.com, kirill.shutemov@linux.intel.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, jcm@jonmasters.org
Message-ID: <20170601011140.ufInLeC_iaV82kTCOXx-_gmOaeNK_8-2amRvTWa2jsE@z>


Hi Jeremy,

I'm currently at the Open Source Summit in Tokyo. It may be a while
before I get to look more at this. If I get time during my travels,
I may get to it sooner, otherwise it may be a week or so.

-- Steve

On Wed, 31 May 2017 16:56:41 -0500
Jeremy Linton <jeremy.linton@arm.com> wrote:

> There are a few cases of sizeof() embedded in TRACE_EVENT()
> macros. That is a problem because the sizeof(structure) gets
> passed to userspace which doesn't know how to decode the
> size of kernel data structures. This is a similar problem
> to enums which were being passed in their symbolic form to
> userspace.
> 
> Rather than recreating much of that infrastructure lets
> simply extend it, and append additional symbols into the
> enum_map that can translate string sizeof() calls into
> values. Of course that means that much of the infrastructure
> is now poorly named so we go through and replace instances
> describing "enum" with "eval" to indicate a generic C
> expression to numerical evaluation routine.
> 
> Jeremy Linton (12):
>   trace: rename kernel enum section to eval
>   trace: rename trace_enum_map to trace_eval_map
>   trace: rename struct module entry for trace enums
>   trace: rename trace enum data structures in trace.c
>   trace: rename trace_enum_mutex to trace_eval_mutex
>   trace: rename trace.c enum functions
>   trace: rename enum_map functions
>   tracing: Rename enum_replace to eval_replace
>   tracing: define TRACE_DEFINE_SIZEOF() macro to map sizeof's to their
>     values
>   tracing: Update sample file to describe the new macro
>   tracing: Add TRACE_DEFINE_SIZEOF() macros
>   tracing: Rename update the enum_map file
> 
>  arch/arm64/kvm/trace.h                     |   2 +
>  include/asm-generic/vmlinux.lds.h          |   6 +-
>  include/linux/module.h                     |   4 +-
>  include/linux/tracepoint.h                 |   7 +-
>  include/trace/events/xen.h                 |  13 +-
>  include/trace/trace_events.h               |  26 +++-
>  kernel/module.c                            |   6 +-
>  kernel/trace/Kconfig                       |  22 ++--
>  kernel/trace/trace.c                       | 194
> ++++++++++++++---------------
> kernel/trace/trace.h                       |   4 +-
> kernel/trace/trace_events.c                |  24 ++--
> samples/trace_events/trace-events-sample.h |   7 ++ 12 files changed,
> 175 insertions(+), 140 deletions(-)
> 
