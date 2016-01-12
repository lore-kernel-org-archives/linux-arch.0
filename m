Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38873 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934559AbcALONK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2016 09:13:10 -0500
Date: Tue, 12 Jan 2016 15:10:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 13/41] x86: reuse asm-generic/barrier.h
In-Reply-To: <1452426622-4471-14-git-send-email-mst@redhat.com>
Message-ID: <alpine.DEB.2.11.1601121510380.3575@nanos>
References: <1452426622-4471-1-git-send-email-mst@redhat.com> <1452426622-4471-14-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160112141049.s1O95LGsopMjpUDXRsnF1k3BS2o7216mEsI9Qlhzzmw@z>

On Sun, 10 Jan 2016, Michael S. Tsirkin wrote:

> As on most architectures, on x86 read_barrier_depends and
> smp_read_barrier_depends are empty.  Drop the local definitions and pull
> the generic ones from asm-generic/barrier.h instead: they are identical.
> 
> This is in preparation to refactoring this code area.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
