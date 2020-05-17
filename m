From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Sun, 17 May 2020 16:09:39 -0700
Message-ID: <042a0b0e-bbf0-53d7-91b2-ea113ca8cca5@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
 <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
 <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
 <CAMe9rOq_pCUz4wTQUyGCjyLpSkj4i3YO0XpZecADEp5cF=FhsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMe9rOq_pCUz4wTQUyGCjyLpSkj4i3YO0XpZecADEp5cF=FhsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, the arch/x86 maintainers <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MM <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 5/15/20 7:51 PM, H.J. Lu wrote:
> On Fri, May 15, 2020 at 4:56 PM Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> Let's say we have an app doing silly things like retpolines.  (Lots of
>> app do lots of silly things).  It gets compiled in a distro but never
>> runs on a system with CET.  The app gets run for the first time on a
>> system with CET.  App goes boom.  Not init, just some random app, say
>> /usr/bin/ldapsearch.
> 
> I designed and implemented CET toolchain and run-time in such a way
> for it very difficult to happen.   Basically, CET won't be enabled on such
> an app.

Would you care to share any specifics about how this is implemented?
That would be great information to include in the kernel documentation
because it informs us about the reasons why we don't need a kernel-based
"kill switch".

>> What's my recourse as an end user?  I want to run my app and turn off
>> CET for that app.  How can I do that?
> 
> The CET OS I designed turns CET off for you and you don't have to do
> anything.

OK, cool!  Could you share some of the specifics about how it does that?

>>         Is it possible with the patches in this series to run a single-
>>         threaded binary which was has GNU_PROPERTY_X86_FEATURE_1_SHSTK
>>         unset to run with shadow stack protection?
> 
> Yes, you can.  I added such capabilities for testing purpose.  But
> you application will crash as soon as there is a CET violation.  My
> CET software design is very flexible. 

Yu-cheng speficially referred to the:

	GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT

option.  Is that the option you're talking about?

>>> I have a quick test that checks shadow stack and ibt in both main program and in
>>> signals.  Currently it is public on Github.  If that is desired, I can submit it
>>> to the mailing list.
>>
>> Yes, that is desired.  It must accompany this submission.  It must also
>> exercise all of the new ABIs.
> 
> Our CET smoke test is for quick validation of CET OS, not just
> kernel. It requires the complete CET implementation.   It does
> nothing if your OS isn't CET enabled.
I think requiring the complete CET implementation to be present for this
test to work is a mistake.  We don't require anything other than an
enabled kernel and the selftests that ship with that kernel.

MPX required toolchain, library and compiler changes.  Yet, we had a
totally standalone kernel test that found real bugs.  It sounds like
this smoke test as it stands wouldn't be a great fit.  But, that
shouldn't discourage us from finding something that _is_ a good fit for
the kernel-shipped selftests.
