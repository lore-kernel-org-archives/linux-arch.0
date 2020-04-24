From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 07/11] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Date: Fri, 24 Apr 2020 18:31:35 +0200
Message-ID: <CAG48ez2n6g6nenHM8uB5U+e-Zo1PSA6n9LOBHeqG2HdUnwFpSQ@mail.gmail.com>
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-8-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 12:32:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDE8C09B046
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2020 09:32:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so10576577ljb.9
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2020 09:32:03 -0700 (PDT)
In-Reply-To: <20200421151537.19241-8-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kernel-team <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Tue, Apr 21, 2020 at 5:15 PM Will Deacon <will@kernel.org> wrote:
> {READ,WRITE}_ONCE() cannot guarantee atomicity for arbitrary data sizes.
> This can be surprising to callers that might incorrectly be expecting
> atomicity for accesses to aggregate structures, although there are other
> callers where tearing is actually permissable (e.g. if they are using
> something akin to sequence locking to protect the access).
[...]
> The slight snag is that we also have to support 64-bit accesses on 32-bit
> architectures, as these appear to be widespread and tend to work out ok
> if either the architecture supports atomic 64-bit accesses (x86, armv7)
> or if the variable being accesses represents a virtual address and
> therefore only requires 32-bit atomicity in practice.
>
> Take a step in that direction by introducing a variant of
> 'compiletime_assert_atomic_type()' and use it to check the pointer
> argument to {READ,WRITE}_ONCE(). Expose __{READ,WRITE}_ONCE() variants
> which are allowed to tear and convert the one broken caller over to the
> new macros.
[...]
> +/*
> + * Yes, this permits 64-bit accesses on 32-bit architectures. These will
> + * actually be atomic in many cases (namely x86), but for others we rely on

I don't think that's correct?


$ cat 32bit_volatile_qword_read_write.c
#include <pthread.h>
#include <err.h>
#include <stdio.h>
#include <stdint.h>

/* make sure it really has proper alignment */
__attribute__((aligned(8)))
volatile uint64_t shared_u64;

static void *thread_fn(void *dummy) {
  while (1) {
    uint64_t value = shared_u64;
    if (value == 0xaaaaaaaaaaaaaaaaUL || value == 0xbbbbbbbbbbbbbbbbUL)
      continue;
    printf("got 0x%llx\n", (unsigned long long)value);
  }
  return NULL;
}

int main(void) {
  printf("shared_u64 at %p\n", &shared_u64);
  pthread_t thread;
  if (pthread_create(&thread, NULL, thread_fn, NULL))
    err(1, "pthread_create");

  while (1) {
    shared_u64 = 0xaaaaaaaaaaaaaaaaUL;
    shared_u64 = 0xbbbbbbbbbbbbbbbbUL;
  }
}
$ gcc -o 32bit_volatile_qword_read_write
32bit_volatile_qword_read_write.c -pthread -Wall
$ ./32bit_volatile_qword_read_write | head # as 64-bit binary
^C
$ gcc -m32 -o 32bit_volatile_qword_read_write
32bit_volatile_qword_read_write.c -pthread -Wall
$ ./32bit_volatile_qword_read_write | head # as 32-bit binary
shared_u64 at 0x56567030
got 0xaaaaaaaabbbbbbbb
got 0xbbbbbbbbaaaaaaaa
got 0xaaaaaaaabbbbbbbb
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
got 0xbbbbbbbbaaaaaaaa
$


AFAIK 32-bit X86 code that wants to atomically load 8 bytes of memory
has to use CMPXCHG8B; and gcc won't generate such code just based on a
volatile load/store.
