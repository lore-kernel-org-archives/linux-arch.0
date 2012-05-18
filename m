From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 17:14:44 -0700
Message-ID: <4FB59474.2020505@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com> <CA+55aFy+XOc350sVuLKDHAaKtz9GdLcVmjxs98N8XLTK4zmMYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFy+XOc350sVuLKDHAaKtz9GdLcVmjxs98N8XLTK4zmMYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, David Daney <ddaney.cavm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

On 05/17/2012 05:07 PM, Linus Torvalds wrote:
> On Thu, May 17, 2012 at 4:51 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> The sane thing would seem to be to change __BITS_PER_LONG to 32 on x32
>> and fix the padding hacks in struct shmid64_ds; H.J., would you agree?
> 
> Ugh. That looks like a disaster.
> 
> The padding hacks that depend on __BITS_PER_LONG seem pretty damn broken anyway.
> 
> They only work if the kernel agrees with the value (which is against
> the whole point of making __BITS_PER_LONG be about some user-level ABI
> thing) or for little-endian machines.
> 
> IOW, all the __BITS_PER_LONG games look totally broken to me. I can't
> see how they could possibly even be fixed.
> 

Well, on existing compat (e.g. i386) __BITS_PER_LONG is definitely not
the same as kernel.  And yes, I don't see how the heck this was ever
correct on bigendian machines or even for compat in any form (if the
kernel tries to interpret the extra bits and user space didn't
initialize them we're lost.)

The "logical" thing to do here seems to just use __s64, but I have no
idea if that would suddenly break bigendian architectures...

David, Ralf, do you have any idea what e.g. MIPS does here?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
