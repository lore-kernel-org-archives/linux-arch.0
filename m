From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 05/37] kdb: core for kgdb back end
Date: Thu, 24 Dec 2009 09:57:15 -0600
Message-ID: <4B338F5B.9050904@windriver.com>
References: <1261653403.4937.192.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:37525 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbZLXP5j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2009 10:57:39 -0500
In-Reply-To: <1261653403.4937.192.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kdb@oss.sgi.com, mingo@elte.hu, mort@sgi.com, linux-arch@vger.kernel.org

Peter Zijlstra wrote:
> On Thu, 2009-12-24 at 12:01 +0100, Peter Zijlstra wrote:
>   
>> Please use --no-chain-reply-to when posting patches using git, these inf
>> deep nested series are impossible to read.
>>     
>
>   

Sure.  In all the future series, I added that option to the script that
manages the postings.

> Please never post with kgdb-bugreport@lists.sourceforge.net
> in the CC, it generates bounces for everything send to it.
>
>   

The kgdb-bugreports list has been fixed to cease the generation of
non-subscriber notifications.  All you had to do was indicate there was
a problem.  Non-subscribers are free to post there, and the messages go
through a filter queue.

Thanks,
Jason.
