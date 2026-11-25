Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628115;
	b=CunU7mA3PDOHnTAn6MwCg9r6tMeFoOXzz5OTiOxwAWPTpzoAzVSAphwa4WBOPi8ViJmh
	 MHgl7gslAnMP1IjVjgGoGvvKe5FW8XZBMayfin0s3ETWjqB+9P8rDooIRIKSPg5OMWFl1
	 gAxSeLe0QhLV7LdbQ8Y8WzrEwtVgyfsbvSh1LQYXVsr/wwiVnTfUr3ETwVNT4X3TL5Hjt
	 Xu62zvd8t46HMaDJd6GxA361Z7QfKbHvBkAuhYt8HAN8p8jXZ7gR0JMRV0BN2OIgrWS4U
	 Oxw321d0JjpX1LeIDovUtaO3f7+rEwNsLkpGEfxDRCDmLnVso3qobCIpIpRqlq7gafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628115;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VhHyLFRoMZTTpzK9/qbi2HxQjus7kyc4UtiAeaU33j0=;
	b=IUF+Sn00R3E6B2rHeHCTrF2iSyb+ePQJ299SlFzcpH+hP7dULKKl16+NsWVXe26aiL5V
	 zwGmpWhJI/2LpbqYT+O7AK1LONQMViOW8pEuKXE8ok7cSFqV73KDd234BEg+6RgEOX+9q
	 yw0UUQVlo8li9H8loDhIqzTfeIzlrP2ypRH06RXQ3ywS1pZdxTIPLjZ4MjSSsaAUtVPei
	 CuGXQzl6PozWvqzHatSpZyzqmFMGUJ8yJWgNnlugw7J8EwPvOzIBmS6x1dtG0DonDyxWC
	 Pj43JGXSgWT04cKkzq3b9jMcCzOkICrKbcfy8GBya1X1ENe3CBt9GQVIdaGnXPZlt0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YVxpg//7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB7606A31E;
	Wed, 25 Nov 2026 17:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVxpg//7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E977E1F000C4;
	Wed, 25 Nov 2026 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628115;
	bh=VhHyLFRoMZTTpzK9/qbi2HxQjus7kyc4UtiAeaU33j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVxpg//7XUL6zEg+Rxa4H4eebER+ohBygTeKRTnmnvYPVXxRaLu/XdtfuYX9DnRgd
	 rLao18Zai3T8xA6NyahKhwrdj6yOUV++Az+cNM1fzjtyEybKTBfkdijg151IMOgu5t
	 ZqhrPibPlb9mO1zb0+KfuthXmzZJqB1SwLR9N0gS1uRSYdIolvdTzKpZ7Cl/nMUOn5
	 1UnEuKzP0lsE0rdjZqkn3gKAo6N/H1Oxhy5zb55/muZb2ouaKXJjB4mBC5x1/RyE1k
	 j1Ao5wjAPD44ix9opEzz2iPAqOArQk2pAP58VX1Lf7gnXO9qSQRI0lIArJO48r+hgj
	 O116O9pU6GeVA==
Date: Wed, 25 Nov 2026 09:35:13 -0800
From: Drew Fustini <fustini@kernel.org>
To: "GUO Ren (XuanTie)" <guoren@kernel.org>
Cc: Han Gao <gaohan@iscas.ac.cn>, Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>, Chen Wang <chen.wang@linux.dev>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, sophgo@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Leonardo Bras <leobras@redhat.com>, Yao Zi <me@ziyao.cc>,
	Chen Wang <unicorn_wang@outlook.com>,
	Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Subject: Re: [PATCH v7] riscv: errata: Add ERRATA WRITE_ONCE fixup
Message-ID: <awccUVMi/lSQFfHQ@x1>
References: <20261124-write_once-v7-1-4158a930aa80@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-write_once-v7-1-4158a930aa80@kernel.org>

On Tue, Nov 24, 2026 at 08:35:04AM +0000, GUO Ren (XuanTie) wrote:
> The early version of XuanTie C910 core has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 platform with the qspinlock lock torture
> test.
> 
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
> 
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
> 
> This problem is only observed on the sg2042 hardware platform: it
> takes hours of locktorture stress testing to trigger the livelock
> once, and an interrupt can break the livelock. No user space
> application has been observed to hit this problem, so there is no
> need to modify user space WRITE_ONCE(). The vDSO code runs in user
> space context as well, so its WRITE_ONCE() does not need the errata
> fence either.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> Tested-by: Yao Zi <me@ziyao.cc>
> Cc: Chen Wang <unicorn_wang@outlook.com>
> Cc: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Drew Fustini <fustini@kernel.org>
> Co-developed-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> ---
> Changelog
> 
> v7:
>  - Define BUILD_VDSO for the riscv vDSO build (as arm64, powerpc and
>    others do) and use it to keep the WRITE_ONCE errata alternative out
>    of the vDSO. The vdso getrandom code uses WRITE_ONCE(), so v6 added
>    .alternative entries to the vDSO and booting with
>    CONFIG_DEBUG_VIRTUAL=y hit VIRTUAL_BUG_ON() in vmalloc_to_page(),
>    as reported by Drew Fustini:
>    https://lore.kernel.org/linux-riscv/awPgjwuswbjeDftg@thelio/
>    Fold in Han Gao's "riscv: vdso: Define BUILD_VDSO" patch:
>    https://lore.kernel.org/linux-riscv/20261124-riscv-vdso-build-vdso-v1-1-c52b0b3592dc@iscas.ac.cn/
>  - Clarify in the commit message why user space and the vDSO are not
>    affected by the livelock.
>  - Rebase on v7.4-rc4.

Reviewed-by: Drew Fustini <fustini@kernel.org>

I tried v7 in qemu with -cpu thead-c906 and CONFIG_DEBUG_VIRTUAL=y. It
boots okay and the vdso has no entries in .alternative.

Thanks,
Drew
