Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:30689 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750805AbWH3MjU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Aug 2006 08:39:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/7] Remove the use of _syscallX macros in UML
Date: Wed, 30 Aug 2006 14:38:41 +0200
References: <20060827214734.252316000@klappe.arndb.de> <20060827215636.797086000@klappe.arndb.de> <44F524EE.90304@zytor.com>
In-Reply-To: <44F524EE.90304@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301438.42079.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 30 August 2006 07:41, H. Peter Anvin wrote:
> syscall() is a horrible botch; it is in fact unimplementable (without 
> enormous switch statements) on a number of architectures.
> 
Ok, good point. I'll leave the _syscallX() macros in for now and only
remove the kernel syscalls in my next submission, so we get at least
the non-controversial part done.

	Arnd <><
