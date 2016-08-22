From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Mon, 22 Aug 2016 16:12:50 -0700
Message-ID: <20F4A326-4107-452C-AF84-385136D9501F@zytor.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com> <20160819212428.GR2356@ZenIV.linux.org.uk> <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com> <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com> <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com> <20160821001141.GV2356@ZenIV.linux.org.uk> <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com> <20160821045402.GC14857@tucnak.redhat.com> <20160821064229.GX2356@ZenIV.linux.org.uk> <CA+55aFxq=KPcS2ZOV51XP3eQNuaiWdJv579NRR+QFSx2sRq5Ww@mail.gmail.com> <CA+55aFzKkVDuizFBH66s8n0u=1FRSXGPNKun9G8rFHaXw5Lx4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36614 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756623AbcHVXNF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Aug 2016 19:13:05 -0400
In-Reply-To: <CA+55aFzKkVDuizFBH66s8n0u=1FRSXGPNKun9G8rFHaXw5Lx4w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jakub Jelinek <jakub@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>

On August 22, 2016 3:23:06 PM PDT, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>On Sun, Aug 21, 2016 at 10:52 AM, Linus Torvalds
><torvalds@linux-foundation.org> wrote:
>> On Sat, Aug 20, 2016 at 11:42 PM, Al Viro <viro@zeniv.linux.org.uk>
>wrote:
>>>
>>> It's not exactly setjmp/longjmp; what I had in mind was along the
>lines of
>>
>> That ends up having all the exact same issues as setjmp, and
>generally
>> you *do* want the compiler to know about it.
>
>So just in case you wanted to play around with it, here's a kernel
>implementation of 'setjmp/longjmp' for x86.
>
>It's very lightly tested (and I'll admit to editing it for some
>cleanups after that light testing), but it does look largely sane.
>
>The whole interface choice may be debatable: maybe it would be better
>to allocate the register buffer on the stack, and just hide a pointer
>to it in the task struct. Things like that could be changed fairly
>easily. But if you want to play around with this, this patch should
>get you started.
>
>Of course, you'd want to wrap things up somehow, and I would *not*
>want to see naked setjmp() calls in the kernel.
>
>And we'd need this for all other architectures too, but it's usually
>not hard to do. It needs to save all the callee-saved registers and
>the stack pointer and return address. That should generally be it.
>
>The 32-bit version has not been tested at all, but it compiled at some
>point, and the code looks mostly sane. The 64-bit code I actually had
>a stupid non-user-access test-case for.
>
>                Linus

How about the gcc native __builtin_setjmp stuff which is supposedly better?
-- 
Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
