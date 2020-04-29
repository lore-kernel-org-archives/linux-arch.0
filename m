Return-Path: <SRS0=8MBO=6N=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
Date: Wed, 29 Apr 2020 15:53:00 -0700
MIME-Version: 1.0
In-Reply-To: <20200429220732.31602-2-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200429225300.GKpBRkuVPXHMzr247z_blB1WkatX5GWdY6uZrkLTVbk@z>

On 4/29/20 3:07 PM, Yu-cheng Yu wrote:
> +Note:
> +  There is no CET-enabling arch_prctl function.  By design, CET is enabled
> +  automatically if the binary and the system can support it.

I think Andy and I danced around this last time.  Let me try to say it
more explicitly.

I want CET kernel enabling to able to be disconnected from the on-disk
binary.  I want a binary compiled with CET to be able to disable it, and
I want a binary not compiled with CET to be able to enable it.  I want
different threads in a process to be able to each have different CET status.

Which JITs was this tested with?  I think as a bare minimum we need to
know that this design can accommodate _a_ modern JIT.  It would be
horrible if the browser javascript engines couldn't use this design, for
instance.
