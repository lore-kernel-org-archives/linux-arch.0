Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11952 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbcAEXMy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Jan 2016 18:12:54 -0500
Subject: Re: [PATCH v2 12/32] x86/um: reuse asm-generic/barrier.h
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-13-git-send-email-mst@redhat.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <568C4DEA.5070601@nod.at>
Date: Wed, 6 Jan 2016 00:12:42 +0100
MIME-Version: 1.0
In-Reply-To: <1451572003-2440-13-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>, user-mode-linux-user@lists.sourceforge.net
Message-ID: <20160105231242.wRzDEwl24zaWlAboJVmiMkQ4U5yrw9bzSR80jkRG5kw@z>

Am 31.12.2015 um 20:07 schrieb Michael S. Tsirkin:
> On x86/um CONFIG_SMP is never defined.  As a result, several macros
> match the asm-generic variant exactly. Drop the local definitions and
> pull in asm-generic/barrier.h instead.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
