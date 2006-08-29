Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.233]:50415 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964796AbWH2Ji2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Aug 2006 05:38:28 -0400
Received: by wx-out-0506.google.com with SMTP id s14so2002509wxc
        for <linux-arch@vger.kernel.org>; Tue, 29 Aug 2006 02:38:28 -0700 (PDT)
Message-ID: <1defaf580608290238k584af24fjc97ddb276706a423@mail.gmail.com>
Date: Tue, 29 Aug 2006 11:38:27 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
Subject: Re: [PATCH 0/7] kill __KERNEL_SYSCALLS__
In-Reply-To: <10191.1156842767@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060827214734.252316000@klappe.arndb.de>
	 <10191.1156842767@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Bjoern Steinbrink <B.Steinbrink@gmx.de>, Arjan van de Ven <arjan@infradead.org>, Chase Venters <chase.venters@clientec.com>, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
List-ID: <linux-arch.vger.kernel.org>

On 8/29/06, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Ok, next try. This time a full series that tries to kill
> > off __KERNEL_SYSCALLS__, _syscallX() and the global errno
> > for good.
>
> Have you checked uClibc?  Does that use _syscallX()?

At least the latest version provides its own set of _syscallX()
macros. I removed _syscallX() from the AVR32 kernel a few weeks ago as
suggested by David Woodhouse, and uClibc doesn't seem to have a
problem with it.

Haavard
