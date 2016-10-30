From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Sun, 30 Oct 2016 11:51:02 +0100
Message-ID: <694a2919-6445-7632-a295-1baa01c82d0d@leemhuis.info>
References: <20161017100130.GA16013@angband.pl> <871szfb1x1.fsf@gmail.com>
 <20161018001626.GA5976@angband.pl>
 <20161018123418.6121175b@roar.ozlabs.ibm.com>
 <70c4e6bf-1667-326b-8a4d-b0960b55a5e7@suse.com>
 <20161020145204.77b37e6b@roar.ozlabs.ibm.com>
 <87h97yus9w.fsf@purkki.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87h97yus9w.fsf@purkki.adurom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Mathieu OTHACEHE <m.othacehe@gmail.com>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

On 27.10.2016 10:10, Kalle Valo wrote:
> (Adding Thorsten because of a serious regression and Steven because he
> tried to fix something in the same commit)

Many thx.

I added this report to the list of regressions for Linux 4.9. I'll
watch this thread for further updates on this issue to document progress
in my weekly reports. Please let me know via regressions@leemhuis.info
in case the discussion moves to a different place (bugzilla or another
mail thread for example).

Current status (afaics): Fix available, waiting for Michal to get back
from vacation.

tia! Ciao, Thorsten

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
>> On Wed, 19 Oct 2016 16:38:14 +0200
>> Michal Marek <mmarek@suse.com> wrote:
>>
>>> Dne 18.10.2016 v 03:34 Nicholas Piggin napsal(a):
>>>> We should probably just bring all these arch patches through the
>>>> kbuild tree.
>>>>
>>>> I'm sorry for the breakage: I didn't realize it broke the build with
>>>> some configs, otherwise I would have given Michal a heads up before
>>>> his pull request, and worked to get this stuff in first.  
>>>
>>> It breaks with some binutils versions only (and only with
>>> CONFIG_MODVERSIONS=y, of course).
>>
>> Yeah this seems to be the issue, it apparently slipped past all the
>> automated builds. It seems like the existing CRC warnings in the tree
>> only trigger in rare circumstances too, so something could be a bit
>> fragile there.
> 
> I upgraded from 4.8 to 4.9-rc2 and noticed that kernel modules fail to
> load (log below). After investigating for some time I found this thread
> and apparently this is not still fixed, at least not in Linus' tree.
> 
> Reverting 784d5699eddc5 fixed the issue for me. As I don't see any fix
> available (please correct me if I'm wrong) we should just revert that
> commit until it's properly fixed.
> 
> Also note that there's a related fix from Steven:
> 
> [PATCH] x86: Fix export for mcount and __fentry__
> https://marc.info/?l=linux-kernel&m=147733572502413
> 
> For compiling the kernel I'm using Ubuntu 12.04:
> 
> ii  binutils             2.22-6ubuntu1.4      GNU assembler, linker and binary utilities
> ii  gcc                  4:4.6.3-1ubuntu5     GNU C compiler
> 
> The kernel is running on a separate machine with Ubuntu 14.04.
> 
> [  110.703414] bluetooth: disagrees about version of symbol __get_user_2
> [  110.703416] bluetooth: Unknown symbol __get_user_2 (err -22)
> [  110.703429] bluetooth: disagrees about version of symbol __put_user_2
> [  110.703430] bluetooth: Unknown symbol __put_user_2 (err -22)
> [  110.703579] bluetooth: disagrees about version of symbol __put_user_4
> [  110.703580] bluetooth: Unknown symbol __put_user_4 (err -22)
> [  110.703669] bluetooth: disagrees about version of symbol __put_user_1
> [  110.703670] bluetooth: Unknown symbol __put_user_1 (err -22)
> [  110.703688] bluetooth: disagrees about version of symbol mcount
> [  110.703689] bluetooth: Unknown symbol mcount (err -22)
> 
