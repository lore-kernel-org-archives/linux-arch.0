From: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Subject: Re: [PATCH 3/23] make section names compatible with -ffunction-sections -fdata-sections: arm
Date: Wed, 2 Jul 2008 08:22:43 +0200
Message-ID: <e4c675870807012322s3937b88ak9f8b77cbe06f8e65@mail.gmail.com>
References: <200807020234.26755.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <200807020234.26755.vda.linux@googlemail.com>
Content-Disposition: inline
Sender: linux-embedded-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

2008/7/2 Denys Vlasenko <vda.linux@googlemail.com>:
> The purpose of this patch is to make kernel buildable
> with "gcc -ffunction-sections -fdata-sections".
> This patch fixes arm architecture.
>

Hi Denys,

 I see your patchset. may I suggest you to take a look to this tools?

 http://www.emn.fr/x-info/coccinelle/

 I think it could simplify this kind of patching for the future.
 I found it reading the kernel janitors m-list and I hope it helps.

 Cheers,
-- 
/roberto
