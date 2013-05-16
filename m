Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usmamail.tilera.com ([12.216.194.151]:29194 "EHLO
	USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab3EPNdY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 May 2013 09:33:24 -0400
Message-ID: <5194E021.8080906@tilera.com>
Date: Thu, 16 May 2013 09:33:21 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 08/10] tile: uaccess s/might_sleep/might_fault/
References: <cover.1368702323.git.mst@redhat.com> <018bba1e097552bc4054e6d90e3f03e7c9a632bb.1368702323.git.mst@redhat.com>
In-Reply-To: <018bba1e097552bc4054e6d90e3f03e7c9a632bb.1368702323.git.mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, microblaze-uclinux@itee.uq.edu.au, linux-am33-list@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
Message-ID: <20130516133321.2gHZyc8XbapB2U_V3FhKLJSfuX6kneT4C97dDMDviI8@z>

On 5/16/2013 7:15 AM, Michael S. Tsirkin wrote:
> The only reason uaccess routines might sleep
> is if they fault. Make this explicit.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/tile/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

