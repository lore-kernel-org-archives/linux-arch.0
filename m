From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/4] Clean up the long arch list for the UID16 config
 option
Date: Thu, 4 Oct 2012 21:17:17 +0100
Message-ID: <20121004201717.GA5922@arm.com>
References: <1349282666-32100-1-git-send-email-catalin.marinas@arm.com>
 <1349282666-32100-2-git-send-email-catalin.marinas@arm.com>
 <20121003151505.8d59b646.akpm@linux-foundation.org>
 <20121004194131.GA4625@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121004194131.GA4625@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 04, 2012 at 08:41:31PM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 03, 2012 at 03:15:05PM -0700, Andrew Morton wrote:
> > Guys, don't do this.  Either put the new item into a randomly-chosen
> > position or, probably better, alphanumerically sort the list.
> 
> I've been telling people to alphanumerically sort Kconfig select
> options for some time, but as normal, no one's listening.

CONFIG_ARM64 is sorted ;)

-- 
Catalin
