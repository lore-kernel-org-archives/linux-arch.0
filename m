From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Sat, 16 Apr 2016 11:20:18 +0200
Message-ID: <20160416092018.GA8453@gmail.com>
References: <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
 <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com>
 <20160309091525.GA11866@gmail.com>
 <1457734432.6393.199.camel@hpe.com>
 <20160316014548.GK1990@wotan.suse.de>
 <1458254693.6393.506.camel@hpe.com>
 <20160413211638.GF1990@wotan.suse.de>
 <1460731649.24985.86.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460731649.24985.86.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Julia Lawall <julia.lawall@lip6.fr>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
List-Id: linux-arch.vger.kernel.org


* Toshi Kani <toshi.kani@hpe.com> wrote:

> On x86, ioremap() and remap_pfn_range() already fail on a conflicting=
 cache
> type if it is not allowed by the rule defined in is_new_memtype_allow=
ed().
> =A0This exception handling is necessary for remap_pfn_range() called =
by
> /dev/mem, but I do not think it's necessary for ioremap(). =A0I think=
 we can
> start from adding a warning message to ioremap().

Agreed, we should warn and map the situation before doing any behaviora=
l change=20
that isn't a fix.

Thanks,

	Ingo
