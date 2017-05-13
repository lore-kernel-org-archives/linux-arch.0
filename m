From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Fri, 12 May 2017 18:00:44 -0700
Message-ID: <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a113f94ae1248cb054f5d5af0"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33005 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdEMBAq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2017 21:00:46 -0400
In-Reply-To: <20170501034536.GX29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

--001a113f94ae1248cb054f5d5af0
Content-Type: text/plain; charset="UTF-8"

So I should have asked earlier, but I was feeling rather busy during
the early merge window..

On Sun, Apr 30, 2017 at 8:45 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>         uaccess unification pile.  It's _not_ the end of uaccess work, but
> the next batch of that will go into the next cycle.  This one mostly takes
> copy_from_user() and friends out of arch/* and gets the zero-padding behaviour
> in sync for all architectures.
>         Dealing with the nocache/writethrough mess is for the next cycle;
> fortunately, that's x86-only.

So I'm actually more interested to hear if you have any pending work
on cleaning up the __get/put_user() mess we have. Is that on your
radar at all?

In particular, right now, both __get_user() and __put_user() are nasty
and broken interfaces.

It *used* to be that they were designed to just generate a single
instruction. That's not what they currently do at all, due to the
whole SMAP/PAN on x86 and arm.

For example, on x86, right now a single __put_user() call ends up
generating something like

    #APP
    # 58 "./arch/x86/include/asm/smap.h" 1
            661:

    662:
    .skip -(((6651f-6641f)-(662b-661b)) > 0) * ((6651f-6641f)-(662b-661b)),0x90
    663:
    .pushsection .altinstructions,"a"
     .long 661b - .
     .long 6641f - .
     .word ( 9*32+20)
     .byte 663b-661b
     .byte 6651f-6641f
     .byte 663b-662b
    .popsection
    .pushsection .altinstr_replacement, "ax"
    6641:
            .byte 0x0f,0x01,0xcb
    6651:
            .popsection
    # 0 "" 2
    #NO_APP
            xorl        %eax, %eax      # __pu_err
    #APP
    # 269 "fs/readdir.c" 1

    1:  movq %rcx,8(%rdi)       # offset, MEM[(struct __large_struct *)_16]
    2:
    .section .fixup,"ax"
    3:  mov $-14,%eax   #, __pu_err
            jmp 2b
    .previous
     .pushsection "__ex_table","a"
     .balign 4
     .long (1b) - .
     .long (3b) - .
     .long (ex_handler_default) - .
     .popsection

    # 0 "" 2
    # 52 "./arch/x86/include/asm/smap.h" 1
            661:

    662:
    .skip -(((6651f-6641f)-(662b-661b)) > 0) * ((6651f-6641f)-(662b-661b)),0x90
    663:
    .pushsection .altinstructions,"a"
     .long 661b - .
     .long 6641f - .
     .word ( 9*32+20)
     .byte 663b-661b
     .byte 6651f-6641f
     .byte 663b-662b
    .popsection
    .pushsection .altinstr_replacement, "ax"
    6641:
            .byte 0x0f,0x01,0xca
    6651:
            .popsection
    # 0 "" 2
    #NO_APP

and while much of that is out-of-line and in different sections, it
basically means that it's insane how we inline these things.

Yes, yes, the inlined part of the above horror-story ends up being just

        clac
        xor    %eax,%eax
        mov    %rcx,0x8(%rdi)
        stac

and everything else is just boiler-plate for the alt-instruction
handling and the exception handling.

But even that small thing is rather debatable from a performance
angle: the actual cost of __put_user() these days is not the function
call, but the clac/stac (on modern x86) and the PAN bit games (on
arm).

So I'm actually inclined to just say "We should make
__get_user/__put_user() just be aliases for the normal
get_user/put_user() model".

The *correct* way to do fast user space accesses when you hoist error
checking outside is to use

        if (!access_ok(..))
                goto efault;
        user_access_begin();
        ..
        ... loop over or otherwise do multiple "raw" accessess ...
        unsafe_get/put_user(c, ptr, got_fault);
        unsafe_get/put_user(c, ptr, got_fault);
        ...
        user_access_end();
        return 0;

got_fault:
        user_access_end();
efault:
        return -EFAULT;

which is more boilerplate, but ends up generating much better code.
And for "unsafe_put_user()" in particular, we actually could teach gcc
to use "asm goto" to really improve code generation. I have patches
for that if you want to look.

I'm attaching an example patch for "filldir()" that does that modern
thing. It almost had the right form as-is anyway, and under some loads
(eg "find") filldir actually shows up in profiles too.\

And just from a code generation standpoint, look at what the attached
patch does:

[torvalds@i7 linux]$ diff -u fs/readdir.s ~/readdir.s | diffstat
 readdir.s |  548 ++++++++++++++++++++++----------------------------------------
 1 file changed, 201 insertions(+), 347 deletions(-)

just from getting rid of that crazy repeated SMAP overhead.

Yeah, yeah, doing diffstat on generated assembly files is all kinds of
crazy, but it's an example of what kind of odd garbage we currently
generate.

But the *first* thing I'd like to do would be to just get rid of
__get_user/__put_user as a thing. It really does generate nasty code,
and we might as well just make it do that function call.

Because what we do now isn't right. If we care about performance, the
"__xyz_user" versions are wrong (use unsafe_xyz_user() instead). And
if you don't care about performance, you should use the regular
xyz_user() functions that do an ok job by just calling the right-sized
helper function instead of inlining the crud.

Hmm?

                          Linus

--001a113f94ae1248cb054f5d5af0
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j2mk7ahi0

IGZzL3JlYWRkaXIuYyB8IDIyICsrKysrKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9yZWFk
ZGlyLmMgYi9mcy9yZWFkZGlyLmMKaW5kZXggOWQwMjEyYzM3NGQ2Li4wMzMyNGY1NGMwZTkgMTAw
NjQ0Ci0tLSBhL2ZzL3JlYWRkaXIuYworKysgYi9mcy9yZWFkZGlyLmMKQEAgLTE4NCwyNSArMTg0
LDI3IEBAIHN0YXRpYyBpbnQgZmlsbGRpcihzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCwgY29uc3Qg
Y2hhciAqbmFtZSwgaW50IG5hbWxlbiwKIAlpZiAoZGlyZW50KSB7CiAJCWlmIChzaWduYWxfcGVu
ZGluZyhjdXJyZW50KSkKIAkJCXJldHVybiAtRUlOVFI7Ci0JCWlmIChfX3B1dF91c2VyKG9mZnNl
dCwgJmRpcmVudC0+ZF9vZmYpKQotCQkJZ290byBlZmF1bHQ7CiAJfQorCisJdXNlcl9hY2Nlc3Nf
YmVnaW4oKTsKKwlpZiAoZGlyZW50KQorCQl1bnNhZmVfcHV0X3VzZXIob2Zmc2V0LCAmZGlyZW50
LT5kX29mZiwgZWZhdWx0X2VuZCk7CiAJZGlyZW50ID0gYnVmLT5jdXJyZW50X2RpcjsKLQlpZiAo
X19wdXRfdXNlcihkX2lubywgJmRpcmVudC0+ZF9pbm8pKQotCQlnb3RvIGVmYXVsdDsKLQlpZiAo
X19wdXRfdXNlcihyZWNsZW4sICZkaXJlbnQtPmRfcmVjbGVuKSkKLQkJZ290byBlZmF1bHQ7CisJ
dW5zYWZlX3B1dF91c2VyKGRfaW5vLCAmZGlyZW50LT5kX2lubywgZWZhdWx0X2VuZCk7CisJdW5z
YWZlX3B1dF91c2VyKHJlY2xlbiwgJmRpcmVudC0+ZF9yZWNsZW4sIGVmYXVsdF9lbmQpOworCXVu
c2FmZV9wdXRfdXNlcigwLCBkaXJlbnQtPmRfbmFtZSArIG5hbWxlbiwgZWZhdWx0X2VuZCk7CisJ
dW5zYWZlX3B1dF91c2VyKGRfdHlwZSwgKGNoYXIgX191c2VyICopIGRpcmVudCArIHJlY2xlbiAt
IDEsIGVmYXVsdF9lbmQpOworCXVzZXJfYWNjZXNzX2VuZCgpOworCiAJaWYgKGNvcHlfdG9fdXNl
cihkaXJlbnQtPmRfbmFtZSwgbmFtZSwgbmFtbGVuKSkKIAkJZ290byBlZmF1bHQ7Ci0JaWYgKF9f
cHV0X3VzZXIoMCwgZGlyZW50LT5kX25hbWUgKyBuYW1sZW4pKQotCQlnb3RvIGVmYXVsdDsKLQlp
ZiAoX19wdXRfdXNlcihkX3R5cGUsIChjaGFyIF9fdXNlciAqKSBkaXJlbnQgKyByZWNsZW4gLSAx
KSkKLQkJZ290byBlZmF1bHQ7CiAJYnVmLT5wcmV2aW91cyA9IGRpcmVudDsKIAlkaXJlbnQgPSAo
dm9pZCBfX3VzZXIgKilkaXJlbnQgKyByZWNsZW47CiAJYnVmLT5jdXJyZW50X2RpciA9IGRpcmVu
dDsKIAlidWYtPmNvdW50IC09IHJlY2xlbjsKIAlyZXR1cm4gMDsKK2VmYXVsdF9lbmQ6CisJdXNl
cl9hY2Nlc3NfZW5kKCk7CiBlZmF1bHQ6CiAJYnVmLT5lcnJvciA9IC1FRkFVTFQ7CiAJcmV0dXJu
IC1FRkFVTFQ7Cg==
--001a113f94ae1248cb054f5d5af0--
