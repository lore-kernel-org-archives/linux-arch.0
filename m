From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -v23 00/49] Use memblock with x86
Date: Wed, 7 Jul 2010 08:42:39 +0200
Message-ID: <20100707064239.GB2565@elte.hu>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:39842 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751762Ab0GGGmx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Jul 2010 02:42:53 -0400
Content-Disposition: inline
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> New memblock could be used to replace early_res in x86.
> 
> Suggested by: David, Ben, and Thomas

>  113 files changed, 2110 insertions(+), 2217 deletions(-)
>  create mode 100644 include/linux/memblock.h
>  delete mode 100644 kernel/early_res.c
>  delete mode 100644 lib/lmb.c
>  create mode 100644 mm/memblock.c

Ok, this finally looks like a basis we could start productizing.

If anyone has any fundamental, structural, design level [or naming] 
objection/feedback, which should be addressed before we start cutting
a tree for this and start fixing bugs and move this towards an
append-only workflow, please speak up.

Thanks,

	Ingo
