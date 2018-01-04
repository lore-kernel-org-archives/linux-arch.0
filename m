From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 14:23:25 -0800
Message-ID: <CA+55aFxOewuXpjKv02wufoBbEHOssTvTOL4iw6PAf3ypSvCKOQ@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien> <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd> <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
 <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:38072 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeADWX1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 17:23:27 -0500
In-Reply-To: <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jan 4, 2018 at 2:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
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

That

    __u._val = base[_i & _mask];

thing would have to be READ_ONCE() to make it all ok for the special
cases without locking etc.

              Linus
