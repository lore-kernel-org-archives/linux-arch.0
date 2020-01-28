From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC v1 0/6] kunit: create a centralized executor to dispatch all
 KUnit tests
Date: Tue, 28 Jan 2020 12:36:49 -0600
Message-ID: <e801e4ac-b7c2-3d0a-71e7-f8153a3dfbc8@gmail.com>
References: <20191216220555.245089-1-brendanhiggins@google.com>
 <20200106224022.GX11244@42.do-not-panic.com>
 <CAFd5g456c2Zs7rCvRPgio83G=SrtPGi25zbqAUyTBHspHwtu4w@mail.gmail.com>
 <594b7815-0611-34ea-beb5-0642114b5d82@gmail.com>
 <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFd5g469TWzrLKmQNR2i0HACJ3FEu-=4-Rk005g9szB5UsZAcw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, Iurii Zaikin <yzaikin@google.com>, David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com, Greg KH <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Knut Omang <knut.omang@oracle.com>, linux-um <linux-um@lists.infradead.org>, linux-arch@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, KUnit Development <kunit>
List-Id: linux-arch.vger.kernel.org

On 1/28/20 1:19 AM, Brendan Higgins wrote:
> On Mon, Jan 27, 2020 at 9:40 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 1/23/20 4:40 PM, Brendan Higgins wrote:
>>> Sorry for the late reply. I am still catching up from being on vacation.
>>>>> On Mon, Jan 6, 2020 at 2:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>> It does beg the question if this means kunit is happy to not be a tool
>>>> to test pre basic setup stuff (terminology used in init.c, meaning prior
>>>> to running all init levels). I suspect this is the case.
>>>
>>> Not sure. I still haven't seen any cases where this is necessary, so I
>>> am not super worried about it. Regardless, I don't think this patchset
>>> really changes anything in that regard, we are moving from late_init
>>> to after late_init, so it isn't that big of a change for most use
>>> cases.
>>>
>>> Please share if you can think of some things that need to be tested in
>>> early init.
>>
>> I don't have a specific need for this right now.  I had not thought about
>> how the current kunit implementation forces all kunit tests to run at a
>> specific initcall level before reading this email thread.
>>
>> I can see the value of being able to have some tests run at different
>> initcall levels to verify what functionality is available and working
>> at different points in the boot sequence.
> 
> Let's cross that bridge when we get there. It should be fairly easy to
> add that functionality.

Yes. I just wanted to add the thought to the back of your mind so that
it does not get precluded by future changes to the kunit architecture.

> 
>> But more important than early initcall levels, I do not want the
>> framework to prevent using or testing code and data that are marked
>> as '__init'.  So it is important to retain a way to invoke the tests
>> while __init code and data are available, if there is also a change
>> to generally invoke the tests later.
> 
> Definitely. For now that still works as long as you don't build KUnit
> as a module, but I think Alan's new patches which allow KUnit to be
> run at runtime via debugfs could cause some difficulty there. Again,

Yes, Alan's patches are part of what triggered me thinking about the
issues I raised.


> we could add Kconfigs to control this, but the compiler nevertheless
> complains because it doesn't know what phase KUnit runs in.
> 
> Is there any way to tell the compiler that it is okay for non __init
> code to call __init code? I would prefer not to have a duplicate
> version of all the KUnit libraries with all the symbols marked __init.

I'm not sure.  The build messages have always been useful and valid in
my context, so I never thought to consider that possibility.

> Thoughts?
> .
> 
