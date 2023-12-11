Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifw6UNjU"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50023A9B;
	Mon, 11 Dec 2023 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=voX1j54PoeLMwiQxMkFN5YaL2nBXSYPeTjd4yAFjCQA=; b=ifw6UNjUEDXllsbmZ4AL+dQpRW
	W7b4XK9Kv2/xZ1tcblE7ZfPY/0dMQS0FEvx+i2C6aAE7Zt7MP/UVmUe/mhIExmXNoeKSWR72X4ReC
	icB9zGsV3UObHyUoHkKwukaPk5sKzjyLMManm+Ed1NR3M9AXPCg7SGx6gNkh/lCOKPdmxYNuDiXKe
	+vPv++gGyb9vO0onHi8hOeAukUR55fcRtmV0/FupL1Zz4rC0EOk2DlmrIbKBCnZ1/X9rpJ8qxM7fL
	5WaQwgOsHX/LIFPFPmJ7abBBvtKt5+kdFvtLwoI1y1PYRxUnUZ4Uky9Byl+Nm//eqRAtc8ufLM3GM
	rJYlXhJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCioR-005edf-1j;
	Mon, 11 Dec 2023 16:07:19 +0000
Date: Mon, 11 Dec 2023 08:07:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXczty+Y6dTDL4Xi@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-6-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)

Btw, do we even really need the extra variables for compiler flags
to remove?  Don't gcc/clang options work so that if you add a
no-prefixed version of the option later it transparently gets removed?

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
