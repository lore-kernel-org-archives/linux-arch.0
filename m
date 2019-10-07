Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45073 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbfJGDZY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Oct 2019 23:25:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so11965227ljb.12
        for <linux-arch@vger.kernel.org>; Sun, 06 Oct 2019 20:25:23 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p27sm2614297lfo.95.2019.10.06.20.25.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 20:25:21 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u28so8149491lfc.5
        for <linux-arch@vger.kernel.org>; Sun, 06 Oct 2019 20:25:21 -0700 (PDT)
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Oct 2019 20:25:05 -0700
Message-ID: <CAHk-=wiGqnJc6obUGSAsP8YCFEb_ZhD2Zfz-aWxdS_E_R_1xVw@mail.gmail.com>
Subject: Unaligned user pointer issues..
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>

So Guenther Roeck reported that my fancy readdir() user access
optimization broke alpha and sparc64 boot for him.

(It really improves things on x86 - I swear! The cost of telling the
CPU over and over again to "please allow user space accesses" is
horrendously high, so doing the whole "user_access_begin()/end() just
_once_ per dirent is a big deal).

It turns out that it's broken on at least alpha because it does that
filename copy to user space by hand, and the "linux_filldir64"
structure is set up so that the name part is basically never aligned.
So when it does the word copies, it does them as unaligned
"put_user()" invocations.

I'll fix it, never fear, since it's clearly a horrible performance
pessimization on architectures that don't deal unaligned accesses
well.

However, at least on alpha, it's not just that unaligned user accesses
were slow, they didn't actually _work_.

And that's a problem.

Because they are easy to trigger from user space even without any new
readdir code.

This trivial program causes a kernel oops on alpha:

  #define _GNU_SOURCE
  #include <unistd.h>
  #include <sys/mman.h>

  int main(int argc, char **argv)
  {
        void *mymap;
        uid_t *bad_ptr = (void *) 0x01;

        /* Create unpopulated memory area */
        mymap = mmap(NULL, 16384,
                PROT_READ | PROT_WRITE,
                MAP_PRIVATE | MAP_ANONYMOUS,
                -1, 0);

        /* Unaligned uidpointer in that memory area */
        bad_ptr = mymap+1;

        /* Make the kernel do put_user() on it */
        return getresuid(bad_ptr, bad_ptr+1, bad_ptr+2);
  }

because getresuid() does "put_user()" on that unaligned pointer, and
it looks like something goes badly sideways when it first takes the
unaligned trap, and then the unaligned trap handler gets an exception
on the emulation code.

I'm not sure what the alpha bug is (I looked at the code just long
enough to see that it _tries_ to do the exception handling), but the
fact that apparently I broke at least sparc64 too makes me suspect
that other architectures have this issue too.

So hey, can I ask architecture maintainers to try the above trivial
program and see how it works (or doesn't)?

On alpha, when Guenther tried my silly test-program, he reported:

  # ./mmtest
  Unable to handle kernel paging request at virtual address 0000000000000004
  mmtest(75): Oops -1
  pc = [<0000000000000004>]  ra = [<fffffc0000311584>]  ps = 0000    Not tainted
  pc is at 0x4
  ra is at entSys+0xa4/0xc0
  v0 = fffffffffffffff2  t0 = 0000000000000000  t1 = 0000000000000000
  ...

which is not what is supposed to happen ;)

            Linus
