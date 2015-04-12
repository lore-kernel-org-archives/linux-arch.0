From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] xtensa: Fix execdomain removal
Date: Sun, 12 Apr 2015 08:00:47 -0700
Message-ID: <552A889F.6050307@roeck-us.net>
References: <1428805191-27089-1-git-send-email-linux@roeck-us.net> <20150412144346.GD7215@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150412144346.GD7215@unpythonic.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
Cc: Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
