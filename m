From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Fri, 26 Sep 2014 15:33:50 +0200
Message-ID: <2108931.btbn8ltBxI@wuerfel>
References: <1410168160-3624-1-git-send-email-lftan@altera.com> <3608975.MxU44B73lk@wuerfel> <20140926131746.GA3279@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140926131746.GA3279@distanz.ch>
Sender: linux-doc-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Ley Foon Tan <lftan@altera.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Friday 26 September 2014 15:17:46 Tobias Klauser wrote:
> Speaking of the nios2 part: I'm the author of some parts of this code,
> but now also reviewed this series (or rather, intend to do so for the
> few remaining patches I didn't review yet).
> 
> What is the appropriate way to account for this? Is Reviewed-By still OK? I
> guess I won't be considered an entirely neutral reviewer 
> 

I think Reviewed-by is fine here, ideally mention in the full text
description who wrote what.

	Arnd
