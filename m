From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 02/13] entry: Provide generic syscall exit function
Date: Thu, 16 Jul 2020 23:28:35 +0200
Message-ID: <87k0z3taik.fsf@nanos.tec.linutronix.de>
References: <20200716182208.180916541@linutronix.de> <20200716185424.116500611@linutronix.de> <202007161354.62030182F@keescook>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202007161354.62030182F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 08:22:10PM +0200, Thomas Gleixner wrote:
>
> This looks correct to me. Did you happen to run the seccomp selftests
> under this series?

Yes, I threw the relevant self tests on it.
