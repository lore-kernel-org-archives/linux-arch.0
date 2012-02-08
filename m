From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 16/21] s390: Use generic posix_types.h
Date: Wed, 08 Feb 2012 08:55:13 -0800
Message-ID: <4F32A8F1.1080001@zytor.com>
References: <1328677745-20121-1-git-send-email-hpa@zytor.com> <1328677745-20121-17-git-send-email-hpa@zytor.com> <20120208100445.2e527a4e@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48133 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab2BHQz1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Feb 2012 11:55:27 -0500
In-Reply-To: <20120208100445.2e527a4e@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com

On 02/08/2012 01:04 AM, Martin Schwidefsky wrote:
> On Tue,  7 Feb 2012 21:09:00 -0800
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
>> From: "H. Peter Anvin" <hpa@zytor.com>
>>
>> Change the s390 architecture to use <asm-generic/posix_types.h>.
>>
>> Signed-off-by: H. Peter Anvin <hpa@zytor.com>
>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: <linux390@de.ibm.com>
>> ---
>>  arch/s390/include/asm/posix_types.h |   70 +++++------------------------------
>>  1 files changed, 10 insertions(+), 60 deletions(-)
> 
> I carefully checked the conversion and came to the conclusion that the new type
> definitions are equivalent to the old ones. The code compiles fine with the
> patches applied and the kernel boots.
> What I don't like is the conversion of __FD_ZERO. The new definition creates
> this code sequence:
> 

It shouldn't matter:

a. __FD_ZERO seems to actually be unused in the current kernel.
b. The last patch in the series deletes the generic __FD_ZERO and
   replaces it with memset().  If there are any magic optimizations an
   architecture wants to do, they belong in memset().

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
