From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v4 13/16] x86/dumpstack: Try harder to get a call trace on
 stack overflow
Date: Sun, 26 Jun 2016 09:59:44 -0700
Message-ID: <CALCETrXz_GHZzx=F3AgQ8FNQ0BJROhnvK5E6-zQd57xpBFAreA@mail.gmail.com>
References: <cover.1466741835.git.luto@kernel.org> <f76b49739625fce1264428155540ca7161925511.1466741835.git.luto@kernel.org>
 <20160624153503.oeivkn7djnxdi5oq@treble>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-3687-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20160624153503.oeivkn7djnxdi5oq@treble>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 24, 2016 at 8:35 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Jun 23, 2016 at 09:23:08PM -0700, Andy Lutomirski wrote:
>> If we overflow the stack, print_context_stack will abort.  Detect
>> this case and rewind back into the valid part of the stack so that
>> we can trace it.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
>

FWIW, I'm making a trivial change here for v4: task->stack ->
task_stack_page(task).  Since it seems inconsequential, I'm keeping
your reviewed-by.

> --
> Josh



-- 
Andy Lutomirski
AMA Capital Management, LLC
