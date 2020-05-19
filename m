From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Date: Mon, 18 May 2020 17:38:13 -0700
Message-ID: <2eb98637-bd2d-dda6-7729-f06ea84256ca@intel.com>
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
 <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
 <075c5757d6c4d3813f7ae45288b765d76de8b6fc.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <075c5757d6c4d3813f7ae45288b765d76de8b6fc.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 5/18/20 4:47 PM, Yu-cheng Yu wrote:
> On Fri, 2020-05-15 at 19:53 -0700, Yu-cheng Yu wrote:
>> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
>>> On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
>>>> [...]
>>>> I have run them with CET enabled.  All of them pass, except for the following:
>>>> Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64-bit
>>>> address.  This is understandable.
>>> [...]
>>> One a separate topic: You ran the selftests and one failed.  This is a
>>> *MASSIVE* warning sign.  It should minimally be described in your cover
>>> letter, and accompanied by a fix to the test case.  It is absolutely
>>> unacceptable to introduce a kernel feature that causes a test to fail.
>>> You must either fix your kernel feature or you fix the test.
>>>
>>> This code can not be accepted until this selftests issue is rectified.
> The x86/sigreturn test constructs 32-bit ldt entries, and does sigreturn from
> 64-bit to 32-bit context.  We do not have a way to construct a static 32-bit
> shadow stack.

Why? What's the limiting factor?  Hardware architecture?  Something in
the kernel?

> Why do we want that?  I think we can simply run the test with CET
> disabled.

The sadistic parts of selftests/x86 come from real bugs.  Either bugs
where the kernel fell over, or where behavior changed that broke apps.
I'd suggest doing some research on where that particular test case came
from.  Find the author of the test, look at the changelogs.

If this is something that a real app does, this is a problem.  If it's a
sadistic test that Andy L added because it was an attack vector against
the entry code, it's a different story.

I don't personally know the background, but the changelogs can help you
find the person that does.
