Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www62.your-server.de ([213.133.104.62]:55378 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388589AbeLQVDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Dec 2018 16:03:30 -0500
Subject: Re: [PATCH] bpf: promote bpf_perf_event.h to mandatory UAPI header
References: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ffa7d3a4-62be-fb24-b727-8acb029b68fd@iogearbox.net>
Date: Mon, 17 Dec 2018 22:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Message-ID: <20181217210323.62lRgQOJaLFcl6ca09bp2JuM9Pbkk4avQNQbdf2YfVA@z>

On 12/16/2018 04:04 PM, Masahiro Yamada wrote:
> Since commit c895f6f703ad ("bpf: correct broken uapi for
> BPF_PROG_TYPE_PERF_EVENT program type"), all architectures
> (except um) are required to have bpf_perf_event.h in uapi/asm.
> 
> Add it to mandatory-y so "make headers_install" can check it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to bpf, thanks Masahiro!
