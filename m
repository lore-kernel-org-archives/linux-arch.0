From: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] bpf: promote bpf_perf_event.h to mandatory UAPI header
Date: Mon, 17 Dec 2018 22:03:23 +0100
Message-ID: <ffa7d3a4-62be-fb24-b727-8acb029b68fd@iogearbox.net>
References: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544972680-4105-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/16/2018 04:04 PM, Masahiro Yamada wrote:
> Since commit c895f6f703ad ("bpf: correct broken uapi for
> BPF_PROG_TYPE_PERF_EVENT program type"), all architectures
> (except um) are required to have bpf_perf_event.h in uapi/asm.
> 
> Add it to mandatory-y so "make headers_install" can check it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to bpf, thanks Masahiro!
