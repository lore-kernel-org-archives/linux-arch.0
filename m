Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:64509 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfBRWkl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 17:40:41 -0500
Date: Mon, 18 Feb 2019 22:40:24 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 7/8] csky: Use latest system call ABI
In-Reply-To: <20190218210712.3503891-8-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1902182239510.480@digraph.polyomino.org.uk>
References: <20190218210712.3503891-1-arnd@arndb.de> <20190218210712.3503891-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Stafford Horne <shorne@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>
Message-ID: <20190218224024.P_eJHES8Wn079VPLeiLer04Hywgb0aNl7XvAne8E8p0@z>

On Mon, 18 Feb 2019, Arnd Bergmann wrote:

> We don't yet have an upstream glibc port for csky, so there is no user

We do.  It's in 2.29.

-- 
Joseph S. Myers
joseph@codesourcery.com
