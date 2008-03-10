From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture: fixes headers_install
Date: Mon, 10 Mar 2008 12:23:02 +0100
Message-ID: <200803101223.03712.arnd@arndb.de>
References: <200803071326.06682.borntraeger@de.ibm.com> <1204933418.2495.14.camel@shinybook.infradead.org> <200803100913.46422.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753251AbYCJLYL@vger.kernel.org>
In-Reply-To: <200803100913.46422.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Avi Kivity <avi@qumranet.com>, Sam Ravnborg <sam@ravnborg.org>, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 10 March 2008, Christian Borntraeger wrote:
> =A0include/asm-alpha/Kbuild =A0 =A0 | =A0 =A01 +
> =A0include/asm-alpha/kvm.h =A0 =A0 =A0| =A0 =A06 ++++++
> =A0include/asm-arm/Kbuild =A0 =A0 =A0 | =A0 =A02 ++
> =A0include/asm-arm/kvm.h =A0 =A0 =A0 =A0| =A0 =A06 ++++++
> =A0include/asm-avr32/Kbuild =A0 =A0 | =A0 =A01 +
> =A0include/asm-avr32/kvm.h =A0 =A0 =A0| =A0 =A06 ++++++
> =A0include/asm-blackfin/Kbuild =A0| =A0 =A01 +
> =A0include/asm-blackfin/kvm.h =A0 | =A0 =A06 ++++++
> =A0include/asm-cris/Kbuild =A0 =A0 =A0| =A0 =A01 +
> =A0include/asm-cris/kvm.h =A0 =A0 =A0 | =A0 =A06 ++++++
> =A0include/asm-frv/Kbuild =A0 =A0 =A0 | =A0 =A01 +
> =A0include/asm-frv/kvm.h =A0 =A0 =A0 =A0| =A0 =A06 ++++++
> =A0include/asm-h8300/Kbuild =A0 =A0 | =A0 =A02 ++
> =A0include/asm-h8300/kvm.h =A0 =A0 =A0| =A0 =A06 ++++++
> =A0include/asm-ia64/Kbuild =A0 =A0 =A0| =A0 =A01 +
> =A0include/asm-ia64/kvm.h =A0 =A0 =A0 | =A0 =A06 ++++++
> =A0include/asm-m32r/Kbuild =A0 =A0 =A0| =A0 =A02 ++
> =A0include/asm-m32r/kvm.h =A0 =A0 =A0 | =A0 =A06 ++++++
> =A0include/asm-m68k/Kbuild =A0 =A0 =A0| =A0 =A01 +
> =A0include/asm-m68k/kvm.h =A0 =A0 =A0 | =A0 =A06 ++++++

Instead of adding kvm.h to every single Kbuild file, you can
just add it once, in include/asm-generic/Kbuild.asm.

	Arnd <><
