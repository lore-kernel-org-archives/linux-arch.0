From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 13/22] signal: Move addr_lsb into the _sigfault union for clarity
Date: Fri, 16 Mar 2018 16:08:49 -0500
Message-ID: <87k1ubbue6.fsf@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
        <20180116004009.31036-13-ebiederm@xmission.com>
        <29eb3438-0891-36ee-e5f6-36e26ccf2b89@intel.com>
        <818f8945-f990-a770-476e-f82bdc77dbda@intel.com>
        <87efkjeqe8.fsf@xmission.com>
        <ccd9afa6-15d1-3e41-c1a4-3352d09c37a4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ccd9afa6-15d1-3e41-c1a4-3352d09c37a4@intel.com> (Dave Hansen's
        message of "Fri, 16 Mar 2018 13:33:16 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>
List-Id: linux-arch.vger.kernel.org

Dave Hansen <dave.hansen@intel.com> writes:

> On 03/16/2018 01:06 PM, Eric W. Biederman wrote:
>>> It does not revert cleanly so I reverted it manually.  Patch doing that
>>> is attached.  Should we do this, or is there a better option?
>> Please see:
>> 859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")
>
> It would be really nice to actually cc the folks that wrote and maintain
> the code when you both break their stuff and fix it.  I don't see myself
> or the x86 maintainers cc'd on any of this: the patch that caused the
> breakage *or* the fix.

What I touched was in no way x86 or pkey specific code. The email alias
for all of the arch maintainers in the kernel is called linux-arch.  It
is hard to find who cares bits of essentially unmaintained code in the
kernel.

The fix was merged via the usual process and is available to everyone,
and is not hard to find.  It was labeled with an appropriate fixes tag.

I was also very careful to ensure that I fixed the regression I
accidentally introduced and did not introduce another ABI regression
with any other field:
 f6a015498dca ("signal/x86: Include the field offsets in the build time checks")

Eric
