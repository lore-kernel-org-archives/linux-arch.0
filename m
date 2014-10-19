Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:43358 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaJSAVM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 18 Oct 2014 20:21:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1401975635-6162-1-git-send-email-drysdale@google.com>
	<CALCETrVraoD+r4zxBoGd+BV5P275AXcRV_R00SSr8fjQzRHnUg@mail.gmail.com>
Date: Sat, 18 Oct 2014 17:20:29 -0700
In-Reply-To: <CALCETrVraoD+r4zxBoGd+BV5P275AXcRV_R00SSr8fjQzRHnUg@mail.gmail.com>
	(Andy Lutomirski's message of "Fri, 17 Oct 2014 14:45:03 -0700")
Message-ID: <87zjcszz8y.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCHv4 RESEND 0/3] syscalls,x86: Add execveat() system call
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: David Drysdale <drysdale@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Meredydd Luff <meredydd@senatehouse.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20141019002029.g74eh5BhRhh4af0TCdcAXhdcJMSZEcpBq5uHcWQsmhk@z>

Andy Lutomirski <luto@amacapital.net> writes:

> [Added Eric Biederman, since I think your tree might be a reasonable
> route forward for these patches.]
>
> On Thu, Jun 5, 2014 at 6:40 AM, David Drysdale <drysdale@google.com> wrote:
>> Resending, adding cc:linux-api.
>>
>> Also, it may help to add a little more background -- this patch is
>> needed as a (small) part of implementing Capsicum in the Linux kernel.
>>
>> Capsicum is a security framework that has been present in FreeBSD since
>> version 9.0 (Jan 2012), and is based on concepts from object-capability
>> security [1].
>>
>> One of the features of Capsicum is capability mode, which locks down
>> access to global namespaces such as the filesystem hierarchy.  In
>> capability mode, /proc is thus inaccessible and so fexecve(3) doesn't
>> work -- hence the need for a kernel-space
>
> I just found myself wanting this syscall for another reason: injecting
> programs into sandboxes or otherwise heavily locked-down namespaces.
>
> For example, I want to be able to reliably do something like nsenter
> --namespace-flags-here toybox sh.  Toybox's shell is unusual in that
> it is more or less fully functional, so this should Just Work (tm),
> except that the toybox binary might not exist in the namespace being
> entered.  If execveat were available, I could rig nsenter or a similar
> tool to open it with O_CLOEXEC, enter the namespace, and then call
> execveat.
>
> Is there any reason that these patches can't be merged more or less as
> is for 3.19?

Yes.  There is a silliness in how it implements fexecve.  The fexecve
case should be use the empty string "" not a NULL pointer to indication
that.  That change will then harmonize execveat with the other ...at
system calls and simplify the code and remove a special case.  I believe
using the empty string "" requires implementing the AT_EMPTY_PATH flag.

For sandboxes execveat seems to make a great deal of sense.  I can
get the same functionality by passing in a directory file descriptor
calling fchdir and execve so this should not introduce any new security
holes.  And using the final file descriptor removes a race.

AT_SYMLINK_NOFOLLOW seems to have some limited utility as well, although
for exec I don't know what problems it can solve.

Until I am done moving I won't have time to pick this up, and the code
clearly needs another revision but I will be happy to work to see that
we get a sane execveat implemented.

Eric

p.s.  I don't believe there are any namespaces issues where doing
something with execveat flags make sense.


