From: Yao Qi <qiyaoltc@gmail.com>
Subject: Re: [RFC PATCH 06/10] arm64/sve: Disallow VL setting for individual
 threads by default
Date: Mon, 16 Jan 2017 11:34:39 +0000
Message-ID: <20170116113439.GF28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <libc-alpha-return-76803-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org
List-Id: linux-arch.vger.kernel.org

On 17-01-12 11:26:05, Dave Martin wrote:
> General-purpose code in userspace is not expected to work correctly
> if multiple threads are allowed to run concurrently with different
> vector lengths in a single process.
> 
> This patch adds an explicit flag PR_SVE_SET_VL_THREAD to request
> this behaviour.  Without the flag, vector length setting is
> permitted only for a single-threaded process (which matches the
> expected usage model of setting the vector length at process
> startup).

Hi Dave,
PR_SVE_SET_VL_THREAD can be arch-independent, IMO, because prctl
needs a scope.  Looks some of them are system-wide, some of them are
about threads within the same process (like, PR_MPX_ENABLE_MANAGEMENT).
IOW, PR_SVE_SET_VL_THREAD can be general flag, to indicate the scope
of each new ptrcl command is per-thread.

I happen to see PR_SET_FP_MODE in man pages, which is about setting
FP register modes in runtime.  It is a little similar to setting VL in
this patch.  However the doc doesn't mention the effect or the scope
of this command.

-- 
Yao (齐尧)
