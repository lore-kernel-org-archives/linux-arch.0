Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A723B19DE;
	Fri, 15 May 2026 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856016; cv=none; b=kOfm7yBs0CDxi76z/AlR7C2Se6rXEIfsHxc/gBdGWVKkxsLj24jfXcXfFamoVXSojn9QF2NavyKHlaxgb5+DIuu0ePZANIv33DS7mLifNg+74LWN4tRb8ZqvDak6gUxswCEDHAfLmocuann7PebEL/QB64uZ0Iz5CeI04jPTRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856016; c=relaxed/simple;
	bh=oVTQLdQPgm78z3vvyrR2it6wa49pRkZSjf6vJ0zKe60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN1gLO9YX6zXdYFjtW72ReSakDc8ZqK2WpGs6hWvgBEqeNWSbK+4fDzh/9r2kle3o45ljbvKu/4D3rIEnZTk6G2WPX965+Kr3F6nCZTWl4NGx9j8v8vlel2dzE7z9n0owwZCAWZEzcBp+rwQc5A2SjJrA02dgsSpR+mfIsdlf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=RRKzNl+V; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="RRKzNl+V"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id A6BBDD05D9;
	Fri, 15 May 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1778856006;
	bh=LjG5aYhzzCdGlhgt68FcixNTeEbd8ZYVpF7B/Blnyp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RRKzNl+VV4JDQiTUTKJ02htUMGGPz54aJtGB88rZY2lugizfNL4xXA0Miw5TsKpcf
	 D4TSVDE/+biY08/6wdh797My6cEELDA9ZfGm2JSTat+ZT93VbFxGJpNSW1q6kQ8PKV
	 QKxA7ZfwkUZg+o+FdxV6aIyGaEILsAXINCAZcSpI=
Date: Fri, 15 May 2026 14:40:04 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 5/7] locking: Add contended_release tracepoint to
 qspinlock
Message-ID: <agcwRNNgoYVSpDKq@shell.ilvokhin.com>
References: <cover.1777999826.git.d@ilvokhin.com>
 <5d7ea75ffe74a785e6b234ada9f23c6373d4b4c1.1777999826.git.d@ilvokhin.com>
 <20260513114102.50f4ca68@gandalf.local.home>
 <agXYjw3GM15WtC-H@shell.ilvokhin.com>
 <20260514120348.7a64facc@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514120348.7a64facc@gandalf.local.home>

On Thu, May 14, 2026 at 12:03:48PM -0400, Steven Rostedt wrote:
> On Thu, 14 May 2026 14:13:35 +0000
> Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > > > +void __lockfunc queued_spin_release_traced(struct qspinlock *lock)
> > > > +{
> > > > +	if (queued_spin_is_contended(lock))
> > > > +		trace_call__contended_release(lock);
> > > > +	queued_spin_release(lock);  
> > > 
> > > And then remove the duplicate call of "queued_spin_release()" here.  
> > 
> > This is the scenario the comment above the static branch describes.
> > Here's what it looks like in practice on x86_64 (defconfig, compiled
> > with GCC 11).
> > 
> > Current design (trace + unlock combined, with return):
> >   
> >     endbr64
> >     xchg %ax,%ax                     ; NOP (static branch)
> >     movb $0x0,(%rdi)                 ; unlock
> >     decl %gs:__preempt_count
> >     je   preempt
> >     jmp  __x86_return_thunk
> >     call queued_spin_release_traced  ; cold
> >     jmp  preempt_handling            ; cold
> >     call __SCT__preempt_schedule
> >     jmp  __x86_return_thunk
> > 
> > With the trace-only function (no return, unlock after the call):
> >   
> >     endbr64
> >     push %rbx                        ; saves callee-saved rbx (!)
> >     mov  %rdi,%rbx                   ; preserve lock across call (!)
> >     xchg %ax,%ax                     ; NOP (static branch)
> >     movb $0x0,(%rbx)                 ; unlock
> >     decl %gs:__preempt_count
> >     je   preempt
> >     pop  %rbx                        ; callee-saved restore (!)
> >     jmp  __x86_return_thunk
> >     call queued_spin_release_traced  ; cold
> >     jmp  unlock                      ; cold
> >     call __SCT__preempt_schedule
> >     pop  %rbx
> >     jmp  __x86_return_thunk
> > 
> > Three extra instructions marked by "!" on the hot path (push, mov, pop),
> > all wasted when the tracepoint is off. That's the main reason for
> > combining trace and unlock in the same out-of-line function.
> 
> Ah, because the return makes it into two tail calls.
> 
> I still don't like the duplication, perhaps add some more comments about
> needing to update the other location if anything changes here? And perhaps
> comment that this duplicate code helps the assembly.

My idea was that queued_spin_release() serves the same role that the old
queued_spin_unlock() had: a pure lock-release primitive without tracing.
That was the primary motivation for extracting queued_spin_release() in
the first place (it is just one line of code), so the common release
logic between the traced and non-traced paths is shared explicitly
rather than duplicated semantically.

I agree that this could be explained better. I'll add more comments
there to clarify the rationale. Thanks for the suggestion, Steve.

> 
> -- Steve
> 
