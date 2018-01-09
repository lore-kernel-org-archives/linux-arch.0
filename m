From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 16:12:42 -0800
Message-ID: <CA+55aFz9RkEBVSq_zaRim73tC+R7q0g-ygVuXBv-a-U8GnhK0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Network Development <netdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 8, 2018 at 3:53 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> I've been thinking the "and" is only suitable for the array bounds
> check, for get_user() we're trying to block speculation past
> access_ok() at which point we can only do the lfence?

Well, we *could* do the "and", at least for the simple cases (ie the
true "get_user()" that integrates the access_ok with the access).

IOW, mainly the code in arch/x86/lib/getuser.S.

But it probably is a lot simpler to just add the "lfence" to ASM_STAC,
because by definition those cases don't tend to be the truly critical
ones - people who use those functions tend to do one or two accesses,
and the real cost is likely the I$ misses and the D$ miss to get
current->addr_limit. Not to mention the "stac" itself, which is much
more expensive than the access on current microarchitectures.

But something like this *might* work:

   index c97d935a29e8..7fa3d293beaf 100644
   --- a/arch/x86/lib/getuser.S
   +++ b/arch/x86/lib/getuser.S
   @@ -38,8 +38,11 @@
           .text
    ENTRY(__get_user_1)
           mov PER_CPU_VAR(current_task), %_ASM_DX
   -       cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
   +       mov TASK_addr_limit(%_ASM_DX),%_ASM_DX
   +       cmp %_ASM_DX,%_ASM_AX
           jae bad_get_user
   +       or $0xfff,%_ASM_DX
   +       and %_ASM_DX,%_ASM_AX
           ASM_STAC
    1:     movzbl (%_ASM_AX),%edx
           xor %eax,%eax

(this only does the one-byte case - the 2/4/8 byte cases are exactly the same).

The above is completely untested and might have some stupid
thinko/typo, so take it purely as a "example patch" to show the
concept, rather than actually do it.

But just adding "lfence" to the existing ASM_STAC is a hell of a lot
easier, and the performance difference between that trivial patch and
the above "let's be clever with 'and'" might not be measurable.

I really have no idea how expensive lfence might actually end up being
in practice. It's possible that lfence is actually fairly cheap in
kernel code, since we tend to not have very high IPC anyway.

                 Linus
