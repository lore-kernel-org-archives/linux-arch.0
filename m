Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.189]:34322 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbYGBGWp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Jul 2008 02:22:45 -0400
Received: by gv-out-0910.google.com with SMTP id e6so43944gvc.37
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 23:22:43 -0700 (PDT)
Message-ID: <e4c675870807012322s3937b88ak9f8b77cbe06f8e65@mail.gmail.com>
Date: Wed, 2 Jul 2008 08:22:43 +0200
From: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Subject: Re: [PATCH 3/23] make section names compatible with -ffunction-sections -fdata-sections: arm
In-Reply-To: <200807020234.26755.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200807020234.26755.vda.linux@googlemail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
Message-ID: <20080702062243.PmaLos0px5bZ-EU_SxNZNiLZM_7piGOyonn8ZTR_g3Q@z>

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
