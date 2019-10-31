From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH 0/5] powerpc: make iowrite32be etc. inline
Date: Thu, 31 Oct 2019 08:38:54 +0100
Message-ID: <04799503-b423-6bc8-71cd-bee54e45883e@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 31/10/2019 01.31, Rasmus Villemoes wrote:

> At first I tried something that wouldn't need to touch anything
> outside arch/powerpc/, but I ended up with conditional inclusion of
> asm-generic headers and/or duplicating a lot of their contents.

Urrgh, this is much worse than I feared. Already 1/5 is broken because
asm-generic.h includes asm-generic/iomap.h conditionally, but
asm-generic/pci_iomap.h unconditionally, so now users of io.h with
CONFIG_PCI and !CONFIG_GENERIC_IOMAP get an external declaration of
pci_iounmap they didn't use to, in addition to the static inline defined
in io.h.

And I didn't think 2/5 could break anything - on the premise that if
somebody already have a non-trivial define of ioread16, they couldn't
possibly also include asm-generic/iomap.h. alpha proves me wrong; as
long as one doesn't define ioread16 until after iomap.h has been parsed,
there's no problem (well, except of course if some static inline that
uses ioread16 got parsed between the compiler seeing the extern
declaration and alpha then defining the ioread16 macro, but apparently
that doesn't happen).

So sorry for the noise. Maybe I'll just have to bite the bullet and
introduce private qe_iowrite32be etc. and define them based on $ARCH.
Any better ideas would be much appreciated.

Thanks,
Rasmus
