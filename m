Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:45339 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbYG1QRf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2008 12:17:35 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3457708fkq.5
        for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2008 09:17:33 -0700 (PDT)
Message-ID: <488DF119.2000004@gmail.com>
Date: Mon, 28 Jul 2008 18:17:29 +0200
From: Andrea Righi <righi.andrea@gmail.com>
Reply-To: righi.andrea@gmail.com
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm: unify pmd_free() implementation
References: <> <1217260287-13115-1-git-send-email-righi.andrea@gmail.com> <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20080728161729.YsaU-vPM5ybfhPFWYSNJvroAxJplI8jAKNMD_MlaRmc@z>

Linus Torvalds wrote:
> 
> On Mon, 28 Jul 2008, Andrea Righi wrote:
>> Move multiple definitions of pmd_free() from different include/asm-* into
>> mm/util.c.
> 
> But this is horrible, because it forces a totally unnecessary function 
> call for that empty function.
> 
> Yeah, the function will be cheap, but the call itself will not be (it's a 
> C language barrier and basically disables optimizations around it, causing 
> thigns like register spill/reload for no good reason).
> 
> 		Linus

yep! clear.

Ok, in this case wouldn't be better at least to define pud_free() as:

static inline pud_free(struct mm_struct *mm, pmd_t *pmd)
{
}

in include/asm-generic/pgtable-nopmd.h, just to avoid the warning
on x86 without PAE?

Thanks for the explanation,
-Andrea
