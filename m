From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: PAGE_ALIGN() compile breakage
Date: Fri, 25 Jul 2008 20:34:30 +0200
Message-ID: <488A1CB6.5090707@gmail.com>
References: <20080725083943.GC19310@cs181140183.pp.htv.fi>	<20080725015537.564e3397.akpm@linux-foundation.org>	<20080725091455.GD19310@cs181140183.pp.htv.fi> <20080725022547.a05ea755.akpm@linux-foundation.org>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:7212 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbYGYSec (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jul 2008 14:34:32 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2894649mue.1
        for <linux-arch@vger.kernel.org>; Fri, 25 Jul 2008 11:34:30 -0700 (PDT)
In-Reply-To: <20080725022547.a05ea755.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Adrian Bunk <bunk@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>

Andrew Morton wrote:
> On Fri, 25 Jul 2008 12:14:55 +0300 Adrian Bunk <bunk@kernel.org> wrote:
> 
>> Ideally, all headers should be self-contained. IOW, they should #include 
>> everything they use.
> 
> Yup.  And the core reason for our headers mess is that the headers do
> too much stuff, and cnosequently demand a large dependency trail.
> 
>> But TASK_UNMAPPED_BASE in asm/processor.h on some architectures uses 
>> PAGE_ALIGN() that got moved from asm/page.h to linux/mm.h .
> 
> Probably mm.h should be split up - put the simple things (usually
> declarations) into one "early" header file and leave the more
> heavyweight things (usually implementations) in mm.h.

IMHO splitting mm.h is probably the best solution. If I'm not wrong
Paul (CCed) already suggested to move the stuff like PAGE_ALIGN() outside
mm.h the first time I submitted this patch.

In this way we could even include the "lightweight" mm.h (mm_define.h??)
in all the asm-*/page.h, preserving also the backward compatibility.

-Andrea
