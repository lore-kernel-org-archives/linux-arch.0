Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbeIUL5O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 07:57:14 -0400
Date: Thu, 20 Sep 2018 23:09:41 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] System call table generation support
Message-ID: <20180921060941.GB13865@infradead.org>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
 <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
 <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>, Hauke Mehrtens <hauke@hauke-m.de>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180921060941.jHZcldQTzxkQdPIwQWqN3QnsOdh_6w9EM4zNaMzvCrw@z>

On Thu, Sep 20, 2018 at 08:48:37PM +0000, Paul Burton wrote:
> > Speaking of nanoMIPS, what is your plan for the syscall ABI there?
> > I can see two ways of approaching it:
> > 
> > a) keep all the MIPSisms in the data structures, and just use a subset of
> >     o32 that drops all the obsolete entry points
> > b) start over and stay as close as possible to the generic ABI, using the
> >     asm-generic versions of both the syscall table and the uapi header
> >     files instead of the traditional version.
> 
> We've taken option b in our current downstream kernel & that's what I
> hope we'll get upstream too. There's no expectation that we'll ever need
> to mix pre-nanoMIPS & nanoMIPS ISAs or their associated ABIs across the
> kernel/user boundary so it's felt like a great opportunity to clean up &
> standardise.
> 
> Getting nanoMIPS/p32 support submitted upstream is on my to-do list, but
> there's a bunch of prep work to get in first & of course that to-do list
> is forever growing. Hopefully in the next couple of cycles.

p32 is just the ABI name for nanoMIPS or yet another MIPS ABI?

Either way, І think if there is yet another ABI even on an existing port
we should always aim for the asm-generic syscall table indeed.

Especially for mips where o32 has a rather awkward ABI only explained by
odd decisions more than 20 years ago.
