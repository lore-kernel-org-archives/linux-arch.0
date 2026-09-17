Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEA64BD0FD;
	Thu, 17 Sep 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789642273; cv=none; b=Uu4Z/eum4cGcUBp8odg6i0dOwhvIWnvSmMq0fBpzAYMftaY3E3qO7IkDDDDAgbsSaYVWv78dw64oKUwmSrlKNWNf7qTHk2Gm7qDMRtbduMYEjgmtJ2LWYRDxyxzRVTkLgBTbgz+Ky8pgtubk0sclklPUtKSCRCzSF5JnLpeYzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789642273; c=relaxed/simple;
	bh=XihqMbgiW7kyP3lfZhBkDWHC5GYJp5plq+bKZoZZO64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WM/TIbBt//p/lZ6Z2zx9PIMx1zNIczarLqmyd8LHHRAaWfvO5iWMOPglwxPFtcroxmtb7+fQRxGt0kTTdDngx24N7+kPgSsqi2ZFV4A6peiE9/16yJfrsBJnOgyEyDgV4WQkXBEHSabLdbaWeCgZbvqL3kObqQiPgZFrWX8RD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RtNfF25a; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RtNfF25a"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97B191476;
	Thu, 17 Sep 2026 03:50:59 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D533F882;
	Thu, 17 Sep 2026 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789642263; bh=XihqMbgiW7kyP3lfZhBkDWHC5GYJp5plq+bKZoZZO64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtNfF25amyqFFOwy8f7Iwf2XNcgtv+nIar7eBklFC+H7xAzdIEqMy9x0nlPGgqPRB
	 cJk9SAnVOKw5yit88ub9YsR0jRng8wnZMYVoikwQM+HrvrznRNZAqoMaF/uTPYGa02
	 tQe/QcLuEmF28RDLit3va2X5NLtfgxw0mBTlrlP8=
Date: Thu, 17 Sep 2026 11:50:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v8 4/4] arm64: vdso32: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <aqvGEiZEtZFEWvjL@J2N7QTR9R3>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-4-077707b6f1c7@igalia.com>
 <aqqngEKC_CsrS62n@J2N7QTR9R3>
 <d0c5ada8-929f-4d39-9f8e-32860fa5b853@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0c5ada8-929f-4d39-9f8e-32860fa5b853@igalia.com>

On Wed, Sep 16, 2026 at 10:11:01PM -0300, André Almeida wrote:
> Em 16/09/2026 11:28, Mark Rutland escreveu:
> > On Fri, Aug 21, 2026 at 06:50:45PM -0300, André Almeida wrote:
> > > Based on aarch64 implementation, provide a 32 bit entry point for
> > > this vDSO.
> > > 
> > > In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
> > > make sure to store the pop address at r2 and the compare result value
> > > at r3.
> > 
> > Before we add this to the compat vdso, we'll need to implement this on
> > arch/arm/.
> > 
> > Otherwise, my comments on the patch for the native vdso functions apply
> > here too.
> 
> Right, and the compat entry point at arch/arm64/ would point to the
> __vdso_futex_robust_list32_try_unlock implementation at arch/arm/?

So far we've had arm64 provide its own copy (which e.g. might use
sequences relying on ARMv8+ instructions), so I think we'd do the same
here.

The key thing is that 32-bit tasks on arm64 should see the same ABI as
native tasks on 32-bit arm. As there's a risk that 32-bit arm might have
some ABI quirks (e.g. due to older processors), we don't want to enable
features for compat tasks on arm64 before that's been implemented on
32-bit arm.

Mark.
