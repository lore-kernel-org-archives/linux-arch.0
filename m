From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] signal/sh: Stop gcc warning about an impossible case in
 do_divide_error
Date: Wed, 30 May 2018 10:54:57 +0300
Message-ID: <8a890c7c-771a-2f10-6dc1-145a9f75e48a@cogentembedded.com>
References: <87604mhrnb.fsf@xmission.com>
 <20180420143811.9994-16-ebiederm@xmission.com>
 <20180420145514.GP3094@brightrain.aerifal.cx>
 <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
 <87h8mqo6at.fsf_-_@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h8mqo6at.fsf_-_@xmission.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello!

On 5/29/2018 6:00 PM, Eric W. Biederman wrote:

> Geert Uytterhoeven <geert@linux-m68k.org> reported:
>>    HOSTLD  scripts/mod/modpost
>>    CC      arch/sh/kernel/traps_32.o
>> arch/sh/kernel/traps_32.c: In function 'do_divide_error':
>> arch/sh/kernel/traps_32.c:606:17: error: 'code' may be used uninitialized in this function [-Werror=uninitialized]
>> cc1: all warnings being treated as errors
> 
> It is clear from inspection that do_divide_error is only called with
> TRAP_DIVZERO_ERROR or TRAP_DIVOVF_ERROR, as that is the way
> set_exception_table_vec is called.  So let gcc know the other cases
> should not be considered by returning in all other cases.
> 
> This removes the warning and let's the code continue to build.

    Lets. :-)

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: c65626c0cd4d ("signal/sh: Use force_sig_fault where appropriate")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
[...]

MBR, Sergei
