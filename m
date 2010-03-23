From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH -v2 4/4] x86: use lmb to replace early_res
Date: Tue, 23 Mar 2010 10:14:36 +0100
Message-ID: <20100323091436.GA4576@elte.hu>
References: <1269333587-1866-1-git-send-email-yinghai@kernel.org>
 <1269333587-1866-5-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:35901 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab0CWJO4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2010 05:14:56 -0400
Content-Disposition: inline
In-Reply-To: <1269333587-1866-5-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Yinghai Lu <yinghai@kernel.org> wrote:

> still keep kernel/early_res.c for the extension.
> 
> should move those file to lib/lmb.c later?
> 
> -v2: fix NO_BOOTMEM hang with printk

Would be nice to track known TODO items - that way people dont feel that you 
are ignoring (or have missed) their feedback. For example are the list of 4 
improvements i suggested in the previous mail planned, or do you disagree with 
some of that?

Thanks,

	Ingo
