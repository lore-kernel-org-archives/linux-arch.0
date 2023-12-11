Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjcBeA1P"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7092B3244;
	Mon, 11 Dec 2023 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NZSOK9WEf75MklfPNXGRllooeOJSKTH5cik2mcCApGk=; b=RjcBeA1PdEk2uyx9kR1h0vqfX4
	d+Yc1bRexIwPfEwXg3ATjowaawQ6wbOG4OgsjFrzg9fZZ0zJjukp6Imd5SFfd6ha0kA/qXRd422Fj
	Nhph1TZ3Pc+KZkOBqTAhjpSdNUTZ4lvJm4jQdxcrZ6EH/+7GL/IpZ/YGrUXp0g36nBp1dXbu+km6G
	+7cIhUBiolRpN6/Ql8tIJaxRM6dJVqbtp3VdZ9gpozS3qBe5ggNJiOclYFTG63FNxCesa9LKP1zlK
	A4pSdsV8BAmR9z2J4zu5mvlp3sRTQk30uEx9FjlxHopEq0ezrXH5BU7JQ5+CFAnadouB17RK0IYsz
	HlvRlvVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCilJ-005dCw-1o;
	Mon, 11 Dec 2023 16:04:05 +0000
Date: Mon, 11 Dec 2023 08:04:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 02/12] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXcy9YUWrC586RX+@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-3-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> --- /dev/null
> +++ b/arch/arm/include/asm/fpu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * linux/arch/arm/include/asm/fpu.h

Please don't add the file name to top of the file comments.  It serves
no purpose and easily gets out of date.

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
