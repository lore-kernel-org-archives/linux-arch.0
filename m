From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFCv2 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Fri, 5 Jan 2018 08:38:43 -0800
Message-ID: <CAPcyv4hUAzCxH4sQAJgocFZ4RN2s6P_6+PO5xqYXU5R+O=coUQ@mail.gmail.com>
References: <20180105145750.53294-1-mark.rutland@arm.com> <20180105145750.53294-5-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46831 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeAEQio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jan 2018 11:38:44 -0500
Received: by mail-oi0-f67.google.com with SMTP id t81so3442393oih.13
        for <linux-arch@vger.kernel.org>; Fri, 05 Jan 2018 08:38:44 -0800 (PST)
In-Reply-To: <20180105145750.53294-5-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Elena Reshetova <elena.reshetova@intel.com>, Jonathan Corbet <corbet@lwn.net>, Alan Cox <alan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jan 5, 2018 at 6:57 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Note: this patch is an *example* use of the nospec API. It is understood
> that this is incomplete, etc.
>
> Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> memory accesses under a bounds check may be speculated even if the
> bounds check fails, providing a primitive for building a side channel.
>
> The EBPF map code has a number of such bounds-checks accesses in
> map_lookup_elem implementations. This patch modifies these to use the
> nospec helpers to inhibit such side channels.
>
> The JITted lookup_elem implementations remain potentially vulnerable,
> and are disabled (with JITted code falling back to the C
> implementations).

Do we still need this given this patch from the bpf folks:

    https://patchwork.ozlabs.org/patch/855911/

?
