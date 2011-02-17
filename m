Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58961
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab1BQWWo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Feb 2011 17:22:44 -0500
Date: Thu, 17 Feb 2011 14:23:20 -0800 (PST)
Message-ID: <20110217.142320.102554706.davem@davemloft.net>
Subject: Re: [PATCH 1/3] module: deal with alignment issues in built-in
 module versions
From: David Miller <davem@davemloft.net>
In-Reply-To: <20110217221957.GA11244@dtor-ws.eng.vmware.com>
References: <AANLkTi=nQ4c6fgk9_-974QOu=kQkJiGpdzpOa_U6ZZcs@mail.gmail.com>
	<20110217.140119.39175251.davem@davemloft.net>
	<20110217221957.GA11244@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dtor@vmware.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, rusty@rustcorp.com.au, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110217222320.Lk-cJ_frsP3NUB1dwZfOOtCZfat2KSMPtpOA1r43KDQ@z>

From: Dmitry Torokhov <dtor@vmware.com>
Date: Thu, 17 Feb 2011 14:19:57 -0800

> Any pointers as to how to emit these pointers with asm?

	.section	FOO_SECTION, "a"
	.align		SIZEOF_POINTER
	.{,x}word	POINTER
	.previous

Where FOO_SECTION is your special section name, SIZEOF_POINTER is
sizeof(void *), and POINTER is the pointer you want to add to the
section.

You have to also pick .word vs. .xword, or whatever the appropriate
sized pointer mnenomic is for a given architecture.  I know .word
works for 32-bit sparc, and .xword works for 64-bit sparc.
