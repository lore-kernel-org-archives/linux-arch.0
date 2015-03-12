From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [patch added to the 3.12 stable tree] vm: add VM_FAULT_SIGSEGV
 handling support
Date: Thu, 12 Mar 2015 17:23:11 +0100
Message-ID: <5501BD6F.6010903@suse.cz>
References: <1426175534-29874-1-git-send-email-jslaby@suse.cz> <CA+55aFyxTvdC6u9RPdY2Pg=ALrHkHKHLt9+tY01RqKABP9cFPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyxTvdC6u9RPdY2Pg=ALrHkHKHLt9+tY01RqKABP9cFPw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable <stable@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 03/12/2015, 05:16 PM, Linus Torvalds wrote:
> On Thu, Mar 12, 2015 at 8:52 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 5b90bbcad9f6..d9d8d91a64ff 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -873,6 +873,8 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
>>                 if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
>>                              VM_FAULT_HWPOISON_LARGE))
>>                         do_sigbus(regs, error_code, address, fault);
>> +               else if (fault & VM_FAULT_SIGSEGV)
>> +                       bad_area_nosemaphore(regs, error_code, address);
>>                 else
>>                         BUG();
>>         }
> 
> Just double-checking that you are aware that this semantically depends
> on commit 7fb08eca4527 ("x86: mm: move mmap_sem unlock from
> mm_fault_error() to caller"). We had that back-porting bug at least
> twice, because it was so subtle.
> 
> So either you need to backport 7fb08eca4527 too before (so that we
> really have dropped the semaphore at this point), or that
> "bad_area_nosemaphore()" needs to be just a "bad_area()" instead,
> because we still hold the semaphore.

Thanks for the heads-up. Despite I saw that one coming along with the
series to 3.10, I didn't include it due to a bit misleading commit
message. From that, it occurred to me like a cleanup.

Now included. Thanks.

-- 
js
suse labs
