Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34160 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbcFUROS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 13:14:18 -0400
Received: by mail-lb0-f172.google.com with SMTP id oe3so15215519lbb.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2016 10:13:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALCETrWp+7+9j1vMgv5hxvtq3akZZZVdaVDfOLoFwhX+kL=Ntw@mail.gmail.com>
References: <cover.1466466093.git.luto@kernel.org> <f7855f9eae0a27f5a03db1291f46fea1cc0a2a3f.1466466093.git.luto@kernel.org>
 <CAG48ez3WGu+03HDBA5daSV+zXGoR+iFHHYxZav0o6JCM9-EPMg@mail.gmail.com> <CALCETrWp+7+9j1vMgv5hxvtq3akZZZVdaVDfOLoFwhX+kL=Ntw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 21 Jun 2016 10:13:14 -0700
Message-ID: <CAGXu5jJjihEU0HkSTWJymLZ5y=J03bkBHNgVf9QOSgWz6bf-SQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/13] fork: Add generic vmalloced stack support
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160621171314.oaJAVoAdKW0NApeMNslov8QWgy3wi9Cz4TtSUXCAwT4@z>

On Tue, Jun 21, 2016 at 9:59 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Jun 21, 2016 at 12:30 AM, Jann Horn <jannh@google.com> wrote:
>> On Tue, Jun 21, 2016 at 1:43 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>> If CONFIG_VMAP_STACK is selected, kernel stacks are allocated with
>>> vmalloc_node.
>> [...]
>>>  static struct thread_info *alloc_thread_info_node(struct task_struct *tsk,
>>>                                                   int node)
>>>  {
>>> +#ifdef CONFIG_VMAP_STACK
>>> +       struct thread_info *ti = __vmalloc_node_range(
>>> +               THREAD_SIZE, THREAD_SIZE, VMALLOC_START, VMALLOC_END,
>>> +               THREADINFO_GFP | __GFP_HIGHMEM, PAGE_KERNEL,
>>> +               0, node, __builtin_return_address(0));
>>> +
>>
>> After spender gave some hints on IRC about the guard pages not working
>> reliably, I decided to have a closer look at this. As far as I can
>> tell, the idea is that __vmalloc_node_range() automatically adds guard
>> pages unless the VM_NO_GUARD flag is specified. However, those guard
>> pages are *behind* allocations, not in front of them, while a stack
>> guard primarily needs to be in front of the allocation. This wouldn't
>> matter if all allocations in the vmalloc area had guard pages behind
>> them, but if someone first does some data allocation with VM_NO_GUARD
>> and then a stack allocation directly behind that, there won't be a
>> guard between the data allocation and the stack allocation.
>
> I'm tempted to explicitly disallow VM_NO_GUARD in the vmalloc range.
> It has no in-tree users for non-fixed addresses right now.

What about the lack of pre-range guard page? That seems like a
critical feature for this. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
