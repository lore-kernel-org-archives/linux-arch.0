From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 00/37] genirq: Remove __do_IRQ() and cleanup irq related Kconfigs
Date: Wed, 19 Jan 2011 14:13:07 -0800
Message-ID: <AANLkTineduG23qitc8ggDKShYJi=2vJgXbYJDjLGZKk3@mail.gmail.com>
References: <20110119205258.462759212@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110119205258.462759212@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chen Liqin <liqin.chen@sunplusct.com>, Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greg Ungerer <gerg@uclinux.org>, Hirokazu Takata <takata@linux-m32r.org>, Jeff Dike <jdike@addtoit.com>, Kyle McMartin <kyle@mcmartin.ca>, Michal Simek <monstr@monstr.eu>, Mikael Starvik <starvik@axis.com>, Mike Frysinger <vapier@gentoo.org>, Paul Mundt <lethal@linux-sh.org>, Richard Henderson <rth@twiddle.net>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 19, 2011 at 1:47 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
> Now that rc1 is out, I got reliable information about the remaining
> users of __do_IRQ(), which block the removal:
>
> =A0arch/cris, arch/h8300, arch/m32r

I'm certainly ok with this series. It would be good to finally get rid
of this legacy interface, and there's no longer any reason to hold it
up. And getting rid of hundreds of lines of code is good too.

                Linus
