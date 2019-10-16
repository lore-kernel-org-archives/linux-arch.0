Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41822 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJPRER (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 13:04:17 -0400
Received: by mail-oi1-f195.google.com with SMTP id g81so2486974oib.8
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 10:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-9-elver@google.com>
 <ce0d1658-c000-be20-c997-34ca488e4406@intel.com>
In-Reply-To: <ce0d1658-c000-be20-c997-34ca488e4406@intel.com>
From: Marco Elver <elver@google.com>
Date: Wed, 16 Oct 2019 19:04:05 +0200
Message-ID: <CANpmjNOjJsqEtS5jrZ66f3RQSEASjG-N9oMQ377KhmoWJycxXA@mail.gmail.com>
Subject: Re: [PATCH 8/8] x86, kcsan: Enable KCSAN for x86
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, dave.hansen@linux.intel.com, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191016170405.LGnim4onisCyW_870ny82SSEKB1unhxgus_P0gbfeOM@z>

On Wed, 16 Oct 2019 at 18:14, Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 10/16/19 1:39 AM, Marco Elver wrote:
> > This patch enables KCSAN for x86, with updates to build rules to not use
> > KCSAN for several incompatible compilation units.
>
> First of all KCSAN looks really interesting!
>
> For the x86 code, though, I'd really appreciate some specific notes on
> why individual compilation units are incompatible.  There might be some
> that were missed, and we have to figure out what we do for any future
> work.  Knowing the logic used on these would be really helpful in the
> future.

Thanks!  I will add comments where I can for v2. For most of them, I
followed the examples of KASAN and co, and will try to reevaluate each
one.

-- Marco
