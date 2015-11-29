From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH 0/2] introduce post-init read-only memory
Date: Sun, 29 Nov 2015 19:05:52 +0100
Message-ID: <CA+rthh_vXtYqvgcLJm=Xq8BniKMbffQrJJ8Gt_BWoAKbow8_Ow@mail.gmail.com>
References: <1448401114-24650-1-git-send-email-keescook@chromium.org>
	<565876F3.21515.18F8DF8F@pageexec.freemail.hu>
	<20151129080853.GB23721@gmail.com>
	<565ADE35.20892.225C67C2@pageexec.freemail.hu>
	<20151129153918.GA12215@gmail.com>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-2013-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20151129153918.GA12215@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: PaX Team <pageexec@freemail.hu>, Linus Torvalds <torvalds@linux-foundation.org>, kernel-hardening@lists.openwall.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, Emese Revfy <re.emese@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 29 November 2015 at 16:39, Ingo Molnar <mingo@kernel.org> wrote:
>
> * PaX Team <pageexec@freemail.hu> wrote:
>
>> On 29 Nov 2015 at 9:08, Ingo Molnar wrote:
>>
>> >
>> > * PaX Team <pageexec@freemail.hu> wrote:
>> >
>> > > i don't see the compile time vs. runtime detection as 'competing' approaches,
>> > > both have their own role. [...]
>> >
>> > That's true - but only as long as 'this can be solved in tooling!' is not used as
>> > an excuse to oppose the runtime solution and we end up doing neither.
>>
>> actually, i already voiced my opinion elsewhere in the constify thread on the
>> kernel hardening list that adding/using __read_only is somewhat premature
>> without also adding the compile time verification part (as part of the constify
>> plugin for example). right now its use on the embedded vdso image is simple and
>> easy to verify but once people begin to add it to variables that the compiler
>> knows and cares about (say, the ops structures) then things can become fragile
>> without compile checking. so yes, i'd also advise to get such tooling in
>> *before* more __read_only usage is added.
>
> I think you are mistaken there: if we add the page fault fixup to make sure we
> don't crash if a read-only variable is accessed, then we'll have most of the
> benefits of read-only mappings and no fragility - without having to wait for
> tooling.

I guess the point PaX Team (and me earlier in this thread) wanted to
make is that having misuse detection *only* at run-time will make
those kind of bugs visible too late -- as late as on the wrong write
attempt actually happening. It would be much better to have the
compiler complain about invalid write statements already during
compilation, much like it does when one wants to assign some value to
a const object.

Having the page fault handler being able to recover from
__ro_after_init faults is a nice feature to support users, actually
being able to report bugs. But it shouldn't be the only way to detect
those kinds of bugs. In fact, we've tools in our toolchain that try to
detect and flag wrong usage of __init / __exit, so why not cover
__ro_after_init as well? Admitted, that won't be possible with modpost
in its current state, but would require a compiler extension instead.
Its current non-existence shouldn't be a show-stopper for
__ro_after_init but the very next step to take care of before
extending the usage of that annotation.

Just my 2ct,
Mathias
