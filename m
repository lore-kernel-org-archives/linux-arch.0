Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63641 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbaGNS7J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2014 14:59:09 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so2796811oag.11
        for <linux-arch@vger.kernel.org>; Mon, 14 Jul 2014 11:59:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
	<20140711164931.GA18473@redhat.com>
	<CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
Date: Mon, 14 Jul 2014 11:59:08 -0700
Message-ID: <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
From: Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <james.l.morris@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Alexei Starovoitov <ast@plumgrid.com>, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Daniel Borkmann <dborkman@redhat.com>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@chromium.org>, David Drysdale <drysdale@google.com>, Linux API <linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>
Message-ID: <20140714185908.Wf8khRrBdr2XHaSPdohYZekGxWz-U5wBBs3lSuLLv1U@z>

Hi James,

Is this series something you would carry in the security-next tree?
That has traditionally been where seccomp features have landed in the
past.

-Kees


On Fri, Jul 11, 2014 at 10:55 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 07/10, Kees Cook wrote:
>>>
>>> This adds the ability for threads to request seccomp filter
>>> synchronization across their thread group (at filter attach time).
>>> For example, for Chrome to make sure graphic driver threads are fully
>>> confined after seccomp filters have been attached.
>>>
>>> To support this, locking on seccomp changes via thread-group-shared
>>> sighand lock is introduced, along with refactoring of no_new_privs. Races
>>> with thread creation are handled via delayed duplication of the seccomp
>>> task struct field and cred_guard_mutex.
>>>
>>> This includes a new syscall (instead of adding a new prctl option),
>>> as suggested by Andy Lutomirski and Michael Kerrisk.
>>
>> I do not not see any problems in this version,
>
> Awesome! Thank you for all the reviews. :) If Andy and Michael are
> happy with this too, I think this is in good shape. \o/
>
> -Kees
>
>>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>
>
>
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security
