From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sys_fanotify_mark (again)
Date: Sun, 22 Nov 2009 19:05:00 -0800
Message-ID: <4B09FBDC.7010106@zytor.com>
References: <20091122090519.GA3974@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:34396 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664AbZKWDFS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Nov 2009 22:05:18 -0500
In-Reply-To: <20091122090519.GA3974@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Eric Paris <eparis@redhat.com>, linux-arch@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Li Zefan <lizf@cn.fujitsu.com>

On 11/22/2009 01:05 AM, Heiko Carstens wrote:
> 
> Alternatively you could also fix the syscall wrapper stuff to automatically
> do the right thing for long long parameters. But I wouldn't how... except
> with hpa's proposed automatic syscall wrapper creation engine :)
> 

I really need to get off my arse and productize that, don't I...

It would help to have some examples of non-x86 ABI rules to help feed it.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
