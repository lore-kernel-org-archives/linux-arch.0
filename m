Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UtdvI6Jc"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD4270B;
	Mon, 11 Dec 2023 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yxxoIbJ1ZZJWwjvltM0VXYjCdW6BHXUkXD1dQeD9uKQ=; b=UtdvI6JcEb+Vb3BNiQPYPIdLFU
	OGR8Lbzl0jEaPMjJdIhaF5Y6BdG7cWLAiVQGp3c0xxB9fe8pJqAf67vdWf+cBSiDQiipsxC3Ul5hM
	eib+botFk2Qfa/qssMxN/bVnteDzSOn9HrvUOTwfvrYILEwhedVrnREI+z/UFvkX62iiDqRxYYVHc
	lm395Jb/hQ7MqSAuk5FbM/7/QFXnTxcfRp7YEULpFiFCw0GYWxKC/238uzVvYweGfPCJ+Mm4FK+5O
	vka/P+c98RLXFVFt25UZxz6N7U2MYMll+ZfTz8RZNRw2U7UYISUYQa6RmNr8u7nuT500uzXFhI7fz
	dpcAa1HQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rCimO-005djq-1F;
	Mon, 11 Dec 2023 16:05:12 +0000
Date: Mon, 11 Dec 2023 08:05:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 04/12] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXczOCP8GR4xrkUD@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-5-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-5-samuel.holland@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> + * linux/arch/arm64/include/asm/fpu.h

Same comment as for arm here.  Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
