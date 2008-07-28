From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 1/1] mm: unify pmd_free() implementation
Date: Tue, 29 Jul 2008 01:27:44 +0900
Message-ID: <20080729012656.566F.KOSAKI.MOTOHIRO@jp.fujitsu.com>
References: <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org> <488DF119.2000004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57103 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759132AbYG1Q2u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2008 12:28:50 -0400
In-Reply-To: <488DF119.2000004@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: righi.andrea@gmail.com
Cc: kosaki.motohiro@jp.fujitsu.com, Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


> yep! clear.
> 
> Ok, in this case wouldn't be better at least to define pud_free() as:
> 
> static inline pud_free(struct mm_struct *mm, pmd_t *pmd)
> {
> }

I also like this :)
