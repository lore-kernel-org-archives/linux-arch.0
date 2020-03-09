Return-Path: <SRS0=V5mr=42=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-2-yu-cheng.yu@intel.com>
 <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com>
 <0f43463e02d1be2af6bcf8ff6917e751ba7676a0.camel@intel.com>
 <968af1c2-a5b4-fb48-dfa9-499ec37f677c@intel.com>
 <fed72ecc917373669ac546d4e8214793d78bd513.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9b7ff325-d7cd-9309-d060-ad641486d106@intel.com>
Date: Mon, 9 Mar 2020 12:35:22 -0700
MIME-Version: 1.0
In-Reply-To: <fed72ecc917373669ac546d4e8214793d78bd513.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200309193522.O2Q1sRRVdSGb-bO5Hb5Dt5XQ3LkPwuuRuingq6BsFB4@z>

On 3/9/20 12:27 PM, Yu-cheng Yu wrote:
> On Mon, 2020-03-09 at 10:21 -0700, Dave Hansen wrote:
>> On 3/9/20 10:00 AM, Yu-cheng Yu wrote:
>>> On Wed, 2020-02-26 at 09:57 -0800, Dave Hansen wrote>>>>> +Note:
>>>>> +  There is no CET-enabling arch_prctl function.  By design, CET is
>>>>> +  enabled automatically if the binary and the system can support i=
t.
>>>>
>>>> This is kinda interesting.  It means that a JIT couldn't choose to
>>>> protect the code it generates and have different rules from itself?
>>>
>>> JIT needs to be updated for CET first.  Once that is done, it runs wi=
th CET
>>> enabled.  It can use the NOTRACK prefix, for example.
>>
>> Am I missing something?
>>
>> What's the direct connection between shadow stacks and Indirect Branch
>> Tracking other than Intel marketing umbrellas?
>=20
> What I meant is that JIT code needs to be updated first; if it skips RE=
Ts,
> it needs to unwind the stack, and if it does indirect JMPs somewhere it
> needs to fix up the branch target or use NOTRACK.

I'm totally lost.  I think we have very different models of how a JIT
might generate and run code.

I can totally see a scenario where a JIT goes and generates a bunch of
code, then forks a new thread to go run that code.  The control flow of
the JIT thread itself *NEVER* interacts with the control flow of the
program it writes.  They never share a stack and nothing ever jumps or
rets between the two worlds.

Does anything actually do that?  I've got no idea.  But, I can clearly
see a world where the entirety of Chrome and Firefox and the entire rust
runtime might not be fully recompiled and CET-enabled for a while.  But,
we still want the JIT-generated code to be CET-protected since it has
the most exposed attack surface.

I don't think that's too far-fetched.
