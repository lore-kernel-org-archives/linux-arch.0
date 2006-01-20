Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([69.30.125.51]:39654 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1161385AbWATANz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jan 2006 19:13:55 -0500
Received: from [10.107.17.130]
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1B85CF> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 19 Jan 2006 16:13:50 -0800
Date: Thu, 19 Jan 2006 16:13:49 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: new syscalls
In-Reply-To: <Pine.LNX.4.63.0601191347160.6527@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0601191606300.6527@localhost.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
 <20060118133629.1cda96fd.akpm@osdl.org> <Pine.LNX.4.63.0601181714330.6878@localhost.localdomain>
 <20060118172802.5155048f.akpm@osdl.org> <Pine.LNX.4.63.0601191347160.6527@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: tony.luck@intel.com, linux-arch@vger.kernel.org, janak@us.ibm.com, Ulrich Drepper <drepper@redhat.com>, dwmw2@infradead.org, dhowells@redhat.com, christoph@lameter.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 19 Jan 2006, Davide Libenzi wrote:

> On Wed, 18 Jan 2006, Andrew Morton wrote:
>
>> Davide Libenzi <davidel@xmailserver.org> wrote:
>>> 
>>> How sophisticated this has to be?
>> 
>> umm
>> 
>> - test basic functionality
>> 
>> - test things which should fail: syscall arguments out-of-bounds,
>>  negative syscall args, etc.  invalid fd.  valid fd but for the wrong type
>>  of file.
>> 
>> - if you can, something which will test the 32bit->64bit->32bit
>>  conversions which 32-bit userspace on 64-bit kernel needs to do.
>
> Somehow, I knew I didn't have to ask :)

Here you go:

http://www.xmailserver.org/epoll_pwait_test.c

There is a problem with the test we have inside the kernel about the size 
of sigset_t, from the kernel (8 bytes on i386) and the glibc one (128 bytes):

         if (sigmask) {
                 if (sigsetsize != sizeof(sigset_t))
                         return -EINVAL;
                 if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
                         return -EFAULT;
                 sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
                 sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
         }

ATM I left the check and I bolt 8 inside the test software, but this needs 
nicer handling. Typical run will show:

davide@debstar:~/tmp$ ./epoll_pwait_test
Testing from wrong epfd type            : OK
Testing from closed epfd type           : OK
Testing numevents <= 0                  : OK
Testing numevents too big               : OK
Testing wrong sigmask size              : OK
Testing getevents when none available   : OK
Testing getevents when one available    : OK
Testing signal when blocked             : OK
Testing signal when non blocked         : OK




- Davide


