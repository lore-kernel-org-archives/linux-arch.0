Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [194.117.236.238] ([194.117.236.238]:53064 "EHLO
	heracles.linux360.ro" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1756179AbYGBBvn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 21:51:43 -0400
Date: Wed, 2 Jul 2008 04:28:06 +0300
From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: Re: [PATCH 1/23] make section names compatible with
 -ffunction-sections -fdata-sections
Message-ID: <20080702042806.4078bb09@linux360.ro>
In-Reply-To: <200807020233.48646.vda.linux@googlemail.com>
References: <200807020233.48646.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
Message-ID: <20080702012806.gJOA3iaGEXEYFK8_oYb5f1Y1jgx1GIUNSQtUXhGmVCg@z>

On Wed, 2 Jul 2008 02:33:48 +0200
Denys Vlasenko <vda.linux@googlemail.com> wrote:

> Hi Andrew, folks,
> 
> I am unsure how to synchronize propagation of these patches
> across all architectures.
> 
> Andrew, how this can be done without causing lots of pain
> for arch maintainers? Please advise.

Hi,

AFAICS, there is a lot of code in .lds.S files which really is
arch-independent, but still is duplicated in every arch. Kinda messy to
change anything in there.

I noticed this while writing another patch, namely early (pre-SMP)
initcall support. Fortunately, there was a generic header included by
all .lds.S files and I could fit my modification in there.

My suggestion is (for both you and arch maintainers)... why not make an
effort to reduce code duplication in these files? Life would be so much
easier. The idea is:
- Write a macro to define all generic sections, possibly taking in
alignment as an argument.
- Have each arch's .lds.S file define arch-dependent stuff and use that
macro for generic sections.

This would surely be immediately useful, more readily accepted by
maintainers and would open up the way for a lighter version of your
patch, IMO.


	Cheers,
	Eduard
