Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbeH2Tn6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Aug 2018 15:43:58 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D2720647
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 15:46:26 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id v90-v6so5305733wrc.0
        for <linux-arch@vger.kernel.org>; Wed, 29 Aug 2018 08:46:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180829092839.GP24124@hirez.programming.kicks-ass.net>
References: <20180829081147.184610-1-namit@vmware.com> <20180829081147.184610-6-namit@vmware.com>
 <20180829092839.GP24124@hirez.programming.kicks-ass.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 29 Aug 2018 08:46:04 -0700
Message-ID: <CALCETrXe9CUMo3c44UtmkxD4w68PvmoypdCyvCFvWiZVuxy=sQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] x86/alternatives: use temporary mm for text poking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>
Message-ID: <20180829154604.1wtwEM2T8Q1a6hxbz0IWq2IInj4POLCijfXq4Rj7cng@z>

On Wed, Aug 29, 2018 at 2:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Aug 29, 2018 at 01:11:46AM -0700, Nadav Amit wrote:

>> +     pte_clear(poking_mm, poking_addr, ptep);
>> +
>> +     /*
>> +      * __flush_tlb_one_user() performs a redundant TLB flush when PTI is on,
>> +      * as it also flushes the corresponding "user" address spaces, which
>> +      * does not exist.
>> +      *
>> +      * Poking, however, is already very inefficient since it does not try to
>> +      * batch updates, so we ignore this problem for the time being.
>> +      *
>> +      * Since the PTEs do not exist in other kernel address-spaces, we do
>> +      * not use __flush_tlb_one_kernel(), which when PTI is on would cause
>> +      * more unwarranted TLB flushes.
>> +      */
>
> yuck :-), but yeah.

I'm sure we covered this ad nauseum when PTI was being developed, but
we were kind of in a rush, so:

Why do we do INVPCID at all?  The fallback path for non-INVPCID
systems uses invalidate_user_asid(), which should be faster than the
invpcid path.  And doesn't do a redundant flush in this case.

Can we just drop the INVPCID?  While we're at it, we could drop
X86_FEATURE_INVPCID_SINGLE entirely, since that's the only user.

--Andy
