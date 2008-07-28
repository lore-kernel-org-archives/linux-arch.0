From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH 1/1] mm: unify pmd_free() implementation
Date: Mon, 28 Jul 2008 19:19:44 +0200
Message-ID: <488DFFB0.1090107@gmail.com>
References: <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org> <488DF119.2000004@gmail.com> <20080729012656.566F.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:60051 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbYG1RTs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2008 13:19:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2121291fgg.17
        for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2008 10:19:47 -0700 (PDT)
In-Reply-To: <20080729012656.566F.KOSAKI.MOTOHIRO@jp.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

KOSAKI Motohiro wrote:
>> yep! clear.
>>
>> Ok, in this case wouldn't be better at least to define pud_free() as:
>>
>> static inline pud_free(struct mm_struct *mm, pmd_t *pmd)
>> {
>> }
> 
> I also like this :)

ok, a simpler patch using the inline function will follow.

-Andrea
