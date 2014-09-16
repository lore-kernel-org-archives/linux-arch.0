From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v3 26/29] nios2: ptrace support
Date: Tue, 16 Sep 2014 11:43:21 +0200
Message-ID: <20140916094321.GA4610@distanz.ch>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
 <1410168160-3624-27-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410168160-3624-27-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On 2014-09-08 at 11:22:37 +0200, Ley Foon Tan <lftan@altera.com> wrote:
> Add ptrace support for nios2.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  arch/nios2/include/asm/ptrace.h      |  33 +++++++
>  arch/nios2/include/uapi/asm/ptrace.h | 120 ++++++++++++++++++++++++
>  arch/nios2/kernel/ptrace.c           | 176 +++++++++++++++++++++++++++++++++++
>  3 files changed, 329 insertions(+)
>  create mode 100644 arch/nios2/include/asm/ptrace.h
>  create mode 100644 arch/nios2/include/uapi/asm/ptrace.h
>  create mode 100644 arch/nios2/kernel/ptrace.c
[...]
> diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
> new file mode 100644
> index 0000000..bcbf748
> --- /dev/null
> +++ b/arch/nios2/kernel/ptrace.c
[...]
> +long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
> +		 unsigned long data)
> +{
> +	int ret = -EIO;
> +
> +	pr_debug("REQ=%ld: ADDR =0x%lx, DATA=0x%lx)\n", request, addr, data);
> +
> +	switch (request) {
> +	default:
> +		ret = ptrace_request(child, request, addr, data);
> +		break;
> +	}
> +
> +	return ret;
> +}

This could be simplified to:

long arch_ptrace(struct task_struct *child, long request, unsigned long addr,
		 unsigned long data)
{
	return ptrace_request(child, request, addr, data);
}
