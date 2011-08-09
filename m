From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/24] C6X: ptrace support
Date: Tue, 9 Aug 2011 18:58:47 +0200
Message-ID: <201108091858.47880.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-18-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59142 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1HIQ6w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 12:58:52 -0400
In-Reply-To: <1312839879-13592-18-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:

> + * Perform ptrace request
> + */
> +long arch_ptrace(struct task_struct *child, long request,
> +		 unsigned long addr, unsigned long data)
> +{
> +	unsigned long __user *datap = (unsigned long __user *) data;
> +	int ret = 0;
> +
> +	switch (request) {
> +	case PTRACE_PEEKUSR:
> +		ret = ptrace_read_user(child, addr,
> +				       (unsigned long __user *) data);
> +		break;
> +
> +		/*
> +		 * write the word at location addr in the user registers.
> +		 */
> +	case PTRACE_POKEUSR:
> +		ret = -EIO;
> +		if (addr & 3 || addr < 0 || addr >= PT_REG_SIZE)
> +			break;
> +
> +		ret = put_reg(child, (int)addr >> 2, data);
> +		break;

I believe you no longer need to provide PTRACE_PEEKUSR/PTRACE_POKEUSR
when you have regset support for all your GPRs.

	Arnd
