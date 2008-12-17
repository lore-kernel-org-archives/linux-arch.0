From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH last/many] x86: checking framework for correct use of
	ENTRY/PROC
Date: Wed, 17 Dec 2008 17:43:45 +0300
Message-ID: <20081217144345.GA8078@localhost>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1229505475-10219-2-git-send-email-heukelum@fastmail.fm> <1229505475-10219-3-git-send-email-heukelum@fastmail.fm> <aa79d98a0812170351rb64c595gc933456c661317c5@mail.gmail.com> <20081217120450.GA8600@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:59726 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbYLQOnv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Dec 2008 09:43:51 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1621463fgg.17
        for <linux-arch@vger.kernel.org>; Wed, 17 Dec 2008 06:43:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081217120450.GA8600@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>

[Alexander van Heukelum - Wed, Dec 17, 2008 at 01:04:50PM +0100]
...
| > Thanks Alexander!
| > 
| > You know I think you meant __ASSEMBLY__ while
| > were typing __ASSEMBLER__. Don't you? :)
| 
| If it matters there is some cleanup to do in the kernel tree ;).
| 
| Greetings,
|     Alexander
| 

I somehow missed the line the pointed to not apply this patch
that is why I was amaized since I dont remember where we use
__ASSEMBLER__. Got it :)

		- Cyrill -
