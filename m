Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA9B3EDAA8;
	Thu, 17 Sep 2026 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639289; cv=none; b=KEPyWGQ+NGtYuZQL8fJPhlzaXk3wfgz3BRCeOl66WejgUGCUoTgO+p9sfx6CyOm/JD3nDcNfFM3bZLXFho9Vc9NcJKq6lvL0UeV4SwBed5Sayjfs2/u9ISBn5PisTorPMQxfCr/RqKw7sUrQWsaZhA0UUR3Ay9VpOdLmSDkP2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639289; c=relaxed/simple;
	bh=7f+DyO0aVahV3yaG3OLFFC7DhrsBd/PbfzSn6AGTRdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVxSDZG3osmO7LYI7rMo9FwrwTKN5dx0aB7yhzH9N8aQVx9yEeCk7ccnk8XZdlFahypFoCtOZU2aJGBW+vgLr4mjKHJhWUV204AY/ZyaAgM1fWgg4lcTUOq7bMwH+L3CVzD09L3wF7MteVOCVqupFb6mrHKYWPaTp3PpEkk9f1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SxuwVEPb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SxuwVEPb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E27B01476;
	Thu, 17 Sep 2026 03:01:13 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE3AE3F7B4;
	Thu, 17 Sep 2026 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789639277; bh=7f+DyO0aVahV3yaG3OLFFC7DhrsBd/PbfzSn6AGTRdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxuwVEPbRV5U3eLO+R05qilnaeyPOUDhkohdjK8kwFZQ1ZIjBxktQXqSgkqeSE5bi
	 3TdfbpaF58mTm/Xn8gtbzBpUQpQ7VXFT0ZRhad6GgRHd1cni/47NHIP0g0L8MCniPj
	 AWiENNa0WnZzGglRA/JUz39uETLtCRrpUy8NWJqc=
Date: Thu, 17 Sep 2026 11:01:11 +0100
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
Subject: Re: [PATCH v8 1/4] arm64: vdso: Prepare for robust futex unlock
 support
Message-ID: <aqu6ZzMpunlKDIwm@J2N7QTR9R3>
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-1-077707b6f1c7@igalia.com>
 <aqqmmNTDnzT5d-ZT@J2N7QTR9R3>
 <4cc1a199-8917-4a93-91f8-138ca1511cff@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cc1a199-8917-4a93-91f8-138ca1511cff@igalia.com>

On Wed, Sep 16, 2026 at 10:05:38PM -0300, André Almeida wrote:
> Em 16/09/2026 11:24, Mark Rutland escreveu:
> > I reckon this might also be clearer as:
> > 
> > | 	if (regs->regs[3])
> > | 		return NULL;
> > | 	
> > | 	return (void __user *)regs->regs[2];
> > 
> > Do we need a __force cast here, or is sparse happy without that?
> 
> I've just re-compiled those patches with C=1, and didn't find any warning
> for this.

Perfect, thanks for confirming!

[...]

> > > +	futex_set_vdso_cs_range(fd, is_32bit ? 1 : 0, start, end, is_32bit);
> > 
> > On arm64 (and every architecture other than x86, AFAICT), the
> > native/compat VDSOs are mutually exclusive, and a single mm can only
> > have one of them.
> > 
> > Given that, I think we can make this:
> > 
> > 	futex_set_vdso_cs_range(fd, 0, start, end, is_32bit);
> > 
> > That way we'll avoid confusing/bikesheeding over 'is_32bit ? 1 : 0',
> > without having to add mnemnonics for the native/compat CS indices.
> 
> Perfect, I will simplify that then.
> 
> > That said, what's the plan for 32-bit robust lists on a 64-bit host?
> > IIUC you wanted that for emulation, and AFAICT you have no way to call
> > __vdso_futex_robust_list32_try_unlock() from a native task.
> 
> Yes, the plan is to be able to use the 32-bit robust lists on a 64-bit
> hosts, with a new interface (set/get_robust_list2[1]). That means that a
> 64-bit kernel will be able to process an user robust list made of 32-bit
> pointers. So the emulator will call set_robust_list2() one time for it's own
> list, and another time for the emulated app list.
> 
> However, what we have agreed for the moment is that, while there's no
> support for that, we will not expose the 32-bit functions yet [2]:

Ah, thanks for the pointer! I had mistakenly assumed that some of
that had already happened.

I guess the common logic for futex_set_vdso_cs_range() will need to
change at that point I guess if/when that happens, you'd expect to add
__vdso_futex_robust_list32_try_unlock() into the 64-bit VDSO, regardless
of compat?

Mark.

> "...that requires also the ability to register a 32-bit robust list for a
> 64-bit process, which is not supported right now. So no, we are not exposing
> something half functional..."
> 
> So yes, in the near future I will need to expose
> __vdso_futex_robust_list32_try_unlock() to 64-bit apps as well, to be able
> to do this handling with 32-bit pointers, but we are not doing it right now.
> 
> [1] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com/
> 
> [2] https://lore.kernel.org/lkml/878q9vwote.ffs@tglx/
> 
