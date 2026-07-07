Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231363A8724
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406220; cv=none; b=aO2GHkDQU/V17IUQL6mxxrAKsJafvFnebs9G+T0voC7xP7nMKz7EstKeHg8So+u8m1Jr1VB33oW0RPYPrcfI/KfYtPOMa44YX2UCjnK5QJj6SCJgFsG0exrKytkEK/xo5VGlrCefnjAbAgfixzEdfVcBna88nkttlI3H15e1XNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406220; c=relaxed/simple;
	bh=3aFIvAza8W+arobFzZZWVySIDw7+9hWqxs4mpdMswQU=;
	h=Content-Type:Message-Id:Cc:From:Subject:Date:To:References:
	 In-Reply-To:Mime-Version; b=PmxL3D+mIb1T3dy8djAsKNW6LiNVFBdVwjTlhO4y+CqBHAMoof+3Pj6OwJ4LVjm8/mJ1uB2bLFKoGxyNljWDMjOAyYW7s5A5KdEke4SFid4EvS1M9XNiF8vjYyiSPAuXUq4mCe3BSYm6OAmDAssbZ51O+lCm4mpTdExa8QFDMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iohuuVwQ; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iohuuVwQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783406213; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=dHcaoSCQABHmb9XmVmdOyeX7FURk+lYNsEghSRHaptg=;
 b=iohuuVwQSHr+gsyRALlPF+TYWR/1nmL/0wCxIrh45fDA8lW4/m4efxCCYcBsW6Wvfx/nwN
 PiA6WYdNuGz9lAxpixpCAAixFK0BWaCTSGdZneEMHUoGfsOo6Xl3P8Ak61cVFE+m3QQENV
 jXeHSeRNF++ROVIa3vRH8DWTsaWrQB/l81K1ot2C7/O+TcFfdaPFIC04IVoezyVHxkqCPU
 AE1ebpst9yQtdR5bKS8AbzWFO1hSjIwPlIKWUvxigGBkSQPT8ibTvSxYfoQhrJSSPJKneq
 KllyS4rjfZOv+vFndF6p7zS3rjhs0seyi2xFWpWC5tx0YhiLwhTvbn1pWbxuMg==
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260707063629.40360-1-lizhe.67@bytedance.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v5 4/8] mm: add a template-based fast path for zone-device page init
Date: Tue,  7 Jul 2026 14:36:29 +0800
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <apopple@nvidia.com>
References: <akxsbwyfYH1LCyGm@nvdebian.thelocal>
Content-Transfer-Encoding: 7bit
In-Reply-To: <akxsbwyfYH1LCyGm@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a4c9e83+aae1a5+vger.kernel.org+lizhe.67@bytedance.com>

On Tue, 7 Jul 2026 13:06:02 +1000, apopple@nvidia.com wrote:

> > > The whole bunch of template functions look like it could be useful for
> > > initialization of the non-zone-device struct pages as well.
> > >
> > > As I mentioned previously, it's interesting to see if this approach speeds
> > > up normal memory map initialization as well. If if does could have a single
> > > set of the template functions.
> >
> > Thanks for the suggestion. I agree this is worth exploring.
> >
> > For this series, I would prefer to keep the scope limited to the
> > ZONE_DEVICE initialization path and get that part settled first.
> 
> I think that makes sense, especially as my initial perf testing with other types
> of ZONE_DEVICE pages without altmap didn't show much of a perf impact. Meaning
> it might not be so useful for normal page init.
> 
> > After this series is settled, I plan to look into whether a similar
> > template-based approach can also help normal page initialization. If it
> > shows a real benefit there as well, I can follow up with a separate
> > series.
> 
> I agree it would be interesting though, please let us know what you find one way
> or the other.

Thanks. I will keep this series focused on the pmem-oriented
ZONE_DEVICE path for now, and I will report back separately if the
follow-up work on normal page initialization turns up anything useful,
positive or negative.

Thanks,
Zhe
