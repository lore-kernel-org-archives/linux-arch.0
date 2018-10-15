Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alln-iport-1.cisco.com ([173.37.142.88]:4250 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeJPCfq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 22:35:46 -0400
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181013064023.GA28177@kroah.com>
 <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
 <20181015184358.GA12153@kroah.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <614dad0f-97e3-91b4-0c29-c052d01922eb@cisco.com>
Date: Mon, 15 Oct 2018 11:49:11 -0700
MIME-Version: 1.0
In-Reply-To: <20181015184358.GA12153@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
Message-ID: <20181015184911.OA-9OxF5SyWNjT7IZELIQ8h7XFnWPvofxSqT7Ddl4UY@z>

Hi, Greg:

On 10/15/18 11:43 AM, Greg Kroah-Hartman wrote:
> On Mon, Oct 15, 2018 at 11:16:36AM -0700, Enke Chen wrote:
>> Hi, Greg:
>>
>>> Shouldn't there also be a manpage update, and a kselftest added for this
>>> new user/kernel api that is being created?
>>>
>>
>> I will submit a patch for manpage update once the code is accepted.
> 
> Writing a manpage update is key to see if what you are describing
> actually matches the code you have submitted.  You should do both at the
> same time so that they can be reviewed together.

Ok, will do at the same time. But should I submit it as a separate patch?

> 
>> Regarding the kselftest, I am not sure.  Once the prctl() is limited to
>> self (which I will do), the logic would be pretty straightforward. Not
>> sure if the selftest would add much value.
> 
> If you do not have a test for this feature, how do you know it even
> works at all?  How will you know if it breaks in a future kernel
> release?  Have you tested this?  If so, how?

I have the test code. I am just not sure whether I should submit and check
it in to the kselftest?

Thanks.  -- Enke
