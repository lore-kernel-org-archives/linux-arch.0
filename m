From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] ptrace: unify show_regs() prototype
Date: Mon, 30 May 2011 18:54:04 -0400
Message-ID: <BANLkTinhNONdTT=sdTkSsTVLA9F50vkyXg@mail.gmail.com>
References: <1302759489-10645-1-git-send-email-vapier@gentoo.org>
 <1306726753-16128-1-git-send-email-vapier@gentoo.org> <20110530190713.GA20616@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47404 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab1E3WyZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 May 2011 18:54:25 -0400
In-Reply-To: <20110530190713.GA20616@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, May 30, 2011 at 15:07, Oleg Nesterov wrote:
> On 05/29, Mike Frysinger wrote:
>> --- a/include/linux/ptrace.h
>> +++ b/include/linux/ptrace.h
>> +extern void show_regs(struct pt_regs *);
>
> Not sure ptrace.h is the right place. show_regs() has the callers which
> have nothing to do with ptrace.

it needs pt_regs and everyone puts it in their own ptrace.h, so
linux/ptrace.h was the logical common place for it

> Hmm. You know what? show_regs() is already defined in sched.h, probably
> you can simply remove this chunk.

nice, i hadnt noticed.  i'll send a new version.
-mike
