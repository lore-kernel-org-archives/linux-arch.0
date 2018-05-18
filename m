From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH -resend 02/27] x86: assembly, use SYM_DATA for data
Date: Fri, 18 May 2018 11:17:16 +0200
Message-ID: <0cd6a8bd-80a4-c1ad-bba9-bad63f6e053f@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-3-jslaby@suse.cz> <20180514080549.GB6607@gmail.com>
 <20180515063935.GA25721@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515063935.GA25721@gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/15/2018, 08:39 AM, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>>
>> * Jiri Slaby <jslaby@suse.cz> wrote:
>>
>>> We make proper use of SYM_DATA on global data instead of marking them as
>>> ENTRY. ENTRY is intended for functions and shall be paired with ENDPROC.
>>> ENTRY also aligns symbols which creates unnecessary holes here between
>>> data.
>>>
>>> ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64 is
>>> simply dropped, as these symbols are local only.
>>
>> Yeah, so this commit talks about ENTRY() and ENDPROC(), while the new methods are 
>> SYM_FUNC_START()/END().
> 
> BTW., I like the series otherwise: for example in my comment above I wrote up the 
> SYM_FUNC_START()/END() names from memory, without having to look up the 
> primitives.

Thanks, I am about to send v6 in a short while. It addresses the comments.

-- 
js
suse labs
