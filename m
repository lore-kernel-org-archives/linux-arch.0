Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:44435 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751374AbcADQsA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2016 11:48:00 -0500
Message-ID: <1451926073.4334.90.camel@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: add virt barriers
From: Joe Perches <joe@perches.com>
Date: Mon, 04 Jan 2016 08:47:53 -0800
In-Reply-To: <1451907395-15978-4-git-send-email-mst@redhat.com>
References: <1451907395-15978-1-git-send-email-mst@redhat.com>
	 <1451907395-15978-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: "Cc : Andy Whitcroft" <apw@canonical.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Tony Lindgren <tony@atomide.com>, Andrey Konovalov <andreyknvl@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Message-ID: <20160104164753.Aw5oK0UojknoKFGAd1_czmzLUuuJGNTN_cc75FbdpMc@z>

On Mon, 2016-01-04 at 13:37 +0200, Michael S. Tsirkin wrote:
> Add virt_ barriers to list of barriers to check for
> presence of a comment.

Are these virt_ barriers used anywhere?

I see some virtio_ barrier like uses.

