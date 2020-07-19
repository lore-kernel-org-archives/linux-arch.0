From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 01/13] entry: Provide generic syscall entry functionality
Date: Sun, 19 Jul 2020 12:17:07 +0200
Message-ID: <87v9ijollo.fsf@nanos.tec.linutronix.de>
References: <20200716182208.180916541@linutronix.de> <20200716185424.011950288@linutronix.de> <202007161336.B993ED938@keescook> <87d04vt98w.fsf@nanos.tec.linutronix.de> <202007171045.FB4A586F1D@keescook> <87mu3yq6sf.fsf@nanos.tec.linutronix.de> <CALCETrXz_vEySQJ=f3MTPG9XjZS7U0P-diJE9j_+0KRa_Kie=Q@mail.gmail.com> <875zakq56t.fsf@nanos.tec.linutronix.de> <CALCETrU-z_73BsKwNq0fTDEg7tVicd=jOEaq-6LnH24uNWShDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrU-z_73BsKwNq0fTDEg7tVicd=jOEaq-6LnH24uNWShDg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm list <kvm@vger.kernel.org>, Gabriel Krisman Bertazi <krisman@collabora.com>
List-Id: linux-arch.vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Sat, Jul 18, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Andy Lutomirski <luto@kernel.org> writes:
>> > FWIW, TIF_USER_RETURN_NOTIFY is a bit of an odd duck: it's an
>> > entry/exit word *and* a context switch word.  The latter is because
>> > it's logically a per-cpu flag, not a per-task flag, and the context
>> > switch code moves it around so it's always set on the running task.
>>
>> Gah, I missed the context switch thing of that. That stuff is hideous.
>
> It's also delightful because anything that screws up that dance (such
> as failure to do the exit-to-usermode path exactly right) likely
> results in an insta-root-hole.  If we fail to run user return
> notifiers, we can run user code with incorrect syscall MSRs, etc.

Looking at it deeper, having that thing in the loop is a pointless
exercise. This really wants to be done _after_ the loop.

Thanks,

        tglx
