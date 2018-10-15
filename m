From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 12:23:45 -0700
Message-ID: <a8638ed9-1ca8-ef03-c988-c17ce9a6ed39@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
 <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com>
 <CAG48ez2ZD=dovBApR07wi_DzYjJvEyO-Pm35eLv9AyXv1tcAFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG48ez2ZD=dovBApR07wi_DzYjJvEyO-Pm35eLv9AyXv1tcAFQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com, mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A . Shutemov" <kirill.sh>
List-Id: linux-arch.vger.kernel.org

Hi, Jann:

Thanks for your detail explanation. Will take care of it.

-- Enke

On 10/15/18 11:54 AM, Jann Horn wrote:
> On Mon, Oct 15, 2018 at 8:36 PM Enke Chen <enkechen@cisco.com> wrote:
>> On 10/13/18 11:27 AM, Jann Horn wrote:
>>> On Sat, Oct 13, 2018 at 2:33 AM Enke Chen <enkechen@cisco.com> wrote:
>>>> For simplicity and consistency, this patch provides an implementation
>>>> for signal-based fault notification prior to the coredump of a child
>>>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>>>> be used by an application to express its interest and to specify the
>>>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>>>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>>
>>> Your suggested API looks vaguely similar to PR_SET_PDEATHSIG, but with
>>> some important differences:
>>>
>>>  - You don't reset the signal on setuid execution.
> [...]
>>>
>>> For both of these: Are these differences actually necessary, and if
>>> so, can you provide a specific rationale? From a security perspective,
>>> I would very much prefer it if this API had semantics closer to
>>> PR_SET_PDEATHSIG.
>>
> [...]
>>
>> Regarding the impact of "setuid", this property "PR_SET_PREDUMP_SIG" has to
>> do with the application/process whether the signal handler is set for receiving
>> such a notification.  If it is set, the "uid" should not matter.
> 
> If an attacker's process first calls PR_SET_PREDUMP_SIG, then forks
> off a child, then calls execve() on a setuid binary, the setuid binary
> calls setuid(0), and the attacker-controlled child then crashes, the
> privileged process will receive an unexpected signal that the attacker
> wouldn't have been allowed to send otherwise. For similar reasons, the
> parent death signal is reset when a setuid binary is executed:
> 
> void setup_new_exec(struct linux_binprm * bprm)
> {
>         /*
>          * Once here, prepare_binrpm() will not be called any more, so
>          * the final state of setuid/setgid/fscaps can be merged into the
>          * secureexec flag.
>          */
>         bprm->secureexec |= bprm->cap_elevated;
> 
>         if (bprm->secureexec) {
>                 /* Make sure parent cannot signal privileged process. */
>                 current->pdeath_signal = 0;
> [...]
>         }
> [...]
> }
> 
> int commit_creds(struct cred *new)
> {
> [...]
>         /* dumpability changes */
>         if (!uid_eq(old->euid, new->euid) ||
>             !gid_eq(old->egid, new->egid) ||
>             !uid_eq(old->fsuid, new->fsuid) ||
>             !gid_eq(old->fsgid, new->fsgid) ||
>             !cred_cap_issubset(old, new)) {
>                 if (task->mm)
>                         set_dumpable(task->mm, suid_dumpable);
>                 task->pdeath_signal = 0;
>                 smp_wmb();
>         }
> [...]
> }
> 
> AppArmor and SELinux also do related changes:
> 
> static void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
> {
> [...]
>         /* bail out if unconfined or not changing profile */
>         if ((new_label->proxy == label->proxy) ||
>             (unconfined(new_label)))
>                 return;
> 
>         aa_inherit_files(bprm->cred, current->files);
> 
>         current->pdeath_signal = 0;
> [...]
> }
> 
> static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
> {
> [...]
>         new_tsec = bprm->cred->security;
>         if (new_tsec->sid == new_tsec->osid)
>                 return;
> 
>         /* Close files for which the new task SID is not authorized. */
>         flush_unauthorized_files(bprm->cred, current->files);
> 
>         /* Always clear parent death signal on SID transitions. */
>         current->pdeath_signal = 0;
> [...]
> }
> 
> You should probably reset the coredump signal in the same places - or
> even better, add a new helper for resetting the parent death signal,
> and then add code for resetting the coredump signal in there.
> 
