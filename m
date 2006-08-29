Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:23425 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932210AbWH2JNY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 05:13:24 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060827214734.252316000@klappe.arndb.de> 
References: <20060827214734.252316000@klappe.arndb.de> 
Subject: Re: [PATCH 0/7] kill __KERNEL_SYSCALLS__ 
Date: Tue, 29 Aug 2006 10:12:47 +0100
Message-ID: <10191.1156842767@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:

> Ok, next try. This time a full series that tries to kill
> off __KERNEL_SYSCALLS__, _syscallX() and the global errno
> for good.

Have you checked uClibc?  Does that use _syscallX()?

David
