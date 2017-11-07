From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH v9 00/51] powerpc, mm: Memory Protection Keys
Date: Tue, 07 Nov 2017 08:32:16 +0100
Message-ID: <87h8u6lf27.fsf@mid.deneb.enyo.de>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
        <87efpbm706.fsf@mid.deneb.enyo.de>
        <20171107012218.GA5546@ram.oc3035372033.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from albireo.enyo.de ([5.158.152.32]:52836 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755331AbdKGHcf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Nov 2017 02:32:35 -0500
In-Reply-To: <20171107012218.GA5546@ram.oc3035372033.ibm.com> (Ram Pai's
        message of "Mon, 6 Nov 2017 17:22:18 -0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de, linux-arch@vger.kernel.org, ebiederm@xmission.com, linux-doc@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, linux-kselftest@vger.kernel.org, bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com

* Ram Pai:

> On Mon, Nov 06, 2017 at 10:28:41PM +0100, Florian Weimer wrote:
>> * Ram Pai:
>> 
>> > Testing:
>> > -------
>> > This patch series has passed all the protection key
>> > tests available in the selftest directory.The
>> > tests are updated to work on both x86 and powerpc.
>> > The selftests have passed on x86 and powerpc hardware.
>> 
>> How do you deal with the key reuse problem?  Is it the same as x86-64,
>> where it's quite easy to accidentally grant existing threads access to
>> a just-allocated key, either due to key reuse or a changed init_pkru
>> parameter?
>
> I am not sure how on x86-64, two threads get allocated the same key
> at the same time? the key allocation is guarded under the mmap_sem
> semaphore. So there cannot be a race where two threads get allocated
> the same key.

The problem is a pkey_alloc/pthread_create/pkey_free/pkey_alloc
sequence.  The pthread_create call makes the new thread inherit the
access rights of the current thread, but then the key is deallocated.
Reallocation of the same key will have that thread retain its access
rights, which is IMHO not correct.

> Can you point me to the issue, if it is already discussed somewhere?

See ‘MPK: pkey_free and key reuse’ on various lists (including
linux-mm and linux-arch).

It has a test case attached which demonstrates the behavior.

> As far as the semantics is concerned, a key allocated in one thread's
> context has no meaning if used in some other threads context within the
> same process.  The app should not try to re-use a key allocated in a
> thread's context in some other threads's context.

Uh-oh, that's not how this feature works on x86-64 at all.  There, the
keys are a process-global resource.  Treating them per-thread
seriously reduces their usefulness.

>> What about siglongjmp from a signal handler?
>
> On powerpc there is some relief.  the permissions on a key can be
> modified from anywhere, including from the signal handler, and the
> effect will be immediate.  You dont have to wait till the
> signal handler returns for the key permissions to be restore.

My concern is that the signal handler knows nothing about protection
keys, but the current x86-64 semantics will cause it to clobber the
access rights of the current thread.

> also after return from the sigsetjmp();
> possibly caused by siglongjmp(), the program can restore the permission
> on any key.

So that's not really an option.

> Atleast that is my theory. Can you give me a testcase; if you have one
> handy.

The glibc patch I posted under the ‘MPK: pkey_free and key reuse’
thread covers this, too.
