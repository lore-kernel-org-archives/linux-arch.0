From: Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Tue, 28 Jul 2020 10:30:41 -0400
Message-ID: <54599ed9-99f1-378e-bccf-ba41ef1f8217@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:59162 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgG1Obl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jul 2020 10:31:41 -0400
In-Reply-To: <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com

On 7/28/2020 10:23 AM, Andy Lutomirski wrote:
>> On Jul 27, 2020, at 10:02 AM, Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>>
>> ﻿This patchset adds support for preserving an anonymous memory range across
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>> sharing memory in this manner, as opposed to re-attaching to a named shared
>> memory segment, is to ensure it is mapped at the same virtual address in
>> the new process as it was in the old one.  An intended use for this is to
>> preserve guest memory for guests using vfio while qemu exec's an updated
>> version of itself.  By ensuring the memory is preserved at a fixed address,
>> vfio mappings and their associated kernel data structures can remain valid.
>> In addition, for the qemu use case, qemu instances that back guest RAM with
>> anonymous memory can be updated.
> 
> This will be an amazing attack surface. Perhaps use of this flag should require no_new_privs?  Arguably it should also require a special flag to execve() to honor it.  Otherwise library helpers that do vfork()+exec() or posix_spawn() could be quite surprised.

Preservation is disabled across fork, so fork/exec combo's are not affected.  We forgot to document that.

- Steve
