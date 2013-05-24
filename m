Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57058 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab3EXNdF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 May 2013 09:33:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
Date: Fri, 24 May 2013 15:30:20 +0200
References: <cover.1368702323.git.mst@redhat.com> <20130524130032.GA10167@redhat.com> <20130524131104.GA11462@redhat.com>
In-Reply-To: <20130524131104.GA11462@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201305241530.20845.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Michal Simek <monstr@monstr.eu>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, microblaze-uclinux@itee.uq.edu.au, linux-am33-list@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org
Message-ID: <20130524133020.lDB-v_5oBrtDG3xarHXtwyH5T31Rd-Cs4liNdQ6UGew@z>

On Friday 24 May 2013, Michael S. Tsirkin wrote:
> So this won't work, unless we add the is_kernel_addr check
> to might_fault. That will become possible on top of this patchset
> but let's consider this carefully, and make this a separate
> patchset, OK?

Yes, makes sense.

	Arnd
