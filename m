From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Sun, 21 Aug 2016 10:52:14 -0700
Message-ID: <CA+55aFxq=KPcS2ZOV51XP3eQNuaiWdJv579NRR+QFSx2sRq5Ww@mail.gmail.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
 <20160819212428.GR2356@ZenIV.linux.org.uk> <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
 <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
 <20160821001141.GV2356@ZenIV.linux.org.uk> <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
 <20160821045402.GC14857@tucnak.redhat.com> <20160821064229.GX2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160821064229.GX2356@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jakub Jelinek <jakub@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Aug 20, 2016 at 11:42 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It's not exactly setjmp/longjmp; what I had in mind was along the lines of

That ends up having all the exact same issues as setjmp, and generally
you *do* want the compiler to know about it.

For example, let's say that you have something like

    if (start())
        return -EFAULT;

    ... do things that can fault and trigger an exception ..

    stop();
    return 0;

then it doesn't matter that "start" clobbers all memory and registers,
if it returns twice the code generation by a compiler that doesn't
know about the magical setjmp-like behavior can trigger bugs.

For example, the most common case is that lots of compilers try to
share the final return-point - sometimes because of instrumentation,
sometimes just because there's a big stack frame and the return is a
lot of pop instructions and stack undo code.

And *particularly* if your magical 'start()' function has an inline
asm that clobbers memory and registers, the compiler will have to
spill state to stack around it - but part of the spill might be the
return value that it had in a register.

So the compiler might end up generating code like this:

         movl $-EFAULT,8(%rbp)    # retval
         call start
         testl %eax,%eax
         jne return_point;

         ...

         movl $0,8(%rbp)    # retval

         ....

    return_point:
        .. pop-pop-pop-whatever ..
        movl 4(%rbp),%eax
        .. more stack frame cleanup ..
        ret

and notice how if "start()" returns a second time - even if it
restored all registers including the stack pointer - the function
might return the wrong error value if the exception that caused
longjmp happened after the code that had updated the return.

There are lots of other ways a setjmp() point is special. Some
compilers might push/pop values just temporarily around a call, so you
might have sequences like

     pushq %rdx
     call fn
     popq %rdx

where the compiler wanted to save register %rdx around the call (I've
never actually seen gcc generate that code, the exact same thing may
happen with just random register spills).

Again, that fails completely in the presence of a function that
returns twice - even it the stack pointer itself gets reset, the stack
*contents* that the code pops the saved value of %rdx might have been
re-used for something else (and for a register spill, the frame slot
might have been re-used). So now you're restoring garbage.

So the interface you propose is in fact *exactly* the same as setjmp,
and we'd need to make sure that the compiler knows that.

                       Linus
