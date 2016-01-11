Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:57850 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932645AbcAKVpS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jan 2016 16:45:18 -0500
Message-ID: <1452548708.7773.57.camel@perches.com>
Subject: Re: [PATCH v4 0/3] checkpatch: handling of memory barriers
From: Joe Perches <joe@perches.com>
Date: Mon, 11 Jan 2016 13:45:08 -0800
In-Reply-To: <1452509968-19778-1-git-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Julian Calaby <julian.calaby@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20160111214508.lthrR73MNEKhETrEy-QF5Ur9_xF1mUnk2GtpoOdUN_8@z>

On Mon, 2016-01-11 at 13:00 +0200, Michael S. Tsirkin wrote:
> As part of memory barrier cleanup, this patchset
> extends checkpatch to make it easier to stop
> incorrect memory barrier usage.

Thanks Michael.

Acked-by: Joe Perches <joe@perches.com>

