Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2533CE4BB
	for <linux-arch@vger.kernel.org>; Wed, 22 Apr 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862593; cv=none; b=tBGmUi0wVjl7ep3IrjKzD8uOPjH5v6IH5Pa2BC05xoKKyrkNhc6sXWc3vzDSNe0HoloMLfp7QXhr2bv5USBEvQSt74Fmc150Ukn4qUhR4XIRgO3NMyCQe7PmVs5gAdFXDWjquVqBFeEJzdDfEaR5zP1TadgJakXGxht+EXnjQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862593; c=relaxed/simple;
	bh=Am0j23VluZ7/eFy7vcUCEEwytqekVYfDvJyEuTjogTo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6lP9/1o6wNxaQ8WIDxNRYUS9NHFYgjcUjuF9Npdf7Apy8PXajVzBnTL+sr6hXPRT1o5cJWGrEDv+152v0YdDjoEN6HX8sgHdu3j8MHKVLS/s7ja9V8gmB0r4IIHW/6Dvbe7MJOPBVxjNTHUk5+UeGttlYCqk5RVOkCKgBS3NXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crt3wMwv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Crt3wMwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776862591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hNFhUEFjcegFazcO19qyJn0DssXxDQXRu1KhsMPo2L8=;
	b=Crt3wMwv+Lx9HOL5YyO4ItnhN9kITXvm2RxNUsDevbperrfqGzhYTlrlkL9GCI5RfUgnAF
	0CsISvLoYJrpda6SvPKARY0E0GyjJFGsfcEC21HlIz9tdD4zglhaGK4qT6bpD2yP2+V3tf
	Y1gFvPvg+Ny6EFZ44FIBMXxVjGUiS6E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-LID39KPIOuWodVAVWaZhTw-1; Wed,
 22 Apr 2026 08:56:24 -0400
X-MC-Unique: LID39KPIOuWodVAVWaZhTw-1
X-Mimecast-MFC-AGG-ID: LID39KPIOuWodVAVWaZhTw_1776862582
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A38B319560AF;
	Wed, 22 Apr 2026 12:56:20 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.49.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B15961956095;
	Wed, 22 Apr 2026 12:56:12 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Thomas Gleixner <tglx@kernel.org>,  Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,  Carlos O'Donell <carlos@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Rich Felker <dalias@aerifal.cx>,
  Torvald Riegel <triegel@redhat.com>,  Darren Hart <dvhart@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Davidlohr Bueso <dave@stgolabs.net>,
  Arnd Bergmann <arnd@arndb.de>,  "Liam R . Howlett"
 <Liam.Howlett@oracle.com>,  Uros Bizjak <ubizjak@gmail.com>,  Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
  kernel-dev@igalia.com
Subject: Re: [PATCH RFC 1/2] arm64: vdso: Prepare for robust futex unlock
 support
In-Reply-To: <32642d18-8c83-47ad-8456-1813084c4622@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Wed, 22 Apr 2026 09:46:53 -0300")
References: <20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com>
	<20260417-tonyk-robust_arm-v1-1-03aa64e2ff1a@igalia.com>
	<lhu1pgd8w0f.fsf@oldenburg.str.redhat.com>
	<32642d18-8c83-47ad-8456-1813084c4622@igalia.com>
Date: Wed, 22 Apr 2026 14:56:09 +0200
Message-ID: <lhuv7djb1cm.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Andr=C3=A9 Almeida:

> Hi Florian,
>
> Em 17/04/2026 12:08, Florian Weimer escreveu:
>> * Andr=C3=A9 Almeida:
>>=20
>>> There will be a VDSO function to unlock non-contended robust futexes in
>>> user space. The unlock sequence is racy vs. clearing the list_pending_op
>>> pointer in the task's robust list head. To plug this race the kernel ne=
eds
>>> to know the critical section window so it can clear the pointer when the
>>> task is interrupted within that race window. The window is determined by
>>> labels in the inline assembly.
>>>
>>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>>> ---
>>> RFC: Those symbols can't be found by the linker after patch 2/2, it fai=
ls with:
>>>
>>> ld: arch/arm64/kernel/vdso.o: in function `vdso_futex_robust_unlock_upd=
ate_ips':
>>> arch/arm64/kernel/vdso.c:72:(.text+0x200): undefined reference to `__fu=
tex_list64_try_unlock_cs_success'
>>> ld: arch/arm64/kernel/vdso.o: relocation R_AARCH64_ADR_PREL_PG_HI21 aga=
inst symbol `__futex_list64_try_unlock_cs_success' which may bind externall=
y can not be used when making a shared object; recompile with -fPIC
>>> arch/arm64/kernel/vdso.c:72:(.text+0x200): dangerous relocation: unsupp=
orted relocation
>> I think your GLOBLS definition adds a 64 suffix.  That shouldn't be
>> necessary on AArch64.  It's not reflected in the references, so you end
>> up with an undefined symbol error.
>>=20
>
> Why aarch64 doesn't need the 64 suffix? objdump shows that the final
> label name is __futex_list64_try_unlock_cs_success, which should match
> what the linker is trying to find, AFAIC.

Sorry, I was confused about how this is expected to work.

Florian

