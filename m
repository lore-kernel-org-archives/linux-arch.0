Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="FdZA5oT7"
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 08:19:52 PST
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756512A
	for <linux-arch@vger.kernel.org>; Wed, 13 Dec 2023 08:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1702483992; bh=4XxyHnJEJKkc+5PvBy8tJ98Zzp6SReQrbmR5u3CSVkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FdZA5oT75tJH3PJN0bxT2ijMm1wBFi9fAIDpRIiLKEJ8qcv7c86KrC4Caujnwy/Qz
	 h0yWOBpr5j9YQlGHX6bTEdnz+dQUQ431E11+MzKZsjI9OYJQRIedzGgmfPSOvFDP5W
	 xvNwB4vhFx3KjM5C9g2J1KLykNu0MN4NW1kORqlg=
Received: from [IPV6:240e:388:8d05:a200:783a:c9a8:595e:71d0] (unknown [IPv6:240e:388:8d05:a200:783a:c9a8:595e:71d0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E250E600D1;
	Thu, 14 Dec 2023 00:13:11 +0800 (CST)
Message-ID: <cc762327-796a-481b-9d79-3751361daff8@xen0n.name>
Date: Thu, 14 Dec 2023 00:13:11 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/12] LoongArch: Implement
 ARCH_HAS_KERNEL_FPU_SUPPORT
To: Samuel Holland <samuel.holland@sifive.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-arch@vger.kernel.org
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-7-samuel.holland@sifive.com>
Content-Language: en-US
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20231208055501.2916202-7-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 13:54, Samuel Holland wrote:
> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
> the CFLAGS adjustments.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/loongarch/Kconfig           | 1 +
>   arch/loongarch/Makefile          | 5 ++++-
>   arch/loongarch/include/asm/fpu.h | 1 +
>   3 files changed, 6 insertions(+), 1 deletion(-)

This is all intuitive wrapping, so:

Acked-by: WANG Xuerui <git@xen0n.name>

Thanks!

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

