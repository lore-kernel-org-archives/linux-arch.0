Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6830B525
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323872; cv=none; b=UVbqdwrx0myQ3afsJ/EkNSXeLR64ru7k1pXIpIipIS9RlvHjycbMCA1npLqdlkxszyofIJ1z59JTU7i9QUocKoQECwymN2Hx6QBHVTerPQeU3uihnJvIs+XcC4Jj68r9cFSKJivFtJigcirRZVZxh9gH1e3tf2CYkVlb3m+zo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323872; c=relaxed/simple;
	bh=LcZ9wxLx+07e/rrFE1ojXbKD7zyLixDGTZisA7HBq1o=;
	h=Subject:Mime-Version:References:Content-Type:To:Cc:Message-Id:
	 In-Reply-To:From:Date; b=oR9Juj4ta4WuswXmq/rJVKVRq1uzdlts1IlEJpTyrZao0fXTEKdyGbggid75vv+8oxcxw3M29/c2ASpdoOl6Dwxwfflf86bM205U9vFM2dAiRF0VPJrtm4hVdzflLe1RUCLK7kPgJtZZbna+Pf7kcU+KR8a+zkzWy6nKpeJTaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hC0TCeZK; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hC0TCeZK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783323850; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DWB+NjMk1HZepzF30XQzFwBn/hDq5+vh5fwlGqKis+4=;
 b=hC0TCeZKMo+CD7ZABwhuUqjie2wrXJGayLjJvPFDdCCde5wEgJryYiimTdjKh4zFzpoq3w
 8GyQqiFxCYGUvez9FAzi4CBTknfmnbHs71Pn0Ze6V3PuuI1nfn1Lc25NmvF7sLCQ3YOGnT
 bf28URxLxQWmnjy1i8srnyNIesd+aRn7RvR7vUyhjXv0r+S9E5zgMBijT9RtGj2DMz23/p
 qO2EkACqzH5xTuLb3Lu2Nfb/gA9PyqzY2DBpJX4Fa/29RI5ei8JSvn7xXqlhzD/IoBTjI8
 BWlYUaWya2RMtYbkceIit4EIJ0Ku3fMwmnlCAOR1CY4DPL8mCNO9EvktD45z9w==
Subject: Re: [PATCH v5 7/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260703195619.GGakgT44P7lpcoMVlY@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
To: <bp@alien8.de>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Message-Id: <20260706074346.23928-1-lizhe.67@bytedance.com>
In-Reply-To: <20260703195619.GGakgT44P7lpcoMVlY@fat_crate.local>
X-Lms-Return-Path: <lba+26a4b5cc8+354306+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Mon,  6 Jul 2026 15:43:46 +0800
Content-Transfer-Encoding: 7bit

On Fri, 3 Jul 2026 12:56:19 -0700, bp@alien8.de wrote:

> On Thu, Jul 02, 2026 at 03:37:50PM +0800, Li Zhe wrote:
> > The relevant target sizes here are the x86_64 sizeof(struct page)
> > values which patch 8 can hit: 64, 80, and 96 bytes.
> >
> > On x86_64, CONFIG_HAVE_ALIGNED_STRUCT_PAGE keeps struct page 16-byte
> > aligned. That gives 64 bytes in the common case, 80 bytes when
> > WANT_PAGE_VIRTUAL or CONFIG_KMSAN adds extra fields, and 96 bytes when
> > both are present. I stopped there deliberately because this series does
> > not have a current caller which needs larger constant sizes.
> >
> > The 32-byte and 48-byte cases were added only as intermediate fixed-size
> > combinations used to build those larger struct page-sized copies while
> > keeping them on the inline movnti path.
> 
> This needs to be in a comment over that code so that it is clear why that
> distinction has been made.

Thanks. I will add a code comment for that in v6.

> > Yes. The separate helper is there exactly because the added
> > 32/48/64/80/96-byte cases carry an extra 8-byte destination-alignment
> > check, while I left the existing 4/8/16-byte inline cases unchanged.
> >
> > The intent was to keep the larger fixed-size cases on the inline
> > movnti path only when they already match the alignment assumptions
> > used by __memcpy_flushcache(); otherwise they fall back to that
> > out-of-line helper, which already handles the misaligned head/tail
> > fragments before entering its movnti loops.
> 
> Why can't the larger MOVNTI sizes deal with misaligned cases too and thus make
> the code even simpler and more straight-forward this way?

The extra IS_ALIGNED() check is meant as a conservative performance
choice, not because MOVNTI itself would be invalid on a misaligned
destination.

As the Intel optimization reference manual notes, higher-throughput
data movement usually comes with alignment considerations, and can
be more efficient when the destination is naturally aligned.

So for these larger fixed-size cases, I kept the inline path limited
to the aligned case. For misaligned destinations, falling back to
__memcpy_flushcache() is expected to be the better choice, since it
already handles the unaligned head first and only then enters its
MOVNTI loops.

I will make that rationale explicit in the code comment and commit
message in v6.

Thanks,
Zhe
