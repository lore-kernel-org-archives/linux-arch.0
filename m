Return-Path: <SRS0=aoLA=42=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
References: <CAMe9rOoRTVUzNC88Ho2XTTNJCymrd3L=XdB9xFcgxPVwAZ0FWA@mail.gmail.com>
 <AE81FEF5-ECC5-46AA-804D-9D64E656D16E@amacapital.net>
 <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0088001c-0b12-a7dc-ff2a-9d5c282fa36b@intel.com>
Date: Mon, 9 Mar 2020 13:59:52 -0700
MIME-Version: 1.0
In-Reply-To: <CAMe9rOoDMenvD9XRL1szR5yLQEwv9Q6f4O7CtwbdZ-cJqzezKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200309205952.Zkdcd650_f7KQDz8uLJx-kndO7uSfpWLUDj5rFGBLV8@z>

On 3/9/20 1:54 PM, H.J. Lu wrote:
>> If a program with the magic ELF CET flags missing can’t make a
>> thread with IBT and/or SHSTK enabled, then I think we’ve made an
>> error and should fix it.
>> 
> A non-CET program can start a CET program and vice versa.

Could we be specific here, please?

HJ are you saying that:
* CET program can execve() a non-CET program, and
* a non-CET program can execve() a CET program

?

That's obvious.

But what are the rules for clone()?  Should there be rules for
mismatches for CET enabling between threads if a process (not child
processes)?
