From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code and trap_nr into do_trap_no_signal
Date: Fri, 21 Sep 2018 14:45:01 +0200
Message-ID: <877ejf58aa.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-8-ebiederm@xmission.com>
        <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 18 Sep 2018 22:33:15 +0200
        (CEST)")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>
>> Half of the times when error_code and trap_nr are set are already in
>
> s/when// I think

Yes that changelog was not a good description of why I was changing
things.

>> do_trap_no_signal.  Move the other time these are set into do_trap_no_signal,
>
> Please write function as do_trap_no_signal() so it's more obvious what you
> are talking about.

That feels quite unnatural to me.

>> and give do_trap_no_signal a single exit where a signals are sent.
>
> s/a/// or s/a/all/ Not sure what you wanted to do here.
>
>> After the move the comment documeting this all is much easier to follow
>> as everything is together in one place.
>> 
>> Also update the string that is passed in to const.  The only user of that
>> str is die and it already takes a const string, so this just makes it explicit
>
> string
>
>> that the string won't change.
>> 
>> This prepares the way for adding a second caller to do_trap_no_signal.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/x86/kernel/traps.c | 29 ++++++++++++++---------------
>>  1 file changed, 14 insertions(+), 15 deletions(-)
>> 
>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index 31a689b67be3..f31c0ddee278 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -189,7 +189,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
>>  }
>>  
>>  static nokprobe_inline int
>> -do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
>> +do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
>>  		  struct pt_regs *regs,	long error_code)
>>  {
>>  	if (v8086_mode(regs)) {
>> @@ -202,10 +202,8 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
>>  						error_code, trapnr))
>>  				return 0;
>>  		}
>> -		return -1;
>>  	}
>> -
>> -	if (!user_mode(regs)) {
>> +	else if (!user_mode(regs)) {
>
> Please put that 'else if' right after the closing bracket, i.e.
>
> 	} else if (...) {
>
>>  		if (fixup_exception(regs, trapnr))
>>  			return 0;
>
> With that fixed:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Done.  The upated patch is below.

I also realized for clarity of the code I could have moved show_signal
into do_trap_no_signal as well.  I will post a follow up change where I
do that.

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 4 Aug 2017 14:01:50 -0500
Subject: [PATCH] signal/x86/traps: Move more code into do_trap_no_signal so it can be reused

The function do_trap_no_signal embodies almost all of the work of the
function do_trap.  The exceptions are setting of thread.error_code and
thread.trap_nr in the case when the signal will be sent, and reporting
which signal will be sent with show_signal.

Filling in struct siginfo and then calling do_trap is problematic as
filling in struct siginfo is an fiddly process that can through
inattention has resulted in fields not initialized and the wrong
fields being filled in.

To avoid this error prone situation I am replacing force_sig_info with
a set of functions that take as arguments the information needed to
send a specific kind of signal.

The function do_trap is called in the context of several different
kinds of signals today.  Having a solid do_trap_no_signal that
can be reused allows call sites that send different kinds of
signals to reuse all of the code in do_trap_no_signal.

Modify do_trap_no_signal to have a single exit there signals
where be sent (aka returning -1) to allow more of the signal
sending path to be moved to from do_trap to do_trap_no_signal.

Move setting thread.trap_nr and thread.error_code into do_trap_no_signal
so the code does not need to be duplicated.

Make the type of the string that is passed into do_trap_no_signal to
const.  The only user of that str is die and it already takes a const
string, so this just makes it explicit that the string won't change.

All of this prepares the way for using do_trap_no_signal outside
of do_trap.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/traps.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 31a689b67be3..f31c0ddee278 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -189,7 +189,7 @@ int fixup_bug(struct pt_regs *regs, int trapnr)
 }
 
 static nokprobe_inline int
-do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
+do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
 		  struct pt_regs *regs,	long error_code)
 {
 	if (v8086_mode(regs)) {
@@ -202,10 +202,8 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 						error_code, trapnr))
 				return 0;
 		}
-		return -1;
 	}
-
-	if (!user_mode(regs)) {
+	else if (!user_mode(regs)) {
 		if (fixup_exception(regs, trapnr))
 			return 0;
 
@@ -214,6 +212,18 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, char *str,
 		die(str, regs, error_code);
 	}
 
+	/*
+	 * We want error_code and trap_nr set for userspace faults and
+	 * kernelspace faults which result in die(), but not
+	 * kernelspace faults which are fixed up.  die() gives the
+	 * process no chance to handle the signal and notice the
+	 * kernel fault information, so that won't result in polluting
+	 * the information about previously queued, but not yet
+	 * delivered, faults.  See also do_general_protection below.
+	 */
+	tsk->thread.error_code = error_code;
+	tsk->thread.trap_nr = trapnr;
+
 	return -1;
 }
 
@@ -271,17 +281,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
-	/*
-	 * We want error_code and trap_nr set for userspace faults and
-	 * kernelspace faults which result in die(), but not
-	 * kernelspace faults which are fixed up.  die() gives the
-	 * process no chance to handle the signal and notice the
-	 * kernel fault information, so that won't result in polluting
-	 * the information about previously queued, but not yet
-	 * delivered, faults.  See also do_general_protection below.
-	 */
-	tsk->thread.error_code = error_code;
-	tsk->thread.trap_nr = trapnr;
 
 	show_signal(tsk, signr, "trap ", str, regs, error_code);
 
-- 
2.17.1
