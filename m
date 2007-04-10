Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tmailer.gwdg.de ([134.76.10.23]:60024 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030950AbXDJQAN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Apr 2007 12:00:13 -0400
Date: Tue, 10 Apr 2007 17:47:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [RFC, PATCH 1/3] introduce SYS_CLONE_MASK
In-Reply-To: <20070408165750.GA149@tv-sign.ru>
Message-ID: <Pine.LNX.4.61.0704101743550.21664@yvahk01.tjqt.qr>
References: <20070408155337.GA126@tv-sign.ru> <m1lkh23kkb.fsf@ebiederm.dsl.xmission.com>
 <20070408165750.GA149@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Davide Libenzi <davidel@xmailserver.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Robin Holt <holt@sgi.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


On Apr 8 2007 20:57, Oleg Nesterov wrote:
>
>Anyway, re-parenting to swapper breaks pstree, it doesn't show kernel
>threads. And if ->parent == /sbin/init, we can't remove us from ->children
>(unless we forbid sub-thread-of-init exec). So the only safe change is
>set ->exit_state = -1.

Then we have to fix pstree and all that. (In fact, I'm secretly
trying to patch `ps f` to DTRT ;p)


Jan
-- 
