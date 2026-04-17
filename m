Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2FB3CAE95
	for <linux-arch@vger.kernel.org>; Fri, 17 Apr 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438535; cv=none; b=A/Br3ph9frqpUAJgrXiZm6SWJvMsT7WX30+6yMZTV/jtk5VtDzvkUbjHxfiegbCUw4/WIsPZuiL6zYpksEk2n2wjkA+yUab7eE8YWxo4tfq0RX5+jC5L925eQso+skzh9IhP0RITY9TJzLTItzIVDfbTqPzObNuD7rNI2c7SJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438535; c=relaxed/simple;
	bh=GtAv2oEhAaktPFPuGgQGoqYQIdrYrf9E9dAun+dV3fY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PqPiDP9LVnJ+mlEMMkoDJ8zV2M2fAujXe3eY9Rlax7x/ula7EhZWuQLW9vecYVJ+yAXarnZXY+axzhkZTQ5K6/wuo4J/l1vPiXIfcfF8tSzSvcMUgAp83BytRkY49YHi4z1pYqZ42ePdVhwYMzl4/afhG6NHIwquQoGMhOroQlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTf8No3S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTf8No3S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776438533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vh0xkpg69IEmDazmccaIDqQUqOG4jIiCy62gWyUHomw=;
	b=DTf8No3SGTUDLKVFPbm8imBNyHlAppsXkJXhrD1yBUDPWC0n5Wo6WNP7t1CvaiHnL77yMG
	AzwAe7SxBYTyw08I2E7MMG3Ba7OiA/OXnfez8NoHDkXGOEfh+nehj6cSUlV/Dfwe+UEE+s
	bsjwlavAj+IaRoBkrW76Vrvps6ah6Hc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-8Hf6sgXsNnycF4J_K7Zeyg-1; Fri,
 17 Apr 2026 11:08:47 -0400
X-MC-Unique: 8Hf6sgXsNnycF4J_K7Zeyg-1
X-Mimecast-MFC-AGG-ID: 8Hf6sgXsNnycF4J_K7Zeyg_1776438525
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9907D1956066;
	Fri, 17 Apr 2026 15:08:43 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92AE030001BE;
	Fri, 17 Apr 2026 15:08:35 +0000 (UTC)
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
In-Reply-To: <20260417-tonyk-robust_arm-v1-1-03aa64e2ff1a@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 17 Apr 2026 11:56:10 -0300")
References: <20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com>
	<20260417-tonyk-robust_arm-v1-1-03aa64e2ff1a@igalia.com>
Date: Fri, 17 Apr 2026 17:08:32 +0200
Message-ID: <lhu1pgd8w0f.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* Andr=C3=A9 Almeida:

> There will be a VDSO function to unlock non-contended robust futexes in
> user space. The unlock sequence is racy vs. clearing the list_pending_op
> pointer in the task's robust list head. To plug this race the kernel needs
> to know the critical section window so it can clear the pointer when the
> task is interrupted within that race window. The window is determined by
> labels in the inline assembly.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
> RFC: Those symbols can't be found by the linker after patch 2/2, it fails=
 with:
>
> ld: arch/arm64/kernel/vdso.o: in function `vdso_futex_robust_unlock_updat=
e_ips':
> arch/arm64/kernel/vdso.c:72:(.text+0x200): undefined reference to `__fute=
x_list64_try_unlock_cs_success'
> ld: arch/arm64/kernel/vdso.o: relocation R_AARCH64_ADR_PREL_PG_HI21 again=
st symbol `__futex_list64_try_unlock_cs_success' which may bind externally =
can not be used when making a shared object; recompile with -fPIC
> arch/arm64/kernel/vdso.c:72:(.text+0x200): dangerous relocation: unsuppor=
ted relocation

I think your GLOBLS definition adds a 64 suffix.  That shouldn't be
necessary on AArch64.  It's not reflected in the references, so you end
up with an undefined symbol error.

Thanks,
Florian

