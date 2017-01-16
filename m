From: Yao Qi <qiyaoltc@gmail.com>
Subject: Re: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
Date: Mon, 16 Jan 2017 12:20:38 +0000
Message-ID: <20170116122038.GG28060@E107787-LIN>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <libc-alpha-return-76804-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org
List-Id: linux-arch.vger.kernel.org

On 17-01-12 11:26:07, Dave Martin wrote:
> This patch adds support for manipulating a task's vector length at
> runtime via ptrace.
> 

I hope kernel doesn't provide such interface to ptracer to change vector
length.  The vector length is sort of a read-only property of thread/process/
program to debugger, unless we really have a clear requirement to modify
vector length in debugging.  I may miss something because I haven't debug
SVE code yet.

> As a simplification, we turn the task back into an FPSIMD-only task
> when changing the vector length.  If the register data is written
> too, we then turn the task back into an SVE task, with changed
> task_struct layout for the SVE data, before the actual data writing
> is done.
> 
> Because the vector length is now variable, sve_get() now needs to
> return the real maximum for user_sve_header.max_vl, since .vl may
> be less than this (that's the whole point).
> 

-- 
Yao (齐尧)
