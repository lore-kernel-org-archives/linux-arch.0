From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
Date: Wed, 8 Jul 2020 10:23:28 +0200
Message-ID: <956a05c8-529b-bf97-99ac-8958cceb35f3@digikod.net>
References: <20200707180955.53024-1-mic@digikod.net>
 <20200707180955.53024-10-mic@digikod.net>
 <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
 <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
 <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: fr
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Anton Ivanov <anton.ivanov-eaSgp5hN2EAtwqFdIEgyzdBPR1lH4CV8@public.gmane.org>, Casey Schaufler <casey-iSGtlc1asvQWG2LlvL+J4A@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jeff Dike <jdike-OPE4K8JWMJJBDgjK7y7TUQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, "Serge E . Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, Kernel Hardening <kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org>, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux-a
List-Id: linux-arch.vger.kernel.org


On 08/07/2020 09:47, Arnd Bergmann wrote:
> On Wed, Jul 8, 2020 at 9:31 AM Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org> wrote:
>> On 08/07/2020 09:22, Arnd Bergmann wrote:
>>> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org> wrote:
>>>
>>>> index f4a01305d9a6..a63a411a74d5 100644
>>>> --- a/include/uapi/asm-generic/unistd.h
>>>> +++ b/include/uapi/asm-generic/unistd.h
>>
>> OK, I'll rebase the next series on linux-next.
> 
> Just change the number to the next free one, without actually rebasing.
> It's always a bit messy to have multiple syscalls added, but I think that
> causes the least confusion.

OK, but this will lead to two merge conflicts: patch 8 (asmlinkage) and
patch 9 (tbl files).

Do you want me to update the tools/perf/arch/*.tbl too?
