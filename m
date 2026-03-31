Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7123B6343;
	Tue, 31 Mar 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970557; cv=none; b=C4branK3CF0NFAdZ9o1MUgRDJYRy7hkG+pyVt0SQYecxOfm3v2mL1EcmmPClImFx7fdz4iA+cQvcnZhExacgTr9Ze0E07b4DgRoudGHxGNOJ8tomqWg430zUNitZl89zlixbR3l5n+jD1Ns94iC65/SlsdZzDyuQERKLcwzKqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970557; c=relaxed/simple;
	bh=IpNYmnq+KCC/eprohuYWOdwRfb7D8eal26lhDfTICdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E56l5U+SZpNCrA/KAY7hOf2SZj2T/H7p8UbcRj30jAJlWIAuc5Kuxz6esiKrERFZI2AX8seIkEUyDzYaNqO9IlvHl+DWRcj2D2GNLDYFJbQIfiOdV36A1cGz0gZyJoYh8gET8hNl8/qe5OXzPXycQTRzpbAlAm1F2Vxf0iW4sLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da1MLMGr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da1MLMGr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6716C19423;
	Tue, 31 Mar 2026 15:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774970556;
	bh=IpNYmnq+KCC/eprohuYWOdwRfb7D8eal26lhDfTICdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=da1MLMGrPDAl8TCvBdgq9gkJpOiAOut+lzpmhKNX9MT2dlEJpKvcbdISZeSzFRZup
	 r4R3kKIYWw5xbiuM+dXlIzVXBhf6EU5In8Hq/s95I8AQWPp6VFK6BQyW3VMImDE7gV
	 cEGqDRfYrkfXepigmSCnxWM9IpNptHl95XYUb5E2Z7cO9kPUDNbnbuLzi5Z3NgTLss
	 6KzMVEgLnbj8wY1qUepr1od9RBQcLA3Ah+gtfmgQZozBZkvjOp/BTCS3o+/Pdu02/E
	 2pju7vjERA6N49RcxZnjza50Wcjn0w0gb94yoLpvarci0v3KHpFYilQL5psq52ytza
	 Fi3HnLiih4CVw==
From: Thomas Gleixner <tglx@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, =?utf-8?Q?Andr=C3=A8?= Almeida
 <andrealmeid@igalia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Carlos O'Donell
 <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Florian Weimer
 <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, Torvald Riegel
 <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann
 <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Uros Bizjak
 <ubizjak@gmail.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, linux-arch@vger.kernel.org
Subject: Re: [patch V3 00/14] futex: Address the robust futex unlock race
 for real
In-Reply-To: <acp-l792SFNG9ROS@J2N7QTR9R3>
References: <20260330114212.927686587@kernel.org> <acp-l792SFNG9ROS@J2N7QTR9R3>
Date: Tue, 31 Mar 2026 17:22:32 +0200
Message-ID: <878qb89g7b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Resending with linux-arch in CC and a bit more context.

On Mon, Mar 30 2026 at 14:45, Mark Rutland wrote:
> On Mon, Mar 30, 2026 at 02:01:58PM +0200, Thomas Gleixner wrote:
>> User space can't solve this problem without help from the kernel. This
>> series provides the kernel side infrastructure to help it along:
[ 6 more citation lines. Click/Enter to show. ]
>> 
>>   1) Combined unlock, pointer clearing, wake-up for the contended case
>> 
>>   2) VDSO based unlock and pointer clearing helpers with a fix-up function
>>      in the kernel when user space was interrupted within the critical
>>      section.

There is an effort to solve the long standing issue of robust futexes
versus unlock and clearing the list op pointer not being atomic. See:

   https://lore.kernel.org/20260316162316.356674433@kernel.org

TLDR:

The robust futex unlock mechanism is racy in respect to the clearing of the
robust_list_head::list_op_pending pointer because unlock and clearing the
pointer are not atomic. The race window is between the unlock and clearing
the pending op pointer. If the task is forced to exit in this window, exit
will access a potentially invalid pending op pointer when cleaning up the
robust list. That happens if another task manages to unmap the object
containing the lock before the cleanup, which results in an UAF. In the
worst case this UAF can lead to memory corruption when unrelated content
has been mapped to the same address by the time the access happens.

The contended unlock case will be solved with an extension to the
futex() syscall so that the kernel handles the "atomicity".

The uncontended case where user space unlocks the futex needs VDSO
support, so that the kernel can clear the list op pending pointer when
user space gets interrupted between unlock and clearing. Below is how
this works on x86. The series in progress covers only x86, so this a
heads up for that's coming to architectures which support VDSO. If
anyone sees a problem with then, then please issue your concerns now.

> I see the vdso bits in this series are specific to x86. Do other
> architectures need something here?

Yes.

> I might be missing some context; I'm not sure whether that's not
> necessary or just not implemented by this series, and so I'm not sure
> whether arm64 folk and other need to go dig into this.

The VDSO functions __vdso_futex_robust_list64_try_unlock() and
__vdso_futex_robust_list32_try_unlock() are architecture specific.

The scheme in x86 ASM is:

	mov		%esi,%eax	// Load TID into EAX
	xor		%ecx,%ecx	// Set ECX to 0
	lock cmpxchg	%ecx,(%rdi)	// Try the TID -> 0 transition
  .Lstart:
	jnz    		.Lend
	movq		%rcx,(%rdx)	// Clear list_op_pending
  .Lend:
	ret

.Lstart is the start of the critical section, .Lend the end. These two
addresses need to be retrieved from the VDSO when the VDSO is mapped to
user space and stored in mm::futex:unlock::cs_ranges[]. See patch 11/14.

If the cmpxchg was successful, then the pending pointer has to be
cleared when user space was interrupted before reaching .Lend.

So .Lstart has to be immediately after the instruction which did the try
compare exchange and the architecture needs to have their ASM variant
and the helper function which tells the generic code whether the pointer
has to be cleared or not. On x86 that is:

	return regs->flags & X86_EFLAGS_ZF ? (void __user *)regs->dx : NULL;

as the result of CMPXCHG is in the Zero Flag and the pointer is in
[ER]DX. The former is defined by the ISA, the latter is enforced by the
ASM constraints and has to be kept in sync between the VDSO ASM and the
evaluation helper.

Thanks,

	tglx
