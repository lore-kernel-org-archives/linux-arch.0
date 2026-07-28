Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3890E37E5E8;
	Tue, 28 Jul 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257330; cv=none; b=pph5wLB744YPFLywwUJVptlNj/QxOMxMb5OOh14n5vzs8M2TGHbphm7rbYlSTxdu3dxa7IT6XKVPXar41+Cnbz9yB600kO78oi+fhFxY59DGw3mMrdsHTpGfmpKty/Q+Z/w7x2d4chvasloVfw4uqFrE3lXHd4ewFQc78QOqUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257330; c=relaxed/simple;
	bh=47xlqcqs2MJWiyuu2bASLtb4amYESjB9bOCK37kVupU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZgRwLWYB9HB0H5XV+1ffJ8eKYTk3AxVwtLOTqhc3wTyKnaXEO9w2wJ1FTIyvWzCqdT6JXcXQHOcHr/noz0QEhOpLKEplP2X/QyHE07zq5MCTj07dYR/1luLrysakgwyF33cWkSD0IzujONL2m5vVsqyukd4QA4fjttS8AWSUKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU/w7xJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU/w7xJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC8B1F000E9;
	Tue, 28 Jul 2026 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257328;
	bh=pVL+sXQnyVqR4TfVrY7tpfQSsCbrXDrigHvOgIdAaTA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=OU/w7xJdlxyJSNUc0FqMdjjkG+oNvQi42NfaA5le51Kuoey4LT3p9PflQzQwrXptd
	 oSOlQp2nlkSn9EKnVYCPs5HkKIbKvwaLAfDQUYg2bvSlfAzJEce67gOXjLGKH3zaVj
	 K/V2br3ZtCRI/N5UE6xkd1b1T303H492jrOJ8CW0z8Vio4AVtqp5KXC88ezubfO1hF
	 jEkAFCI2Ni6F5Ju/UbFYJCYsmOQrhE+Xh9eulgd+SwB45UDhbiQTQInFeG+jlOx7zC
	 ag23g8quAGKt3xHRse50kt74RjzTceTkfgvxGKJbL7oKG4bN8p9Srs+wZnCUZ/OLij
	 ffunIVRFbZY9Q==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 0/9] mm: optimize zone-device memmap initialization
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de, 
 balbirs@nvidia.com, bp@alien8.de, dave.hansen@linux.intel.com, 
 david@kernel.org, kees@kernel.org, mingo@redhat.com, rppt@kernel.org, 
 tglx@kernel.org, muchun.song@linux.dev, linux-arch@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org
In-Reply-To: <20260720120259.1545-2-lizhe.67@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
 <20260720120259.1545-2-lizhe.67@bytedance.com>
Date: Tue, 28 Jul 2026 19:48:40 +0300
Message-Id: <178525732062.1556190.314794914123127147.b4-review@b4>
X-Mailer: b4 0.16-dev

> 
> The numbers below measure the time spent in memmap_init_zone_device()
> during driver bind/rebind. They are not measurements of the full
> nd_pmem or dax_pmem bind/rebind operation.
> 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> server.

Since the first pathes touch the generic part of the memory map
initialization, it would be nice to make sure they don't regress other
architectures.

-- 
Sincerely yours,
Mike.

