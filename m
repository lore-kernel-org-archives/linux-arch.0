Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729759AbeKTBxr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Nov 2018 20:53:47 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EB7214C1
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 15:29:50 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id j17-v6so32498197wrq.11
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 07:29:50 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <20181118071548.GA4795@linux.intel.com>
In-Reply-To: <20181118071548.GA4795@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 19 Nov 2018 07:29:36 -0800
Message-ID: <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Christopherson, Sean J" <sean.j.christopherson@intel.com>, Jethro Beekman <jethro@fortanix.com>, Florian Weimer <fweimer@redhat.com>, Linux API <linux-api@vger.kernel.org>, Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rich Felker <dalias@libc.org>, nhorman@redhat.com, npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Message-ID: <20181119152936.AKhYVSRJ6OlOPbqmtUhejrIvNLSZ-ETulJ7GBTOMIh0@z>

On Sat, Nov 17, 2018 at 11:16 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Nov 01, 2018 at 10:53:40AM -0700, Andy Lutomirski wrote:
> > Hi all-
> >
> > The people working on SGX enablement are grappling with a somewhat
> > annoying issue: the x86 EENTER instruction is used from user code and
> > can, as part of its normal-ish operation, raise an exception.  It is
> > also highly likely to be used from a library, and signal handling in
> > libraries is unpleasant at best.
> >
> > There's been some discussion of adding a vDSO entry point to wrap
> > EENTER and do something sensible with the exceptions, but I'm
> > wondering if a more general mechanism would be helpful.
>
> I haven't really followed all of this discussion because I've been busy
> working on the patch set but for me all of these approaches look awfully
> complicated.
>
> I'll throw my own suggestion and apologize if this has been already
> suggested and discarded: return-to-AEP.
>
> My idea is to do just a small extension to SGX AEX handling. At the
> moment hardware will RAX, RBX and RCX with ERESUME parameters. We can
> fill extend this by filling other three spare registers with exception
> information.

I have two issues with this approach:

1. The kernel needs some way to know *when* to apply this fixup.
Decoding the instruction stream and doing it to all exceptions that
hit an ENCLU instruction seems like a poor design.

2. It starts exposing what looks like a more generic exception
handling mechanism to userspace, except that it's nonsensical for
anything other than ENCLU.
