Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1213B5B3;
	Mon, 13 Jul 2026 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783904449; cv=none; b=mnjEjLYbzSTnRTeJ6kY15sjFuSANHguDZPKF0CTtbEvKlbzl7WPuP2cOjzuysHkOWCTZR9qId9LL9rePGKzlk2uuVlW2Jwha4uimGhLoxmXH2+IMLVEPMmYLw5oQwZsZ0r8bcHbXGMt93X5zrYD7lZ+0rcR4QXZkY78Wy5IBZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783904449; c=relaxed/simple;
	bh=QcQpCXVi2gWcc3KQVDH0kR2pLPONZZ77/l0BUjZiSok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WYq3zwt+nudim8wlvnIfo+g9Bh5MO+FJ3Xyz3NpUAcMzXjLAHhXKZESfAqSz9E2lBhuTFn/+Awo3/EDe1NWeuUn0WG/WDhOd388wZMsyqgT3RDnperWirCc9dh6Wcqkw7hMw524NWALuy3cMLnihotCSEBlB3ycQLrBVquUwFEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=NB8BqEUY; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="NB8BqEUY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+sGQh80W3+ZgAsm43CIA2m36N9Ob/trARSx/YNc/zAc=;
	b=NB8BqEUYzC07Ifhb7O5Hok5m1cSgubXpRdum/5kjGffGcPiaYkROsZv94rtBuq
	8CzjMye7EY3DxMZYJ1LbFnwRjJLYuQmG1vG2XdsjWB0OTI8/1IroDNJPHhvf54bG
	rXzBfpZHcPJ0WsY75ISwehUibhE7VDpouNjOY1IMqR9rs=
Received: from [198.18.0.1] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDnh5uPOFRq2gq5DQ--.58796S2;
	Mon, 13 Jul 2026 09:00:00 +0800 (CST)
Message-ID: <98ed90ff-443d-455e-a991-95e2a8f8696d@126.com>
Date: Mon, 13 Jul 2026 09:00:00 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: add error injection support for checksum
 verification
To: arnd@arndb.de, kees@kernel.org, clm@fb.com, dsterba@suse.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260702023638.8165-1-chensong_2000@126.com>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <20260702023638.8165-1-chensong_2000@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnh5uPOFRq2gq5DQ--.58796S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr1ftrW5XF4rJF1xZF15XFb_yoWDKFb_uw
	4vqayfZw4UXF4xGF429rW7XrZ7K34Fg34vv348trs7ta4xZ39rAw4vqrZIvr1kG3y2qF1a
	vrn8Gw15try7ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0N4S5UUUUU==
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpRDhYWpUOJCWHQAA3o

Dear Maintainers and Reviewers,

This is friendly ping on this patchset.

The motive is rational and the implementation is simple and clear, 
what's more, no impact to any other function. I would appreciate it if 
you could have a look and leave comments.

Best regards,

Song

On 7/2/26 10:36, Song Chen wrote:
> This patchset adds fault injection support for btrfs_data_csum_ok,
> enabling controlled simulation of checksum mismatches to test btrfs
> silent data corruption detection and reporting paths.
> 
> The first patch extends the error injection framework with a new type,
> EI_ETYPE_FALSE, which allows bool-returning functions to be overridden
> with a false return value directly.
> 
> The second patch marks btrfs_data_csum_ok with ALLOW_ERROR_INJECTION
> using this new type.
> 
> Song Chen (2):
>    error-injection: Introduce EI_ETYPE_FALSE for fail_function
>    btrfs: Allow error injection on btrfs_data_csum_ok
> 
>   fs/btrfs/inode.c                      | 1 +
>   include/asm-generic/error-injection.h | 1 +
>   kernel/fail_function.c                | 2 ++
>   3 files changed, 4 insertions(+)
> 

