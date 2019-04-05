From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from
 syscall_get_arguments()
Date: Fri, 5 Apr 2019 09:58:28 +0100
Message-ID: <20190405085828.GA1576@fuggles.cambridge.arm.com>
References: <20190401134104.676620247@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401134104.676620247@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifiv>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 01, 2019 at 09:41:04AM -0400, Steven Rostedt wrote:
> [ Looking for acks ]

For the arm64 bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
