From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 22:55:15 +0000
Message-ID: <20180104225515.13a40f0f@alans-desktop>
References: <20180103223827.39601-1-mark.rutland@arm.com>
        <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
        <20180104010754.22ca6a74@alans-desktop>
        <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
        <alpine.DEB.2.20.1801040728140.2148@hadrien>
        <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
        <20180104192648.GA10427@amd>
        <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
        <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:47916 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751058AbeADW4r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 17:56:47 -0500
In-Reply-To: <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Pavel Machek <pavel@ucw.cz>, Julia Lawall <julia.lawall@lip6.fr>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

> and the *implementation* might be architecture-specific, but one
> particular implementation would be something like simply
> 
> #define array_access(base, idx, max) ({                         \
>         union { typeof(base[0]) _val; unsigned long _bit; } __u;\
>         unsigned long _i = (idx);                               \
>         unsigned long _m = (max);                               \
>         unsigned long _mask = _i < _m ? ~0 : 0;                 \
>         OPTIMIZER_HIDE_VAR(_mask);                              \
>         __u._val = base[_i & _mask];                            \
>         __u._bit &= _mask;                                      \
>         __u._val; })
> 
> (Ok, the above is not exhaustively tested, but you get the idea, and
> gcc doesn't seem to mess it up *too* badly).

How do you ensure that the CPU doesn't speculate j < _m  ? ~0 : 0 pick the
wrong mask and then reference base[] ?

It's a nice idea but I think we'd need to run it past the various CPU
vendors especially before it was implemented as a generic solution.
Anding with a constant works because the constant doesn't get speculated
and nor does the and with a constant, but you've got a whole additional
conditional path in your macro.

Alan
