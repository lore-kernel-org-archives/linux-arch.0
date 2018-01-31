From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [GIT PULL] siginfo fix for 4.16-rc1
Date: Wed, 31 Jan 2018 13:57:28 -0600
Message-ID: <878tcdls2f.fsf@xmission.com>
References: <87372oph61.fsf@xmission.com> <87a7wwnkce.fsf@xmission.com>
        <87607im26i.fsf_-_@xmission.com>
        <CA+55aFz+uhHRRDPHW_OU+MXmrpKdE3Eb=okczd5_0STaTDe8sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFz+uhHRRDPHW_OU+MXmrpKdE3Eb=okczd5_0STaTDe8sQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 31 Jan 2018 11:30:58 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jan 31, 2018 at 8:19 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I had a brain fart when I received Stephen email about a compile failure
>> in linux-next.  I thought the powerpc call to memory_failure had not
>> merged yet.  Instead it simply failed to compile :(
>>
>> Linus can you please pull Stephen's fix so that powerpc builds correctly.
>
> I fixed this up in the merge already, afaik. Or is there some other failure?

My bad.  I missed you fixed it in the merge.

I received a kbuild failure against linux-next this morning, and I
realized the build failure was against code that was already in 2.15 so
I should have patched and fixed that myself.

At which point I assumed the failure was because my siginfo code had
been merged into your tree.

Looking again you definitely fixed this in the merge.  So I don't know
the story of the broken kbuild of linux-next.  But I assume it will
sort itself out when the dust clears.

Apologies for the noise,
Eric
