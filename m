From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH -resend 01/27] linkage: new macros for assembler symbols
Date: Sun, 13 May 2018 20:04:37 -0700
Message-ID: <e5e17ecd-0e74-7766-e730-333004ada199@infradead.org>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-2-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510080644.19752-2-jslaby@suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, hpa@zytor.com, Ingo Molnar <mingo@kernel.org>, jpoimboe@redhat.com, Juergen Gross <jgross@suse.com>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xenproject.org, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/10/2018 01:06 AM, Jiri Slaby wrote:

> ---
>  Documentation/asm-annotations.rst | 218 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/linkage.h    |  10 +-
>  include/linux/linkage.h           | 257 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 475 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/asm-annotations.rst
> 
> diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
> new file mode 100644
> index 000000000000..3e9b426347f0
> --- /dev/null
> +++ b/Documentation/asm-annotations.rst
> @@ -0,0 +1,218 @@
> +Assembler Annotations
> +=====================
> +
> +Copyright (c) 2017 Jiri Slaby

[snip]

> +This is not only important for debugging purposes. When we have properly
> +marked objects like this, we can run tools on them and let the tools generate
> +more useful information. In particular, on properly marked objects, we can run
> +``objtool`` and let it check and fix the object if needed. Currently, it can
> +report missing frame pointer setup/destruction in functions. It can also
> +automatically generate annotations for *ORC unwinder* (cf.
> +<Documentation/x86/orc-unwinder.txt>) for most code. Both of this is

                                                        Both of these are

> +especially important to support reliable stack traces which are in turn
> +necessary for *Kernel live patching* (see
> +<Documentation/livepatch/livepatch.txt>).
> +
> +Caveat and Discussion
> +---------------------
> +As one might realize, there were only three macros previously. That is indeed
> +insufficient to cover all the combinations of cases:
> +
> +* standard/non-standard function
> +* code/data
> +* global/local symbol
> +
> +We had a discussion_ and instead of extending the current ``ENTRY/END*``
> +macros, it was decided that we shoould introduce brand new macros instead::

                                  should

> +
> +    So how about using macro names that actually show the purpose, instead
> +    of importing all the crappy, historic, essentially randomly chosen
> +    debug symbol macro names from the binutils and older kernels?
> +
> +.. _discussion: https://marc.info/?i=20170217104757.28588-1-jslaby%40suse.cz
> +
> +Macros Description
> +------------------
> +
> +The new macros are prefixed with the ``SYM_`` prefix and can be divided into
> +three main groups:
> +
> +1. ``SYM_FUNC_*`` -- to annotate C-like functions. This means functions with
> +   standard C calling conventions, i.e. the stack contains a return address at
> +   the predefined place and a return from the function can happen in a
> +   standard way. When frame pointers are enabled, save/restore of frame
> +   pointer shall happen at the start/end of a function, respectively, too.
> +
> +   Checking tools like ``objtool`` should ensure such marked functions conform
> +   to these rules. The tools can also easily annotate these functions with
> +   debugging information (like *ORC data*) automatically.
> +
> +2. ``SYM_CODE_*`` -- special functions called with special stack. Be it
> +   interrupt handlers with special stack content, trampolines, or startup
> +   functions.
> +
> +   Checking tools mostly ignore checking of these functions. But some debug
> +   information still can be generated automatically. For correct debug data,
> +   this code needs hints like ``UNWIND_HINT_REGS`` provided by developers.
> +
> +3. ``SYM_DATA*`` -- obviosly data belonging to ``.data`` sections and not to

                       obviously

> +   ``.text``. Data do not contain instructions, so they have to be treated
> +   specially by the tools: they should not treat the bytes as instructions,
> +   neither assign any debug information to them.

      nor assign

> +
> +Instruction Macros
> +~~~~~~~~~~~~~~~~~~
> +This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
> +

[snip]

> +
> +Data Macros
> +~~~~~~~~~~~
> +Similar to instructions, we have a couple of macros to describe data in the
> +assembly. Again, they help debuggers to understand the layout of the resulting
> +object files.
> +
> +* ``SYM_DATA_START`` and ``SYM_DATA_START_LOCAL`` mark the start of some data
> +  and shall be in couple with either ``SYM_DATA_END``, or

(maybe:) and shall be used in conjunction with either

> +  ``SYM_DATA_END_LABEL``. The latter adds also a label to the end, so that
> +  people can use ``lstack`` and (local) ``lstack_end`` in the following
> +  example::
> +
> +    SYM_DATA_START_LOCAL(lstack)
> +        .skip 4096
> +    SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
> +
> +* ``SYM_DATA`` and ``SYM_DATA_LOCAL`` are variants for simple, mostly one-line
> +  data::
> +
> +    SYM_DATA(HEAP,     .long rm_heap)
> +    SYM_DATA(heap_end, .long rm_stack)
> +
> +  In the end, they expand to ``SYM_DATA_START`` with ``SYM_DATA_END``
> +  internally.
> +
> +Support Macros
> +~~~~~~~~~~~~~~
> +All the above reduce themselves to some invocation of ``SYM_START``,
> +``SYM_END``, or ``SYM_ENTRY`` at last. Normally, developers should avoid using
> +these.
> +
> +Further, in the above examples, one could saw ``SYM_L_LOCAL``. There are also

                                             see

> +``SYM_L_GLOBAL`` and ``SYM_L_WEAK``. All are deserved to denote linkage of a

                                                eh?  defined? reserved? intended?

> +symbol marked by them. They are used either in ``_LABEL`` variants of the
> +earlier macros, or in ``SYM_START``.
> +
> +
> +Overriding Macros
> +~~~~~~~~~~~~~~~~~
> +Architecture can also override any of the macros in their own
> +``asm/linkage.h``.  Including macros specifying the type of a symbol

                    , including

> +(``SYM_T_FUNC``, ``SYM_T_OBJECT``, and ``SYM_T_NONE``).  As every macro
> +described in this file is surrounded by ``#ifdef`` + ``#endif``, it is enough
> +to define the macros differently in the aforementioned architecture-dependent
> +header.

HTH.
-- 
~Randy
