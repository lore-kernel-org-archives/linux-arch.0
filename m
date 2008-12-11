From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH] make INIT_FS use the __RW_LOCK_UNLOCKED initialization
Date: Wed, 10 Dec 2008 20:07:26 -0500
Message-ID: <8bd0f97a0812101707p7df7745dk9840b05c0b26184b@mail.gmail.com>
References: <alpine.DEB.1.10.0812101832200.21545@gandalf.stny.rr.com>
	 <20081210234307.GI28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:30812 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYLKBHc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Dec 2008 20:07:32 -0500
In-Reply-To: <20081210234307.GI28946@ZenIV.linux.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Dec 10, 2008 at 18:43, Al Viro wrote:
> On Wed, Dec 10, 2008 at 06:37:28PM -0500, Steven Rostedt wrote:
>>
>> The following patch is in:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
>>
>>     branch: cleanups
>
> Would be better to take init_fs to something in fs/ or kernel/ and kill
> the duplicates, along with INIT_FS macro itself...

how about the next level: unify init_task.c.  a quick check shows that
like 90% of the stuff in there is the same for everyone ...
-mike
