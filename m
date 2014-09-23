Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50042 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbaIWKk6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Sep 2014 06:40:58 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Tue, 23 Sep 2014 12:40:54 +0200
Message-ID: <13000968.l0laEvMsix@wuerfel>
In-Reply-To: <CAFiDJ5-b_P7aWFXYP4GcgTUb3t_j6dZCsjeGZwVUs+7qo0v-GA@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com> <1410168160-3624-2-git-send-email-lftan@altera.com> <CAFiDJ5-b_P7aWFXYP4GcgTUb3t_j6dZCsjeGZwVUs+7qo0v-GA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "LF.Tan" <lftan.linux@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Ley Foon Tan <lftan@altera.com>, Chung-Lin Tang <cltang@codesourcery.com>
Message-ID: <20140923104054.khh6bq7USlt6hS8RXWTsYJmlKDCTy64iwqoP_u588vw@z>

On Tuesday 23 September 2014 18:20:08 LF.Tan wrote:
> Hi Arnd
> 
> Are you okay with this generic futex in asm-generic?
> 

Yes, this looks good. Remind me again who need this, would it make
sense to merge this through an architecture-specific tree for
whichever architecture can benefit from it?

	Arnd
