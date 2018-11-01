Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40929 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeKBESD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 00:18:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id n3-v6so14996033lfe.7
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2018 12:13:46 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m64-v6sm34387lfm.89.2018.11.01.12.13.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 12:13:44 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s15-v6so19072350lji.3
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2018 12:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
In-Reply-To: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Nov 2018 12:06:21 -0700
Message-ID: <CAHk-=wjJhdr3JCnGrMKqL-prxYd__kkAspKVYBO3BYYmq2hu4A@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: luto@kernel.org
Cc: dave.hansen@linux.intel.com, sean.j.christopherson@intel.com, jethro@fortanix.com, jarkko.sakkinen@linux.intel.com, fweimer@redhat.com, linux-api@vger.kernel.org, Jann Horn <jannh@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, dalias@libc.org, nhorman@redhat.com, npmccallum@redhat.com, serge.ayoun@intel.com, shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org, andriy.shevchenko@linux.intel.com, tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de
Message-ID: <20181101190621.jNk8IdhdbWpE-I4py0DHeg1IywPeym8Abq035-2Tmtw@z>

On Thu, Nov 1, 2018 at 10:53 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> There's been some discussion of adding a vDSO entry point to wrap
> EENTER and do something sensible with the exceptions,

I think that's likely the right thing to do, and would be similar to sysenter.

> The basic idea would be to allow libc, or maybe even any library, to
> register a handler that gets a chance to act on an exception caused by
> a user instruction before a signal is delivered.  As a straw-man
> example for how this could work, there could be a new syscall:
>
> long register_exception_handler(void (*handler)(int, siginfo_t *, void *));

I'm not a huge fan of signals, but the above is an abomination.

It has all the problems of signals _and_ then some.

And it in absolutely no way fixes the problem with libraires. In fact,
it arguably makes it much much worse, since now there's only one
single library that can register it.

Yes yes, maybe a library would then expose _another_ interface to
other libraries and act as some kind of dispatch point, but on the
whole the above is just crazy and fundamentally broken.

If you want to register an exception, you need to make it clear

 (a) which _thread_ the exception registration is valid for

 (b) which _range_ the exception registration is valid for

 (c) which _fault_ the exception registration is valid for (page
fault, div-by-zero, whatever)

 (d) which save area (aka stack) and exception handler point.

Note that (b) might be more than just an exception IP range. It might
well be interesting to register the exception by page fault address
(in addition to code range).

If you do something that does all of (a)-(d), and you allow some
limited number of exception registrations, then maybe. Because at that
point, you have something that is actually actively more powerful than
signal handling is.

But your suggested "just register a broken form of signal handling for
a special case" is just wrong. Don't do it.

              Linus
