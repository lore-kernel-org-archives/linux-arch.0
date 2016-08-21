From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sat, 20 Aug 2016 18:00:17 -0700
Message-ID: <CA+55aFwgPkDE7AUQ3vDrDgE384B5JGQ3XV3pjQ2tyuWc56M9Kg@mail.gmail.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk> <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
 <20160821001141.GV2356@ZenIV.linux.org.uk> <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>, Jakub Jelinek <jakub@redhat.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 20, 2016 at 5:45 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I slightly considered it, because gcc actually has support for that
> kind of behavior thanks to setjmp/longjmp (and yes, the compiler
> actually needs to know about the magic "this code can be entered a
> second time from elsewhere" - it _used_ to be purely a library thing
> back in the days of stupid compilers, but no more).

Hmm. I may just be full of sh*t.

I was pretty sure that there used to be a "setjmp" attribute that gcc
used to make sure that "setjmp()" really could return twice, without
bad things happening on the stack.

But looking at the normal user space headers, I see nothing like that. It's just

    extern int setjmp (jmp_buf __env) __THROWNL;

where __THROWNL just sets the __nothrow__ attribute, which shouldn't
even matter in the kernel since we use -fno-exceptions.

So my "setjmp does potentially bad things to the optimization of the
function calling it" seems to have been just some drug-induced fever
dream of mine.

Sorry for the bogus noise. I don't know why I was so convinced setjmp
needed special gcc semantics.

             Linus
