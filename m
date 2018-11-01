Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38017 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeKBG32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 02:29:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id p86so13042730lfg.5
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2018 14:24:46 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id o72sm4948114lfg.33.2018.11.01.14.24.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 14:24:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id x85-v6so15183508ljb.2
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2018 14:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <CAG48ez0vBqL0tyfWwmuc_cq+OAUoEi88=r+t6h64a-Fw8z59zA@mail.gmail.com>
 <20181101185225.GC5150@brightrain.aerifal.cx> <CAHk-=wgFo8tuZX5gzCfWGdAwGyn_Ar9JFnnMFNuwr9=vtfDV1g@mail.gmail.com>
 <20181101193107.GE5150@brightrain.aerifal.cx>
In-Reply-To: <20181101193107.GE5150@brightrain.aerifal.cx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Nov 2018 14:24:26 -0700
Message-ID: <CAHk-=wiYSpmDOfpi9n7ETsxK2UrUKfT4kM=Y3yqRSaZuFFPY1A@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dalias@libc.org
Cc: Jann Horn <jannh@google.com>, luto@kernel.org, dave.hansen@linux.intel.com, sean.j.christopherson@intel.com, jethro@fortanix.com, jarkko.sakkinen@linux.intel.com, fweimer@redhat.com, linux-api@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com, shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org, andriy.shevchenko@linux.intel.com, tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de, carlos@redhat.com, adhemerval.zanella@linaro.org
Message-ID: <20181101212426.N76a0xYN6sc6H2NTEQMC5Y0Lpy0Dt_Yx9R_d_Sj2udI@z>

On Thu, Nov 1, 2018 at 12:31 PM Rich Felker <dalias@libc.org> wrote:
>
> See my other emails in this thread. You would register the *address*
> (in TLS) of a function pointer object pointing to the handler, rather
> than the function address of the handler. Then switching handler is
> just a single store in userspace, no syscalls involved.

Yes.

And for just EENTER, maybe that's the right model.

If we want to generalize it to other thread-synchronous faults, it
needs way more information and a list of handlers, but if we limit the
thing to _only_ EENTER getting an SGX fault, then a single "this is
the fault handler" address is probably the right thing to do.

                     Linus
