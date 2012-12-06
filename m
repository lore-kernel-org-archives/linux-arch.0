From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 00/44] Meta Linux Kernel Port
Date: Thu, 6 Dec 2012 09:19:40 +0000
Message-ID: <50C0632C.9000206@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <20121205171131.GV4939@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54513 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107Ab2LFJTo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Dec 2012 04:19:44 -0500
In-Reply-To: <20121205171131.GV4939@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 05/12/12 17:11, Al Viro wrote:
> On Wed, Dec 05, 2012 at 04:08:18PM +0000, James Hogan wrote:
> 
>> other work not included:
>> * switch to generic kernel_{thread,execve} (will be posted separately to
>>   aid review)
> 
>> other changes:
> ...
>> * switch to generic sys_execve
> 
> ... which should've broken your kernel_execve().
> 

Hi Al,

Yes, you're right. I should have taken more care separating that patch
out. Sorry about that.

Cheers
James
