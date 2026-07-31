Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A3133D6F0;
	Fri, 31 Jul 2026 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506040; cv=none; b=czR+rRQozgrET5hK99ld3vRHNJS/Gn2SOjyBt1tmBNzFDl7SMb1nwNV6zPIKw2pHJ4WOm4t3VVWNoSuYf7Fxy6moMV0ahhSuxbKB9yzpnm7ojXPeAdq9ws76EO2Amb+j4wNabO2z4u8LWox/DtWN++Z8B82rmoG96UE5rWfyYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506040; c=relaxed/simple;
	bh=FG8N11C0+jiKLPwJpHy1flun8dJKOaGO2lJvQ4F/oEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVW1McpPzxX9lIWH0cUY9aD7DVHodrISdDdF4HFPx0wcVEEIQhPwt4T6ysm+2IKnZI/3EwbhJvhf2WO+x8e/7LPXIdXxSys3H3Ddwoc82IIMVXjRX2PVpUPHCfHpZKWFo7p5aSQroqyXZaIR8VtfwAxAiHinCmishohWti/9y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVRoncqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVRoncqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A11F000E9;
	Fri, 31 Jul 2026 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506039;
	bh=mKinHt4CQYseBYj97VnG+dAXqNLVV4EtTuhQU6aTeew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVRoncqqLTEJ0UcuIUr8PUuADpda4kiZXR8albN5QKsLyDiutKwdu2SP81fviE9bP
	 uvsL096r7EepMQNo3YdK9KRBkvh8pMamMTJNl/5GEl0DqSWrS83u+QNapExoJlNgaP
	 +lLbDn7vb70p3kErg2cdSaQBu1kgO5Np1e5sfoTQ1dUaDGS9/QH7UAIw4oafahhpzb
	 z1aiZy46/3iYoShjA7K0cUHz2bLDK0mqFIdwkz4FmmVPnRg7UyK1OUFvvIHrZq1HCe
	 +HWKj4K8wsY9kE3f3KyE4U10+4obWHfS6sjN+zcdNk8zaHYJhBcZwbMv1Gynucw4tb
	 72KIZ5A6AuO9A==
Date: Fri, 31 Jul 2026 15:53:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
Message-ID: <20260731-erdball-fangruppen-pflicht-bc2db75ed1fb@brauner>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <20260702-forensik-unfertig-korpulent-56f199eb061a@brauner>
 <90228c39-04e7-41ef-ad91-84a8bb866650@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90228c39-04e7-41ef-ad91-84a8bb866650@sirena.org.uk>

On Tue, Jul 07, 2026 at 03:27:07PM +0100, Mark Brown wrote:
> On Thu, Jul 02, 2026 at 09:47:24AM +0200, Christian Brauner wrote:
> > On Sun, 31 May 2026 12:49:46 +0200, Jori Koolstra wrote:
> > > vfs: missing inode operation should return a consistent error code
> > 
> > I've stuffed this on a separate branch. Let's see whether we see any
> > fallout.
> 
> I'm seeing a failure in the chdir01 LTP test on arm64, everything seems
> to work fine apart from vfat:
> 
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> L5023tst_tmpdir.c:316: TINFO: Using /tmp/LTP_chdkVKCfH as tmpdir (tmpfs filesystem)
> L5024tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> L5025tst_test.c:2047: TINFO: LTP version: 20260130
> L5026tst_test.c:2050: TINFO: Tested kernel: 7.2.0-rc2-next-20260707 #1 SMP PREEMPT @1783429165 aarch64
> L5027tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> L5028tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 40s
> 
> ...
> 
> tst_test.c:1985: TINFO: === Testing on vfat ===
> L5158tst_test.c:1290: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> L5159tst_test.c:1302: TINFO: Mounting /dev/loop0 to /tmp/LTP_chdkVKCfH/mntpoint fstyp=vfat flags=0
> L5160chdir01.c:85: TBROK: Cannot create symlinks: EOPNOTSUPP (95)
> 
> Looks like a changed the error code here has confused the test's feature
> detection.  How many non-LTP applications have the same detection
> algorithm is a separate question.
> 
> A full log may be visible at:
> 
>   https://lava.sirena.org.uk/scheduler/job/2954697#L5157

Dropped.
