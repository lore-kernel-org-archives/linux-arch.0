From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Thu, 10 Mar 2016 22:47:55 -0800
Message-ID: <CALCETrUQsf7S-b+zDrof0g61NnSB3XuqdAxjsHyJfjT3D39D3Q@mail.gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33018 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068AbcCKGsQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 01:48:16 -0500
Received: by mail-oi0-f41.google.com with SMTP id d205so79188600oia.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Mar 2016 22:48:16 -0800 (PST)
In-Reply-To: <1457370228.15454.311.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Mon, Mar 7, 2016 at 9:03 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> Let me try to summarize...
>
> The original issue Luis brought up was that drivers written to work with
> MTRR may create a single ioremap range covering multiple cache attributes
> since MTRR can overwrite cache attribute of a certain range.  Converting
> such drivers with PAT-based ioremap interfaces, i.e. ioremap_wc() and
> ioremap_nocache(), requires a separate ioremap map for each cache
> attribute, which can be challenging as it may result in overlapping ioremap
> ranges (in his term) with different cache attributes.
>
> So, Luis asked about 'sematics of overlapping ioremap()' calls.  Hence, I
> responded that aliasing mapping itself is supported, but alias with
> different cache attribute is not.  We have checks in place to detect such
> condition.  Overlapping ioremap calls with a different cache attribute
> either fails or gets redirected to the existing cache attribute on x86.

A little off-topic, but someone reminded me recently: most recent CPUs
have self-snoop.  It's poorly documented, but on self-snooping CPUs, I
think that a lot of the aliasing issues go away.  We may be able to
optimize the code quite a bit on these CPUs.

I also wonder whether we can drop a bunch of the memtype tracking.
After all, if we have aliases of different types on a self-snooping
CPU and /dev/mem is locked down hard enough, we could maybe get away
with letting self-snoop handle all the conflicts.

(We could also make /dev/mem always do UC if it would help.)

--Andy
