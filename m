From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 14/23] make section names compatible with
	-ffunction-sections -fdata-sections: parisc
Date: Sun, 06 Jul 2008 11:19:32 -0500
Message-ID: <1215361172.4197.21.camel@localhost.localdomain>
References: <200807020239.11410.vda.linux@googlemail.com>
	 <200807061746.02517.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200807061746.02517.vda.linux@googlemail.com>
Sender: linux-embedded-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Sun, 2008-07-06 at 17:46 +0200, Denys Vlasenko wrote:
> The purpose of this patch is to make kernel buildable
> with "gcc -ffunction-sections -fdata-sections".
> This patch fixes parisc architecture.
> 
> Updated version - does not try to rename sections
> which really are expected to be produced by gcc - .text.sys_exit etc.

Actually, I've thought about it some more and I don't think your
approach is quite right.  The way gcc works with -ffunction-sections
makes it clear that it expects the section namespace to be scoped left
to right. However, by using *.text and *.data, your patch is following a
reverse convention (putting your most global name to the right).  This
is setting us up for a clash with future global section names that our
toolchain might emit in future.

Since we have to have special handling for your reversed sections in
every vmlinux.lds, what about introducing our own namespace instead?  So
we reserve the global section specifier linux and then make everything a
namespace under this.  So our constructed text and data sections become

linux.text.*

and

linux.data.*

That way we could only ever get a clash if the toolchain decided to use
a section global name linux (which we can beat them up over).

James
