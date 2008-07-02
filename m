From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 21/23] make section names compatible with -ffunction-sections -fdata-sections: v850
Date: Thu, 3 Jul 2008 00:17:52 +0200
Message-ID: <200807030017.53747.arnd@arndb.de>
References: <200807020242.21960.vda.linux@googlemail.com> <20080702145859.a9af30ea.akpm@linux-foundation.org> <486BFC21.1040001@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <486BFC21.1040001@firstfloor.org>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, vda.linux@googlemail.com, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, dhowells@redhat.com, ralf@linux-mips.org, kernel@wantstofly.org, jwboyer@linux.vnet.ibm.com, paulus@samba.org, dwmw2@infradead.org, torvalds@linux-foundation.org, paul.gortmaker@windriver.com, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, tim.bird@am.sony.com, schwidefsky@de.ibm.com, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

On Thursday 03 July 2008, Andi Kleen wrote:
> Same seems to be true for cris btw.

Cris has seen significant updates in 2.6.25 by its maintainer.
It's not a very active port, but skipping updates for one kernel
version is on a completely different scale from doing nothing
at all for over three years as in the v850 case.

I don't currently see any architecture (other than v850) in a
state that justifies removing it entirely.

	Arnd <><
