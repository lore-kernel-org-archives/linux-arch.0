From: Will Deacon <will.deacon@arm.com>
Subject: Re: A bug about system call on ARM
Date: Thu, 30 May 2013 10:09:49 +0100
Message-ID: <20130530090949.GC7483@mudshark.cambridge.arm.com>
References: <35FD53F367049845BC99AC72306C23D1610991B85B@CNBJMBX05.corpusers.net>
 <CAFLxGvy39xWdZmtiVHP+y=zH1coCVmMuREcmD25wSb=w-VK7Xg@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D1610991B85D@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B85E@CNBJMBX05.corpusers.net>
 <CAFLxGvyy=73dGQqG8W6SXZah7WQZ4gJAeeHXN8opKaOuG-5yUQ@mail.gmail.com>
 <20130529094826.GD13095@mudshark.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D1610991B865@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:65498 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1030209Ab3E3JLB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 May 2013 05:11:01 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1610991B866@CNBJMBX05.corpusers.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'richard -rw- weinberger' <richard.weinberger@gmail.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Thu, May 30, 2013 at 02:41:42AM +0100, Wang, Yalin wrote:
> Hi  Will,

Hello,

> Have you received the log files?

Yep, and you seem to be completely correct: CPU0 ages the page from which
CPU1 just executed a system call, so we explode trying to load the swi
instruction in order to retrieve the immediate.

> And is there someone looking at this issue now ?

It's on my list, but I'm pretty busy right now and OABI-compat isn't high
priority. Are you actually running OABI binaries? If not, you can simply
turn that option off (in fact, a quick fix to this issue is to make that
depend on !SMP).

> This issue happened on Qcom Scorpoin CPUs,
> And  it just happened in our stability test occasionally .
> 
> If you have some patch for this issue,
> I can do the test for it .

I'll have a look at cooking something which uses an exception table entry
to rewind the PC and retry the system call. That's simpler than directly
injecting a user page fault from the system call path.

Will
