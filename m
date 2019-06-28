Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:34756 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfF1XhJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jun 2019 19:37:09 -0400
Subject: Re: [PATCH v3] bpf: fix uapi bpf_prog_info fields alignment
References: <02938ce219d535a8c7c29ce796b3d6ea59c3ed15.1561694925.git.baruch@tkos.co.il>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <db429758-7d5a-4b5c-0bb6-2663dfffac37@iogearbox.net>
Date: Sat, 29 Jun 2019 01:37:03 +0200
MIME-Version: 1.0
In-Reply-To: <02938ce219d535a8c7c29ce796b3d6ea59c3ed15.1561694925.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Baruch Siach <baruch@tkos.co.il>, Alexei Starovoitov <ast@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, "Dmitry V . Levin" <ldv@altlinux.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190628233703.vQdosVngkycyWjoDp8br8cKoUf_3TpHlFawCwPrUFt0@z>

On 06/28/2019 06:08 AM, Baruch Siach wrote:
> Merge commit 1c8c5a9d38f60 ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
> fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
> applications") by taking the gpl_compatible 1-bit field definition from
> commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
> bpf_prog_info") as is. That breaks architectures with 16-bit alignment
> like m68k. Add 31-bit pad after gpl_compatible to restore alignment of
> following fields.
> 
> Thanks to Dmitry V. Levin his analysis of this bug history.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied, thanks!
