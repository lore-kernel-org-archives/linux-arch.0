Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:42693 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPXSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Oct 2018 19:18:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
        <87va62lri4.fsf@xmission.com>
        <6211eeaa-ce07-a909-e4c2-172618ddfb95@cisco.com>
Date: Tue, 16 Oct 2018 10:26:50 -0500
In-Reply-To: <6211eeaa-ce07-a909-e4c2-172618ddfb95@cisco.com> (Enke Chen's
        message of "Mon, 15 Oct 2018 17:54:43 -0700")
Message-ID: <87ftx5kj45.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Message-ID: <20181016152650.MC9EAAO_pHykFF-8-X_edCcCvdxA9sElLLaQcilhLDs@z>

Enke Chen <enkechen@cisco.com> writes:

> Hi, Eric:
>
> On 10/15/18 4:28 PM, Eric W. Biederman wrote:

>> With that said I think the best solution would be to figure out how to
>> allow the coredump to run in parallel with the usual exit signal, and
>> exit code reaping of the process> 
>> That would solve the problem for everyone, and would not introduce any
>> new complicated APIs.
>
> That would certainly help. But given the huge deployment of Linux, I don't
> think it would be feasible to change this fundamental behavior (signal post
> coredump).

Of course it will be feasible to change.  Make it a sysctl and keep the
current default and no one will even notice.  Waiting for something that
is happening asynchronously is not be difficult so having the wait
optional should not be a problem.

Right now the default in most distributions is to disable core dumps
entirely.   Which means that you are going to have to find a very
specific situation in which people and applications care about core
dumps happening to break an existing setup.

Then all you have to do to get the non-blocking behavior is to just do:
echo 1 > /proc/sys/kernel_core_async

Then everything else works without modifications and everyone is happy.
Maybe I am wearing rose colored glasses but that looks like all that is
needed and it should be much easier to work with and maintain than
having to modify every manager process to listen for unreliable signals,
and then take action on those unreliable signals.

Eric
