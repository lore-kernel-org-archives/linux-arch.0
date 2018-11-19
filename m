Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405343AbeKTDYi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Nov 2018 22:24:38 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0F47224E0
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 17:00:22 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id k198so5551971wmd.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Nov 2018 09:00:22 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <20181118071548.GA4795@linux.intel.com> <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
 <20181119160204.GD13298@linux.intel.com>
In-Reply-To: <20181119160204.GD13298@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 19 Nov 2018 09:00:08 -0800
Message-ID: <CALCETrWRVgPjnDd-CknskrXfNbke=rSnr_jezszNNWJUM_YJKQ@mail.gmail.com>
Subject: Re: RFC: userspace exception fixups
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Christopherson, Sean J" <sean.j.christopherson@intel.com>, Jethro Beekman <jethro@fortanix.com>, Florian Weimer <fweimer@redhat.com>, Linux API <linux-api@vger.kernel.org>, Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rich Felker <dalias@libc.org>, nhorman@redhat.com, npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Message-ID: <20181119170008.oaqWNl_hBT22sHCxvjJ6njhGY2yFan4iXADP645Fs6A@z>

On Mon, Nov 19, 2018 at 8:02 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Nov 19, 2018 at 07:29:36AM -0800, Andy Lutomirski wrote:
> > 1. The kernel needs some way to know *when* to apply this fixup.
> > Decoding the instruction stream and doing it to all exceptions that
> > hit an ENCLU instruction seems like a poor design.
>
> I'm not sure why you would ever need to do any type of fixup as the idea
> is to just return to AEP i.e. from chosen exceptions (EPCM, #UD) the AEP
> would work the same way as for exceptions that the kernel can deal with
> except filling the exception information to registers.

Sure, but how does the kernel know when to do that and when to send a
signal?  I don't really like decoding the instruction stream to figure
it out.
