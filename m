Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bzq-179-150-194.static.bezeqint.net ([212.179.150.194]:14639
	"EHLO il.qumranet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbYDVHTK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 03:19:10 -0400
Message-ID: <480D916C.4030100@qumranet.com>
Date: Tue, 22 Apr 2008 10:19:08 +0300
From: Avi Kivity <avi@qumranet.com>
MIME-Version: 1.0
Subject: Re: [patch 2/2]: introduce fast_gup
References: <20080328025455.GA8083@wotan.suse.de> <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins> <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org> <480C81C4.8030200@qumranet.com> <1208781013.7115.173.camel@twins> <480C9619.2050201@qumranet.com> <1208788547.7115.204.camel@twins> <20080422032319.GB21993@wotan.suse.de>
In-Reply-To: <20080422032319.GB21993@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, axboe@kernel.dk, linux-mm@kvack.org, linux-arch@vger.kernel.org, Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <20080422071908.xNyt0Fl0uvMDPq4s25I3fkk3PDvWyJyclWimkbOwDe0@z>

Nick Piggin wrote:
> That's horrible ;)
>
> Anyway guys you are missing the other side of the equation -- that whenever
> _PAGE_PRESENT is cleared, all CPUs where current->mm might be == mm have to
> have a tlb flush. And we're holding off tlb flushes in fast_gup, that's the
> whole reason why it all works.
>
>   

Ah, clever.  Thanks.

-- 
error compiling committee.c: too many arguments to function

