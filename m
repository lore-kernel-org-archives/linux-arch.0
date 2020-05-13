From: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/14] prctl.2: Add health warning
Date: Wed, 13 May 2020 13:40:26 +0200
Message-ID: <7218089f-20df-52b3-e1d4-ac63e0215efc@gmail.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
 <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
 <20200513111340.GF21779@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200513111340.GF21779-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Dave,

On 5/13/20 1:13 PM, Dave Martin wrote:
> On Wed, May 13, 2020 at 12:10:25PM +0200, Michael Kerrisk (man-pages) wrote:
>> Hi Dave,
>>
>> On 5/12/20 6:36 PM, Dave Martin wrote:
>>> In reality, almost every prctl interferes with assumptions that the
>>> compiler and C library / runtime rely on.  prctl() can therefore
>>> make userspace explode in a variety ways that are likely to be hard
>>> to debug.
>>>
>>> This is not obvious to the uninitiated, so add a warning.
>>
>> Patch applied. But see my comments on patch 04. I may want to 
>> circle back on this patch later, since the wording feels a 
>> little strong to me (we simply must use prctl for some things, 
>> and not all of those things break user-space/runtime as far 
>> as I know). If you have some thoughts on softening the warning,
>> let me know.
> 
> Certainly the "if at all" can go -- this was just a suggestion
> really.

Yes. Gone.

> Maybe the whole thing is superfluous.  In C anything can screw up the
> runtime if you try hard enough.

I think it's at least worth alerting the reader to this issue.

> The background to this patch is that things like the new
> PR_PAC_RESET_KEYS and PR_SVE_SET_VL are likely to crash the program, or
> place a timebomb that will explode later when someone upgrades their
> toolchain or links with a new version of some library.  Many existing
> prctls that look equally unfriendly...
> 
> I didn't want to say nothing at all, but I didn't want to get into the
> gory details either.

(Okay.)

> Doing the digging to document the safety requirements of each prctl
> would be a lot of work, and probably an exercise in futility anyway --
> how to use a lot of prctls safely depends on the run-time environment as
> much as it does on the kernel.
> 
> 
> If you want to drop this, I'm happy to add explicit notes to just the
> new arm64 prctls instead for now.

I just softened the warning a little; see below. Explicit notes for
the new arm64 prctls would certainly be welcome.

Cheers,

Michael

diff --git a/man2/prctl.2 b/man2/prctl.2
index 7e78fc3c1..4e2d67345 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -66,10 +66,10 @@ prctl \- operations on a process or thread
 manipulates various aspects of the behavior
 of the calling thread or process.
 .PP
-Note that careless use of
+Note that careless use of some
 .BR prctl ()
-can confuse the user-space run-time environment,
-so these operations should be used with care (if at all).
+operations can confuse the user-space run-time environment,
+so these operations should be used with care.
 .PP
 .BR prctl ()
 is called with a first argument describing what to do



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
