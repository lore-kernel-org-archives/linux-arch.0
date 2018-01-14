From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 04/11] signal/parisc: Document a conflict with SI_USER with SIGFPE
Date: Sat, 13 Jan 2018 19:46:26 -0600
Message-ID: <87inc5w6tp.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-4-ebiederm@xmission.com>
        <20180112222944.GA22642@ls3530.fritz.box>
        <878td1xyda.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <878td1xyda.fsf@xmission.com> (Eric W. Biederman's message of
        "Sat, 13 Jan 2018 15:06:09 -0600")
Sender: linux-parisc-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>, John David Anglin <dave.anglin@bell.net>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Helge Deller <deller@gmx.de> writes:
>
>> * Eric W. Biederman <ebiederm@xmission.com>:
>>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>>> This is the same si_code as SI_USER.  Posix and common sense requires
>>> that SI_USER not be a signal specific si_code.  As such this use of 0
>>> for the si_code is a pretty horribly broken ABI.
>>> 
>>> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
>>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>>> that uid and pid fields are copied and which might copying the si_addr
>>> field by accident but certainly not by design.  Making this a very
>>> flakey implementation.
>>> 
>>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>>> appropriate fields will reliably be copied.
>>> 
>>> This bug is 13 years old and parsic machines are no longer being built
>>> so I don't know if it possible or worth fixing it.  But it is at least
>>> worth documenting this so other architectures don't make the same
>>> mistake.
>>
>>
>> I think we should fix it, even if we now break the ABI.
>>
>> It's about a "conditional trap" which needs to be handled by userspace.
>> I doubt there is any Linux code out which is utilizing this
>> parisc-specific trap.
>>
>> I'd suggest to add a new FPE trap si_code (e.g. FPE_CONDTRAP).
>> While at it, maybe we should include the already existing FPE_MDAOVF
>> from the frv architecture, so that arch/frv/include/uapi/asm/siginfo.h
>> can go completely.
>>
>> Suggested patch is below.
>>
>> I'm willing to test the patch below on the parisc architecture for a few
>> weeks. And it will break arch/x86/kernel/signal_compat.c which needs
>> looking at then too.
>>
>> Thoughts?
>
> I like it.

Your comments about the si_codes caused me to look into how they differ
across the architectures and realize they also all need to be merged
into uapi/asm-generic/siginfo.h for sanity sake.   In doing so I found
a couple of minor issues with my other unifications.

Rebased onto my tree your patch looks like the below.  If it does not
cause any regressions it looks like a perfect fix.  The noticable change
is that the first FPE si_code available across all architectures is 14
so I have used 14 instead of 10 for FPE_CONDTRAP.

Eric

From: Helge Deller <deller@gmx.de>
Date: Sat, 13 Jan 2018 19:32:43 -0600
Subject: [PATCH] signal/parisc: Add FPE_CONDTRAP for conditional trap handling

Posix and common sense requires that SI_USER not be a signal specific
si_code.  Thus add a new FPE_CONDTRAP si_code for conditional traps.

-- EWB rebased onto my tree.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/parisc/include/uapi/asm/siginfo.h | 7 -------
 arch/parisc/kernel/traps.c             | 7 ++++---
 include/uapi/asm-generic/siginfo.h     | 3 ++-
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/siginfo.h b/arch/parisc/include/uapi/asm/siginfo.h
index be40331f757d..4a1062e05aaf 100644
--- a/arch/parisc/include/uapi/asm/siginfo.h
+++ b/arch/parisc/include/uapi/asm/siginfo.h
@@ -8,11 +8,4 @@
 
 #include <asm-generic/siginfo.h>
 
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
 #endif
diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
index c919e6c0a687..68e671a11987 100644
--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -627,9 +627,10 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
 		   on condition  */
 		if(user_mode(regs)){
 			si.si_signo = SIGFPE;
-			/* Set to zero, and let the userspace app figure it out from
-			   the insn pointed to by si_addr */
-			si.si_code = FPE_FIXME;
+			/* Let userspace app figure it out from the insn pointed
+			 * to by si_addr.
+			 */
+			si.si_code = FPE_CONDTRAP;
 			si.si_addr = (void __user *) regs->iaoq[0];
 			force_sig_info(SIGFPE, &si, current);
 			return;
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 254afc31e3be..ab4fad1a0cf0 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -229,7 +229,8 @@ typedef struct siginfo {
 # define __FPE_INVASC	12	/* invalid ASCII digit */
 # define __FPE_INVDEC	13	/* invalid decimal digit */
 #endif
-#define NSIGFPE		13
+#define FPE_CONDTRAP	14	/* trap on condition */
+#define NSIGFPE		14
 
 /*
  * SIGSEGV si_codes
-- 
2.14.1


