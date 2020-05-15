Return-Path: <SRS0=kV/L=65=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
Date: Fri, 15 May 2020 11:39:14 -0700
MIME-Version: 1.0
In-Reply-To: <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200515183914.bCJyXIRs_svdjY5CPagdGlwlnYjji9K8WCueBFkOS9M@z>

On 5/12/20 4:20 PM, Yu-cheng Yu wrote:
> On Wed, 2020-04-29 at 16:02 -0700, Yu-cheng Yu wrote:
>> On Wed, 2020-04-29 at 15:53 -0700, Dave Hansen wrote:
>>> On 4/29/20 3:07 PM, Yu-cheng Yu wrote:
>>>> +Note:
>>>> +  There is no CET-enabling arch_prctl function.  By design, CET is enabled
>>>> +  automatically if the binary and the system can support it.
>>>
>>> I think Andy and I danced around this last time.  Let me try to say it
>>> more explicitly.
>>>
>>> I want CET kernel enabling to able to be disconnected from the on-disk
>>> binary.  I want a binary compiled with CET to be able to disable it, and
>>> I want a binary not compiled with CET to be able to enable it.  I want
>>> different threads in a process to be able to each have different CET status.
>>
>> The kernel patches we have now can be modified to support this model.  If after
>> discussion this is favorable, I will modify code accordingly.
> 
> To turn on/off and to lock CET are application-level decisions.  The kernel does
> not prevent any of those.  Should there be a need to provide an arch_prctl() to
> turn on CET, it can be added without any conflict to this series.

I spelled out what I wanted pretty clearly.  On your next post, could
you please directly address each of the things I asked for?  Please
directly answer the following questions in your next post with respect
to the code you post:

Can a binary compiled with CET run without CET?
Can a binary compiled without CET run CET-enabled code?
Can different threads in a process have different CET enabling state?

>>> Which JITs was this tested with?  I think as a bare minimum we need to
>>> know that this design can accommodate _a_ modern JIT.  It would be
>>> horrible if the browser javascript engines couldn't use this design, for
>>> instance.
>>
>> JIT work is still in progress.  When that is available I will test it.
> 
> I found CET has been enabled in LLVM JIT, Mesa JIT as well as sljit which is
> used by jit.  So the current model works with JIT.

Great!  I'm glad the model works.  That's not what I asked, though.

Does this *code* work?  Could you please indicate which JITs have been
enabled to use the code in this series?  How much of the new ABI is in use?

Where are the selftests/ for this new ABI?  Were you planning on
submitting any with this series?
