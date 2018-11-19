Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:27569 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbeKTC0N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Nov 2018 21:26:13 -0500
Date: Mon, 19 Nov 2018 18:02:04 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: RFC: userspace exception fixups
Message-ID: <20181119160204.GD13298@linux.intel.com>
References: <CALCETrWdpoDkbZjkucKL91GWpDPG9p=VqYrULade2pFDR7S=GQ@mail.gmail.com>
 <20181118071548.GA4795@linux.intel.com>
 <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXSpn7QGzPgO1BjMRQ75r2i0kmACrbUM+8PyT+xi3f3Hw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "Christopherson, Sean J" <sean.j.christopherson@intel.com>, Jethro Beekman <jethro@fortanix.com>, Florian Weimer <fweimer@redhat.com>, Linux API <linux-api@vger.kernel.org>, Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rich Felker <dalias@libc.org>, nhorman@redhat.com, npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Message-ID: <20181119160204.14dmVsASs8_6XGMY-jD6hEucwMpx3FcGwqEy84fxE6E@z>

On Mon, Nov 19, 2018 at 07:29:36AM -0800, Andy Lutomirski wrote:
> 1. The kernel needs some way to know *when* to apply this fixup.
> Decoding the instruction stream and doing it to all exceptions that
> hit an ENCLU instruction seems like a poor design.

I'm not sure why you would ever need to do any type of fixup as the idea
is to just return to AEP i.e. from chosen exceptions (EPCM, #UD) the AEP
would work the same way as for exceptions that the kernel can deal with
except filling the exception information to registers.

> 2. It starts exposing what looks like a more generic exception
> handling mechanism to userspace, except that it's nonsensical for
> anything other than ENCLU.

Well, I see the user space and namely the run-time the host for the
enclave i.e. middle-man to provide services for emulating instructions
etc.

/Jarkko
