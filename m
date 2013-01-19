From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 13/76] ARC: Low level IRQ/Trap/Exception Handling
Date: Sat, 19 Jan 2013 19:18:43 +0530
Message-ID: <50FAA43B.2050100@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-14-git-send-email-vgupta@synopsys.com> <20130119033104.GD23552@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:52853 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3ASNvz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Jan 2013 08:51:55 -0500
In-Reply-To: <20130119033104.GD23552@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On Saturday 19 January 2013 09:01 AM, Al Viro wrote:
> On Fri, Jan 18, 2013 at 05:54:27PM +0530, Vineet Gupta wrote:
>
>> +	; --- (Slow Path #3) notify_resume ---
>> +.Lchk_notify_resume:
>> +	btst   r9, TIF_NOTIFY_RESUME
>> +	blnz   @do_notify_resume
>> +	b      resume_user_mode_begin	; unconditionally back to U mode ret chks
>> +					; for single exit point from this block
> Umm...  Can we even get there without NOTIFY_RESUME?  Again, there's
> future-proofing and there's laying minefields - think what will happen
> if we *do* get there with some bit in _TIF_WORK_MASK that isn't recognized
> by any of these cases.  Looping forever?

IMHO, for future safe-ing, the test for TIF_NOTIFY_RESUME is correct (as we will
need to add that check the moment a new bit is introduced in _TIF_WORK_MASK).

Regarding the infinite loop, I would assume that _TIF_WORK_MASK is golden (fixed
by your prior comment) so anyone touching it needs to add corresponding code here
- IMHO we don't need to handle that scenario (maybe add a comment in
thread_info.h). With that assumption, the unconditional branch would go back to
start and the re-test for TIF_WORK_MASK will break the loop even if any stray bit
was set.

So essentially we don't need any code change ! Am I overlooking something here ?

-Vineet
