Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B5CAD5A;
	Mon,  9 Feb 2026 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770613161; cv=none; b=kGVCtkj4htbMmYys941sRMYYb1EqTv7hjhgs7YEO3rM98Yhc7OLcCet7Cs4FQbsgUarZQ4Uchta4mc8pSVo9FSFv8Y65zlJg59HzAaufgoeYQ2kVvmnjeQO3SAVnV6S9FdDtStVNLnSThtY65WnuK4EEk0Oz47tCjYal6irRmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770613161; c=relaxed/simple;
	bh=dA/xh/uh59OoMgtB/1maNIcWqxGG2mCGbeEoL//zEv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ostN5KNoYdPhZ+Iu57kUhjlb3qBOnQUOKgaUXYBQ67rK63ooDhBJOwwbw7Y9HcWat3V9TwpQ/wAkihbbLPXY/4MEOtEGQGhG8tglc6XvHNOU/gP3P2wK8cZGdiyKETPHBWRJEmQtpby3AeAksIoC4iVXD0abNmXc7h20ciuXRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=311dOEH4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="311dOEH4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=IZn+Un7x6aFWol1H9vbzKFNdVDxww8BeQerONjbIvuU=; b=311dOEH4gocJ6uZc2Zjec+J6Tg
	TsmhnPAiuy00j1wE0GyhUW8SZ5Z+dKUK8dHixa+5+1rw5XtdMc/xqJWKUVMWhCCmRILFOldDx5uPr
	d4ygVlnV896be5EUotb+WxR8tpn+vVrO2zUpOoANFmLhPm9DbgG7Y5uQNR2gxGxHwaAF4D8eXgawX
	uDxTbt/ykFNs2G7AvKBvmLKRCj4/p8WRG/8zA5eXfsU9/wxSBtVeWY7P6kHpQfhRib8gW3yidkWbR
	mnnTPfthBSsVxiyTldbnTAxwTkFCx3y07anDARkFNtzVAo9zYSZPL70Bf2y6NEhMNVb2/FHC5iMK1
	t7Ejfi4A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpJMb-0000000Epeo-3M7E;
	Mon, 09 Feb 2026 04:59:09 +0000
Message-ID: <9c15a656-b7f0-4187-8e49-1c9e304e39ab@infradead.org>
Date: Sun, 8 Feb 2026 20:59:08 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 06/12] asm-generic: barrier: Add
 smp_cond_load_acquire_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
 harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
 daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
 xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
 <20260209023153.2661784-7-ankur.a.arora@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260209023153.2661784-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/26 6:31 PM, Ankur Arora wrote:
> + * @cond: boolean expression to wait for

  @cond_expr:


-- 
~Randy

