From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/7] test_user_copy improvements
Date: Wed, 5 Aug 2015 13:26:09 -0700
Message-ID: <CAGXu5jJd4EH37B51zxphYkwp6RBOkYuwiGNr7C6nJK2q=JE79A@mail.gmail.com>
References: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438789735-4643-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 5, 2015 at 8:48 AM, James Hogan <james.hogan@imgtec.com> wrote:
> These patches extend the test_user_copy test module to handle lots more
> cases of user accessors which architectures can override separately, and
> in particular those which are important for checking the MIPS Enhanced
> Virtual Addressing (EVA) implementations, which need to handle
> overlapping user and kernel address spaces, with special instructions
> for accessing user address space from kernel mode.
>
> - Checking that kernel pointers are accepted when user address limit is
>   set to KERNEL_DS, as done by the kernel when it internally invokes
>   system calls with kernel pointers.
> - Checking of the unchecked accessors (which don't call access_ok()).
>   Some of the tests are special cased for EVA at the moment which has
>   stricter hardware guarantees for bad user accesses than other
>   configurations.
> - Checking of other sets of user accessors, including the inatomic user
>   copies, copy_in_user, clear_user, the user string accessors, and the
>   user checksum functions, all of which need special handling in arch
>   code with EVA.
>
> Tested on MIPS with and without EVA, and on x86_64.
>
> James Hogan (7):
>   test_user_copy: Check legit kernel accesses
>   test_user_copy: Check unchecked accessors
>   test_user_copy: Check __clear_user()/clear_user()
>   test_user_copy: Check __copy_in_user()/copy_in_user()
>   test_user_copy: Check __copy_{to,from}_user_inatomic()
>   test_user_copy: Check user string accessors
>   test_user_copy: Check user checksum functions
>
>  lib/test_user_copy.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 221 insertions(+)
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Ooooh! Nice! This is great, thank you. :) Great to hear it helped find
a bug too. :)

I'm wondering if we need to macro-ize any of these. Probably not, but
it just feels like there's a lot of repeated stuff now. But I think
it's a bit of an illusion since each test is ever so slightly
different from the others.

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Chrome OS Security
