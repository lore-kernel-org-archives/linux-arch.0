From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 08/28] kdb: core for kgdb back end (2 of 2)
Date: Thu, 18 Feb 2010 08:35:32 -0800
Message-ID: <m1fx4ywlgr.fsf@fess.ebiederm.org>
References: <1266014143-29444-1-git-send-email-jason.wessel@windriver.com>
	<1266014143-29444-9-git-send-email-jason.wessel@windriver.com>
	<m1zl37xhmm.fsf@fess.ebiederm.org> <4B7D5704.6060504@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:52745 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757787Ab0BRQfm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Feb 2010 11:35:42 -0500
In-Reply-To: <4B7D5704.6060504@windriver.com> (Jason Wessel's message of "Thu\, 18 Feb 2010 09\:04\:36 -0600")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, mingo@elte.hu, mort@sgi.com, linux-arch@vger.kernel.org

Jason Wessel <jason.wessel@windriver.com> writes:

> Eric W. Biederman wrote:
>> Jason Wessel <jason.wessel@windriver.com> writes:
>>
>>   
>>> This patch contains the hooks and instrumentation into kernel which
>>> live outside the kernel/debug directory, which the kdb core
>>> will call to run commands like lsmod, dmesg, bt etc...
>>>     
>>
>> You know this dropping the locks from vmalloc_info and swap_info
>> is down right ugly, and I don't believe it is safe.  That code
>> was not designed to run while the write_lock is held.
>>   
>
> Perhaps we can find some middle ground.  I don't mind simply not
> allowing the information to be queried from kdb if the locks are not
> available. 
>
> Which is less ugly you, making the swap_lock global or adding a function
> to query it?

My recommendation would be to simply drop the swap_info and meminfo
information for now, and have kdb do what is good at.

Skimming through the history of the discussion it appears Christoph
Hellwig asked you to do something about these bits on the first
review.

From a maintenance point of view anything where you have to know which
locks a function will take is fragile.  It is entirely too easy to create
a change that is fine in it's normal context but breaks kdb.

Alt-sysrq already allows capturing that kind of information, without any
thorny maintenance issues.  By contrast kdb appears to be a much larger
and inferior tool.

Eric
