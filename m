Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60215 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbDLPAv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 12 Apr 2015 11:00:51 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YhJNS-000HJC-Oj
	for linux-arch@vger.kernel.org; Sun, 12 Apr 2015 15:00:50 +0000
Message-ID: <552A889F.6050307@roeck-us.net>
Date: Sun, 12 Apr 2015 08:00:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
Subject: Re: [PATCH] xtensa: Fix execdomain removal
References: <1428805191-27089-1-git-send-email-linux@roeck-us.net> <20150412144346.GD7215@unpythonic.net>
In-Reply-To: <20150412144346.GD7215@unpythonic.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Epler <jepler@unpythonic.net>
Cc: Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150412150047.p0np3eooJqbXcRTWh9YKzhMcauOVOoNe7_Q5UOIkB2w@z>

On 04/12/2015 07:43 AM, Jeff Epler wrote:
> On Sat, Apr 11, 2015 at 07:19:51PM -0700, Guenter Roeck wrote:
>> The removal of exexdomain changes pointer offsets into the thread_info
>> structure.
> ...
>> -#define TI_EXEC_DOMAIN	 0x00000004
>> -#define TI_FLAGS	 0x00000008
>> +#define TI_FLAGS	 0x00000004
>
> Hmm.  If these have to be maintained by hand, perhaps they can be
> BUILD_BUG_ON'd in some appropriate C file?  e.g.,
>
>      BUILD_BUG_ON(TI_FLAGS != offsetof(struct thread_info, flags));
>
> Jeff
>
Other architectures use either DEFINE or OFFSET macros to define
those flags, so that would probably be a better solution if something
more fancy is asked for. That should probably be a separate patch,
though.

Guenter

